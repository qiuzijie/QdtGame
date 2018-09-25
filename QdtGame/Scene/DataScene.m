//
//  DataScene.m
//  QdtGame
//
//  Created by qiuzijie on 2018/5/13.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "DataScene.h"
#import "GameScene.h"

@interface DataScene ()

@end

@implementation DataScene

- (void)didMoveToView:(SKView *)view{
    [super didMoveToView:view];
    SKAudioNode *audio = [[SKAudioNode alloc] initWithFileNamed:@"beijing.mp3"];
    audio.autoplayLooped = YES;
    [self addChild:audio];
    [self showData];
}

- (void)showData{
    SKSpriteNode *panelNode = (SKSpriteNode *)[self childNodeWithName:@"panel"];
    NSArray *datas = [self datas];
    NSArray *counts = @[@"x5",@"x5",@"x1",@"x1",@"x2",@"x1",@"x1",@"x2",@"x1"];
    for (NSInteger i = 0; i < datas.count ; i++) {
        SKLabelNode *lal = [SKLabelNode labelNodeWithFontNamed:@"HanziPen SC"];
        lal.fontSize = 20;
        lal.text = datas[i];
        lal.alpha = 0;
        lal.blendMode = SKBlendModeAdd;
        if (i >= 5) {
            lal.position = CGPointMake(400, -i%5*40-50);
        } else {
            lal.position = CGPointMake(150, -i%5*40-50);
        }

        [panelNode addChild:lal];
        [lal runAction:[SKAction sequence:@[[SKAction waitForDuration:i*0.6],
                                            [SKAction fadeInWithDuration:0.6]]]];
        
        SKSpriteNode *foodCount = [SKSpriteNode node];
        foodCount.xScale = 0.5;
        foodCount.yScale = 0.5;
        foodCount.alpha = 0;
        foodCount.position = CGPointMake(CGRectGetMaxX(lal.frame)+20, lal.position.y+10);
        [panelNode addChild:foodCount];

        SKSpriteNode *food = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"food_%ld",i%8]];
        food.size = CGSizeMake(25, 25);
        food.position = CGPointMake(0, 0);
        [foodCount addChild:food];

        SKLabelNode *count = [SKLabelNode labelNodeWithText:counts[i]];
        count.fontName = @"HanziPen SC";
        count.fontSize = 16;
        count.position = CGPointMake(food.size.width, 0);
        [foodCount addChild:count];
        
        [foodCount runAction:[SKAction sequence:@[[SKAction waitForDuration:(i+1)*0.6],
                                             [SKAction fadeInWithDuration:0.2],
                                             [SKAction scaleTo:1 duration:0.2]]]];
    }
    SKSpriteNode *gold = (SKSpriteNode *)[self childNodeWithName:@"//gold"];
    [gold runAction:[SKAction sequence:@[[SKAction waitForDuration:datas.count*0.6],
                                          [SKAction fadeInWithDuration:0.4]]]];
    
    SKSpriteNode *zhenbang = (SKSpriteNode *)[self childNodeWithName:@"//zhenbang"];
    [zhenbang runAction:[SKAction sequence:@[[SKAction waitForDuration:datas.count*0.6],
                                         [SKAction fadeInWithDuration:0.2]]]];
    
    SKSpriteNode *loading = (SKSpriteNode *)[self childNodeWithName:@"//loading"];
    [loading runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:0.5 duration:0.1]]];
    
    SKLabelNode *beginLabel = (SKLabelNode *)[self childNodeWithName:@"//beginlabel"];
    [beginLabel runAction:[SKAction sequence:@[[SKAction waitForDuration:datas.count*0.6],
                                               [SKAction fadeInWithDuration:0.2]]]completion:^{
        [loading removeFromParent];
    }];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    NSArray *nodes = [self nodesAtPoint:location];
    for (SKSpriteNode *node in nodes) {
        if ([node.name isEqualToString:@"begin"]) {
            GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"gameScene"];
            [self.view presentScene:scene];
        }
    }
}

- (NSArray *)datas{
    NSArray *array = @[@"上班打卡",@"下班打卡",@"日报提交",@"里程：3.1公里",@"步数：6254步",@"拜访门店：4家",@"销售开单：2笔",@"位置上报：5次",@"发布动态：2条"];
    return array;
}

@end
