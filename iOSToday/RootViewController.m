//
//  RootViewController.m
//  iOSToday
//
//  Created by 王文杰 on 16/10/12.
//  Copyright © 2016年 王文杰. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAppGroup];
}
#pragma mark - 宿主App与扩展App进行数据共享
- (void)setAppGroup
{
    
    NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.cn.10086.shandongmcc"];
    [userDefault setBool:YES forKey:@"islogin"];
    [userDefault setObject:@"13552539636" forKey:@"phoneNumber"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
