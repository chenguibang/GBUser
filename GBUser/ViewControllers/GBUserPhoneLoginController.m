//
//  GBUserPhoneLoginController.m
//  GBUser
//
//  Created by yh on 2018/1/22.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import "GBUserPhoneLoginController.h"
#import "GBUserPhoneVerifyController.h"
#import "AuthorityView.h"
#import "GBUserAPI.h"
#import <Masonry/Masonry.h>
#import "GBUserMacros.h"
@interface GBUserPhoneLoginController ()

@end

@implementation GBUserPhoneLoginController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    AuthorityView *authorityView = GBUserXIBView(@"AuthorityView");
    authorityView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:authorityView];
    [authorityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
        make.height.equalTo(@90);
    }];
    
    
    _cancleBtn = [[UIButton alloc]init];
    [self.view addSubview:_cancleBtn];
    [_cancleBtn setBackgroundImage:GBUserImage(@"cancle") forState:UIControlStateNormal];
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-15);
    }];
    [_cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [authorityView.qqBtn addTarget:self action:@selector(qqLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    [authorityView.weChatBtn addTarget:self action:@selector(weChatLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    [authorityView.weiBoBtn addTarget:self action:@selector(weiBoLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextAction:(id)sender {
    [GBUserAPI getVerifyCodeWithPhone:self.phoneTextFiled.text progress:^(NSProgress *progress) {
        
    } success:^(ApiResponse *response) {
        GBUserPhoneVerifyController *verifyVC = [[GBUserPhoneVerifyController alloc]initWithNibName:@"GBUserPhoneVerifyController" bundle:GBUserBundle];
        [self.navigationController pushViewController:verifyVC animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
  
}


- (void)qqLogin:(UIButton *)sender{
    [_loginViewModel qqLogin];
}
- (void)weChatLogin:(UIButton *)sender{
    [_loginViewModel weChatLogin];
}
- (void)weiBoLogin:(UIButton *)sender{
    [_loginViewModel weiBoLogin];
}


- (void)loginBtnAction:(UIButton *)sender{
    [_loginViewModel login];
}
- (void)cancleAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    [_loginViewModel.cancleSub sendNext:nil];
}
- (void)phoneLoginAction:(UIButton *)sender{
    [_loginViewModel.phoneLoginSub sendNext:nil];
}


- (LoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
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
