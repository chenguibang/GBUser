//
//  UserPhoneBindVerifyController.m
//  GBUser
//
//  Created by yh on 2018/1/25.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import "UserPhoneBindVerifyController.h"
#import "GBUserAPI.h"
#import <JKCategories/NSString+JKNormalRegex.h>
@interface UserPhoneBindVerifyController ()

@end

@implementation UserPhoneBindVerifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.phoneLabel.text = self.phone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bind:(id)sender {
    BindingRequest *parems = [[BindingRequest alloc]init];
    parems.access_userId = self.phone;
    parems.access_token = self.codeTextFiled.text;
    parems.platform = [self.phone jk_isMobileNumber] ? @(1) : @(2);
    [GBUserAPI bindingWith:parems progress:nil success:^(ApiResponse *response) {
        NSLog(@"绑定成功 %@",response.data);
        [self.userSecurityVM getData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (IBAction)getCode:(id)sender {
    if ([self.phone jk_isMobileNumber]) {
        [GBUserAPI getVerifyCodeWithPhone:self.phone progress:^(NSProgress *progress) {
            
        } success:^(ApiResponse *response) {
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }else  if ([self.phone jk_isEmailAddress]) {
        [GBUserAPI getVerifyCodeWithEmail:self.phone progress:^(NSProgress *progress) {
            
        } success:^(ApiResponse *response) {
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
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
