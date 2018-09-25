//
//  LoginViewController.m
//  QdtGame
//
//  Created by qiuzijie on 2018/5/7.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import <SpriteKit/SpriteKit.h>
#import "DataScene.h"
#import "DaKaViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *loginImageView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginGame)];
    self.loginImageView.userInteractionEnabled = YES;
    [self.loginImageView addGestureRecognizer:tap];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.view != self.loginImageView) {
        [self.textField resignFirstResponder];
    }
}

- (void)beginGame{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        DaKaViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DaKaViewController"];
        [self presentViewController:vc animated:NO completion:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
