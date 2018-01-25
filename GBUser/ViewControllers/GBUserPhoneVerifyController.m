//
//  GBUserPhoneVerifyController.m
//  GBUser
//
//  Created by yh on 2018/1/22.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import "GBUserPhoneVerifyController.h"
#import <Masonry/Masonry.h>
#import "GBUserMacros.h"
#import "UserCenterManager.h"
#import "GBUserAPI.h"
@interface GBUserPhoneVerifyController ()

@end

@implementation GBUserPhoneVerifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.phoneLabel.text = self.phone;
    
    _cancleBtn = [[UIButton alloc]init];
    [self.view addSubview:_cancleBtn];
    [_cancleBtn setBackgroundImage:GBUserImage(@"cancle") forState:UIControlStateNormal];
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-15);
    }];
    [_cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogin:) name:AppClientNOTI_LOGIN_SUCEESS object:nil];
}


- (void)didLogin:(NSNotification *)noti{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancleAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)loginAction:(id)sender {
    LoginRequest *loginParam = [[LoginRequest alloc]init];
    loginParam.access_userId = self.phone;
    loginParam.access_token = self.codeTextFiled.text;
    loginParam.paltform = @(1);
    [[UserCenterManager shared] loginWith:loginParam];
    
}

- (IBAction)getCode:(id)sender {
    [GBUserAPI getVerifyCodeWithPhone:self.phone progress:^(NSProgress *progress) {
        
    } success:^(ApiResponse *response) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
