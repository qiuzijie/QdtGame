//
//  DaKaViewController.m
//  QdtGame
//
//  Created by qiuzijie on 2018/5/13.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "DaKaViewController.h"
#import "MBProgressHUD.h"
#import <SpriteKit/SpriteKit.h>
#import "DataScene.h"

@interface DaKaViewController ()

@end

@implementation DaKaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"还未下班打卡" message:@"是否进行打卡操作" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:confirm];
    [alert addAction:cancel];
    [self presentViewController:alert animated:NO completion:^{
        ;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)beginGame:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES].label.text = @"打卡成功";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        SKView *sView = [[SKView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:sView];
        DataScene *scene = (DataScene *)[SKScene nodeWithFileNamed:@"DataScene"];
        [sView presentScene:scene];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
