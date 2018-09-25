//
//  GameScene.m
//  QdtGame
//
//  Created by qiuzijie on 2018/5/7.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "GameScene.h"

@interface GameScene()<SKPhysicsContactDelegate>
@property (nonatomic, assign) NSInteger indexOfCharacter;
@property (nonatomic, strong) UIImageView *foodIMG;
@property (nonatomic, strong) SKNode *handleNode;
@property (nonatomic, assign) CGPoint handleNodePosition;
@property (nonatomic, assign) NSInteger eatCount;
@property (nonatomic, assign) NSInteger coninCount;
@end

static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

@implementation GameScene

- (void)didMoveToView:(SKView *)view{
    view.showsFPS = YES;
    view.showsNodeCount = YES;
    SKAudioNode *audio = [[SKAudioNode alloc] initWithFileNamed:@"beijing.mp3"];
    audio.autoplayLooped = YES;
    [self addChild:audio];
    [self configPhysicsWorld];
    [self configBasicNode];
}

- (void)configPhysicsWorld{
    self.physicsWorld.contactDelegate = self;           // 碰撞代理
    self.physicsWorld.gravity = CGVectorMake(0, -9);    // 重力大小
    self.scaleMode = SKSceneScaleModeAspectFit;         // 缩放模式
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.restitution = 0.9;
    self.physicsBody.friction = 0.2;
}

- (void)addGesture{

}

- (void)configBasicNode{
    SKSpriteNode *characterNode = [self characterAnimationNodeIsEat:NO];
//    self.foodIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"food1"]];
//    [self.view addSubview:self.foodIMG];
//    self.foodIMG.frame = CGRectMake(100, 200, 50, 50);
    
//    characterNode.position = CGPointMake(0,-200);
}

- (void)generatePanel:(NSDictionary *)dic{
    
}

- (void)update:(NSTimeInterval)currentTime{
    
}

#pragma mark- Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    NSArray *nodes = [self nodesAtPoint:location];
    for (SKSpriteNode *node in nodes) {
        if ([node.name isEqual:@"food"]) {
            _handleNode = node;
            _handleNodePosition = node.position;
            [_handleNode runAction:[SKAction scaleTo:1.5 duration:0.3] completion:^{
            }];
            break;
        } else if ([node.name isEqualToString:@"character"]){
            return;
        } else if ([node.name isEqualToString:@"tujianbutton"]){
            SKSpriteNode *tujian = (SKSpriteNode *)[self childNodeWithName:@"tujian"];
            tujian.alpha = 1;
            return;
        } else if ([node.name isEqualToString:@"guanbitujian"]){
            SKSpriteNode *tujian = (SKSpriteNode *)[self childNodeWithName:@"tujian"];
            tujian.alpha = 0;
            return;
        } else if ([node.name isEqualToString:@"guanbishangdian"]){
            SKSpriteNode *shangdian = (SKSpriteNode *)[self childNodeWithName:@"shangdian"];
            shangdian.alpha = 0;
            return;
        } else if ([node.name isEqualToString:@"yuanbaopanel"]){
            SKSpriteNode *shangdian = (SKSpriteNode *)[self childNodeWithName:@"shangdian"];
            shangdian.alpha = 1;
            return;
        } else if ([node.name isEqualToString:@"yuanbao"]){
//            [self collectConins:node];
            return;
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_handleNode != nil) {
        _handleNode.position = [[touches anyObject] locationInNode:self];
        
        //        NSLog(@"h:[%f,%f]",_handleNode.position.x,_handleNode.position.y);
    } else {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        NSArray *nodes = [self nodesAtPoint:location];
        for (SKSpriteNode *node in nodes) {
            if ([node.name isEqualToString:@"yuanbao"]) {
                [self collectConins:node];
            };
        }
    }

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if (_handleNode != nil) {
        SKSpriteNode *character = (SKSpriteNode *)[self childNodeWithName:@"character"];
        if ([character intersectsNode:_handleNode] && [self currentLevel] != 3) {
            [self characterAnimationNodeIsEat:YES];
            SKAudioNode *audio = [[SKAudioNode alloc] initWithFileNamed:@"chi.mp3"];
            audio.autoplayLooped = YES;
            [self addChild:audio];
            self.eatCount++;
            [_handleNode runAction:[SKAction scaleTo:0 duration:0.4] completion:^{
                [audio removeFromParent];
                [self performSelector:@selector(characterAnimationNodeIsEat:) withObject:@NO afterDelay:1];
            }];
            
        } else {
            [_handleNode runAction:[SKAction scaleTo:1 duration:0.2] completion:^{
                
            }];
            SKAction *group = [SKAction group:@[[SKAction scaleTo:1 duration:0.2],
                              [SKAction moveTo:self.handleNodePosition duration:0.3]]];
            [_handleNode runAction:group];
        }

        _handleNode = nil;
    }
}

