//
//  TodayViewController.m
//  TodayViewController
//
//  Created by 王文杰 on 16/10/12.
//  Copyright © 2016年 王文杰. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "UIView+Extension.h"
#import "RoundView.h"
#import "WaterView.h"
@interface TodayViewController () <NCWidgetProviding>{
    
    WaterView *_WaterView;
    
    RoundView *_roundView;
    
    UILabel * DataTagLb;
    
}
@end
#pragma mark - 宿主App与扩展App进行数据共享
/**
 *
 宿主app进行数据持久
 - (void)setAppGroup
 {
 
    UserInfo *userInfo = [UserInfoContext sharedUserInfoContext].userInfo;//无视即可
 
    NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.cn.10086.shandongmcc"];
    [userDefault setBool:userInfo.isLogin forKey:@"islogin"];
    [userDefault setObject:userInfo.phoneNumber forKey:@"phoneNumber"];
 
 }
 扩展app进行数据读取
 - (void)getAppGroup
 {
 
    NSUserDefaults *myDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.cn.10086.shandongmcc"];
 
 }
 */

#pragma mark - 配置共享与证书（开启共享示例图工程目录TodayViewController->figureImage->figure_1）
/**
 *
    1.在工程iOSToday->TARGETS->Gapabilities->App Groups 开启数据共享组（宿主App和扩展App都要开启）
    2.扩展App要去申请AppIDs,生成开发和生产描述文件,宿主App配置相对应的证书,扩展App配置相对应证书（扩展App Bundle identifier 不能与宿主App相同,）
    3.生成AppIDs勾选App Groups（宿主App和扩展App都要勾选）
 
 */
@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //防止视同重叠
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //读取宿主app持久化的数据
    NSUserDefaults *myDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.cn.10086.shandongmcc"];
    //判断登录状态（没有登录状态 你们自己分别调用看效果就好啦）
    if ([[myDefaults objectForKey:@"islogin"] integerValue]== 1) {
        [self IsLoggedIn];
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
    }else{
        [self NotLoggedIn];
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 150);
    }
}

-(void)IsLoggedIn{
    //手机号
    //读取宿主app持久化的数据
    NSUserDefaults *myDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.cn.10086.shandongmcc"];
    
    UILabel * MobilePhoneLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, (self.view.bounds.size.width-40)/2, 20)];
    //取出手机号赋值
    MobilePhoneLb.text = [NSString stringWithFormat:@"欢迎您:%@",[myDefaults objectForKey:@"phoneNumber"]];
    MobilePhoneLb.textColor = [UIColor whiteColor];
    MobilePhoneLb.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:MobilePhoneLb];
    
    //刷新时间点
    DataTagLb = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-40)/2, 10, (self.view.bounds.size.width-40)/2, 20)];
    DataTagLb.text = [NSString stringWithFormat:@"%@",@"更新至-月-日 -:-"];
    DataTagLb.textColor = [UIColor whiteColor];
    DataTagLb.font = [UIFont systemFontOfSize:11];
    DataTagLb.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:DataTagLb];
    
    //刷新按钮
    UIButton * refreshBt = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(DataTagLb.frame)+10, 13, 15, 15)];
    [refreshBt setBackgroundImage:[UIImage imageNamed:@"sx"] forState:UIControlStateNormal];
    [refreshBt addTarget:self action:@selector(refreshBtClock:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBt];
    
    
    //进度说明
    UIView *useTag = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(MobilePhoneLb.frame)+10, 10, 10)];
    useTag.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:useTag];
    
    UILabel *useTagLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(useTag.frame)+5, CGRectGetMaxY(MobilePhoneLb.frame)+10, 100, 10)];
    useTagLb.text = @"已使用进度";
    useTagLb.font = [UIFont systemFontOfSize:10];
    useTagLb.textColor = [UIColor whiteColor];
    [self.view addSubview:useTagLb];
    
    
    
    UIView *remainingTag = [[UIView alloc]initWithFrame:CGRectMake(useTag.frame.origin.x, useTag.frame.origin.y+20, 10, 10)];
    remainingTag.backgroundColor = [UIColor blackColor];
    [self.view addSubview:remainingTag];
    
    UILabel *remainingTagLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(remainingTag.frame)+5, useTag.frame.origin.y+20, 100, 10)];
    remainingTagLb.text = @"剩余进度";
    remainingTagLb.font = [UIFont systemFontOfSize:10];
    remainingTagLb.textColor = [UIColor whiteColor];
    [self.view addSubview:remainingTagLb];
    
    
    NSArray * ValueArray = @[@0.5,@0.8];
    //流量球
    for (int i = 0; i<2; i++) {
        RoundView *roundView = [[RoundView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-250)/2+(i*110+i*40), CGRectGetMaxY(DataTagLb.frame)+10, 110, 110)];
        roundView.LineW = 3;
        roundView.percent = [ValueArray[i] floatValue];
        [self.view addSubview:roundView];
        
        _WaterView = [[WaterView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-250)/2+(i*110+i*40), CGRectGetMaxY(DataTagLb.frame)+10, 100, 100) withHigh:50];
        _WaterView.layer.cornerRadius = 100 / 2;
        _WaterView.layer.masksToBounds = YES;
        _WaterView.isopen = NO;
        _WaterView.percent = [ValueArray[i] floatValue];
        roundView.center = _WaterView.center;
        [self.view addSubview:_WaterView];
        
        
        UILabel *generalLb = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-250)/2+(i*110+i*40), roundView.frame.origin.y+20, _WaterView.frame.size.width,20)];
        generalLb.textAlignment = NSTextAlignmentCenter;
        generalLb.textColor = [UIColor whiteColor];
        generalLb.font = [UIFont systemFontOfSize:14];
        generalLb.text = @"剩余通用";
        [self.view addSubview:generalLb];
        
        
        UILabel *percentageLb = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-250)/2+(i*110+i*40), CGRectGetMaxY(generalLb.frame)+5, _WaterView.frame.size.width, 20)];
        percentageLb.textAlignment = NSTextAlignmentCenter;
        percentageLb.textColor = [UIColor whiteColor];
        percentageLb.font = [UIFont systemFontOfSize:18];
        percentageLb.text = [NSString stringWithFormat:@"%.1f%%",[ValueArray[i] floatValue]*100];
        [self.view addSubview:percentageLb];
        
        
        UILabel *remainingLb = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-250)/2+(i*110+i*40), CGRectGetMaxY(percentageLb.frame)+5, _WaterView.frame.size.width, 20)];
        remainingLb.textAlignment = NSTextAlignmentCenter;
        remainingLb.textColor = [UIColor whiteColor];
        remainingLb.font = [UIFont systemFontOfSize:14];
        remainingLb.text = @"580.88M";
        [self.view addSubview:remainingLb];
        
        
    }
    
    for (int i = 0; i<3; i++) {
        UIButton * BillBt = [[UIButton alloc]initWithFrame:CGRectMake(30+(((self.view.bounds.size.width-120)/3)*i+(i*30)), CGRectGetMaxY(_WaterView.frame)+15, (self.view.bounds.size.width-120)/3, 30)];
        [BillBt setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"today%d",i+1]] forState:UIControlStateNormal];
        [BillBt addTarget:self action:@selector(BUttonClick:) forControlEvents:UIControlEventTouchUpInside];
        BillBt.tag = i;
        [self.view addSubview:BillBt];
        
    }
    
    
    
}
-(void)refreshBtClock:(UIButton * )Bt{
    
    //获取当前时间
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"MM/dd hh:mm:ss"];
    NSString *currentDate = [formater stringFromDate:[NSDate date]];
    
    NSArray *tempstr1 = [currentDate componentsSeparatedByString:@" "];
    
    NSArray * tempstr2 = [tempstr1[0] componentsSeparatedByString:@"/"];
    
    
    DataTagLb.text = [NSString stringWithFormat:@"更新至%@月%@日 %@",tempstr2[0],tempstr2[1],tempstr1[1]];
    
    
}
#pragma mark - 唤醒App 进行页面跳转
/**
    - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{}
 
 
    可在AppDelegate此方法中监听到App唤醒Url,根据Url判断进行页面跳转

 */
