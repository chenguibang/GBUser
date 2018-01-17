//
//  YTLoginController.m
//  YTApp
//
//  Created by chenguibang on 2017/7/31.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "YTLoginController.h"
#import <AppFoundation/AppFoundation.h>
@interface YTLoginController ()

@end

@implementation YTLoginController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupView];
    self.navigationController.navigationBarHidden = YES;
    @weakify(self)
    [self.loginViewModel.loginSub subscribeNext:^(id  _Nullable x) {
        [self_weak_ dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    [self.loginViewModel.cancleSub subscribeNext:^(id  _Nullable x) {
        [self_weak_ dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
   
  
    
    
    
}


- (void)loginSuccess:(NSNotification *) noti{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)setupView{
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    _loginView = [[YTLoginView alloc]init];
    [self.view addSubview:_loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _loginView.loginViewModel = self.loginViewModel;
}


- (LoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