#pragma mark- Action
- (void)coninsAction{
    if (![self actionForKey:@"coninsAction"]) {
        SKAction *makeRocks = [SKAction sequence: @[//重复执行一段代码
                                                    [SKAction performSelector:@selector(addConin) onTarget:self],
                                                    [SKAction waitForDuration:2 withRange:0.35]
                                                    ]];
        [self runAction:[SKAction repeatActionForever:makeRocks] withKey:@"coninsAction"];
    };
}

- (void)endCoinsAction{
    [self removeActionForKey:@"coninsAction"];
}

- (void)addConin{
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithImageNamed:@"yuanbao"];
    SKSpriteNode *character = [self characterNode];
    rock.size = CGSizeMake(30, 20);
    rock.position = CGPointMake(character.position.x, character.position.y+50);
    rock.name = @"yuanbao";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.density = 0.1;
    rock.physicsBody.allowsRotation = YES;
    rock.physicsBody.velocity = CGVectorMake(skRand(-200,200), 500);
//    rock.zRotation = skRand(-200,200);
    [rock runAction:[SKAction rotateToAngle:skRand(5,15) duration:0.6]];
//    [rock.physicsBody applyTorque:100];
//    [rock.physicsBody applyImpulse:CGVectorMake(200, -10)];
    [self addChild:rock];
}

- (void)collectConins:(SKSpriteNode *)node{

    SKSpriteNode *yuanbaopanel = (SKSpriteNode *)[self childNodeWithName:@"yuanbaopanel"];
    SKAction *moveAction = [SKAction moveTo:yuanbaopanel.position duration:0.3];
    SKAction *alphaAction = [SKAction fadeOutWithDuration:0.2];
    node.physicsBody = nil;
    node.userInteractionEnabled = NO;
    
    SKAudioNode *audio = [[SKAudioNode alloc] initWithFileNamed:@"ding.m4a"];
    audio.autoplayLooped = NO;
    [audio runAction:[SKAction play]];
    [node addChild:audio];
    
    [node runAction:[SKAction sequence:@[moveAction,alphaAction]] completion:^{
        [node removeFromParent];
        [audio removeFromParent];
    }];
    self.coninCount++;
    SKLabelNode *label = (SKLabelNode *)[self childNodeWithName:@"//yuanbaocount"];
    label.text = [NSString stringWithFormat:@"%ld",self.coninCount];
}

#pragma mark- Node

- (SKSpriteNode *)characterNode{
    SKSpriteNode *character = (SKSpriteNode *)[self childNodeWithName:@"chacracter"];
    return character;
}

- (SKSpriteNode *)characterAnimationNodeIsEat:(BOOL)flag{
    NSString *frameName = @"";
    NSInteger count = 0;
    
    switch ([self currentLevel]) {
        case 0:
            if (flag) {
                frameName = @"chaoren-tiny-Eat_";
                count = 13;
            } else {
                frameName = @"chaoren-tiny-An1_";
                count = 17;
            }
            break;
        case 1:
            if (flag) {
                frameName = @"chaoren-middle-Eat_";
                count = 12;
            } else {
                frameName = @"chaoren-middle-An1_";
                count = 21;
            }
            break;
        case 2:
            if (flag) {
                frameName = @"chaoren-fat-Eat_";
                count = 16;
            } else {
                frameName = @"chaoren-fat-An1_";
                count = 21;
            }
            break;
        case 3:
            frameName = @"chaoren-fat-end_";
            count = 16;
            [self coninsAction];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.eatCount--;
                [self endCoinsAction];
                [self characterAnimationNodeIsEat:NO];
            });
            break;
    }
    
    NSArray *frames = [self animationFramesForImageNamePrefix:frameName frameCount:count];
    SKSpriteNode *sprite = (SKSpriteNode *)[self childNodeWithName:@"character"];
    sprite.texture = frames[0];
    sprite.size = ((SKTexture *)frames[0]).size;
    SKAction *animateFramesAction = [SKAction animateWithTextures:frames
                                                     timePerFrame:1.0/frames.count];
    [sprite runAction:[SKAction repeatActionForever:animateFramesAction]];
    return sprite;
}

- (NSArray *)animationFramesForImageNamePrefix: (NSString*) baseImageName frameCount: (NSInteger) count
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (int i = 1; i<= count; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"%@%d.png",baseImageName, i];
        SKTexture *t = [SKTexture textureWithImageNamed:imageName];
        [array addObject:t];
        
    }
    return array;
}

- (NSInteger)currentLevel{
    NSInteger level = 0;
    if (self.eatCount < 2) {
        level = 0;
    } else if (self.eatCount < 4){
        level = 1;
    } else if (self.eatCount < 6){
        level = 2;
    } else {
        level = 3;
    }
    return level;
}

@end