//点击按钮跳转页面
- (void)BUttonClick:(UIButton *)Bt{
    UIButton* button = (UIButton*)Bt;
    
    if (button.tag == 0) {
        [self.extensionContext openURL:[NSURL URLWithString:@"sdmcc://WWJBillqueryViewController"] completionHandler:^(BOOL success) {
            
            NSLog(@"open url result:%d",success);
        }];
    }
    else if(button.tag == 1) {
        [self.extensionContext openURL:[NSURL URLWithString:@"sdmcc://http://m.sd.10086.cn/sdActivity/activityCenter/goCheckAppType.do?value=activity"] completionHandler:^(BOOL success) {
            
            NSLog(@"open url result:%d",success);
        }];
    }
    else if(button.tag == 2) {
        [self.extensionContext openURL:[NSURL URLWithString:@"sdmcc://CCChargeViewController"] completionHandler:^(BOOL success) {
            
            NSLog(@"open url result:%d",success);
        }];
    }
}
-(void)NotLoggedIn{
    
    UILabel * TitleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.view.bounds.size.width, 20)];
    TitleLb.text = @"登录客户端,实时监控流量使用进度";
    TitleLb.textAlignment = NSTextAlignmentCenter;
    TitleLb.textColor = [UIColor whiteColor];
    TitleLb.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:TitleLb];
    
    UIButton * loginBt = [[UIButton alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-200)/2, CGRectGetMaxY(TitleLb.frame)+15, 200, 30)];
    loginBt.backgroundColor = [UIColor colorWithRed:35/255.0 green:168/255.0 blue:254/255.0 alpha:1];
    [loginBt setTitle:@"立即体验" forState:UIControlStateNormal];
    [loginBt.layer setCornerRadius:5.0];
    [loginBt addTarget:self action:@selector(loginBtButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginBt];
    
    for (int i = 0; i<3; i++) {
        UIButton * BillBt = [[UIButton alloc]initWithFrame:CGRectMake(30+(((self.view.bounds.size.width-120)/3)*i+(i*30)), CGRectGetMaxY(loginBt.frame)+20, (self.view.bounds.size.width-120)/3, 30)];
        [BillBt setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"today%d",i+1]] forState:UIControlStateNormal];
        [BillBt addTarget:self action:@selector(BUttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:BillBt];
        
    }
}
-(void)loginBtButtonClick:(UIButton *)Bt{
    
    [self.extensionContext openURL:[NSURL URLWithString:@"sdmcc://LoginViewController"] completionHandler:^(BOOL success) {
        
        NSLog(@"open url result:%d",success);
    }];
    
    
}


- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    
    return UIEdgeInsetsZero;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}


@end
