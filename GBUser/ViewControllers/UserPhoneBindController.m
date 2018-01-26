//
//  UserPhoneBindController.m
//  GBUser
//
//  Created by yh on 2018/1/25.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import "UserPhoneBindController.h"
#import "GBUserAPI.h"
#import "UserPhoneBindVerifyController.h"
#import "GBUserMacros.h"
#import <JKCategories/NSString+JKNormalRegex.h>
@interface UserPhoneBindController ()

@end

@implementation UserPhoneBindController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)next:(id)sender {
        
    if ([self.phoneTextFiled.text jk_isMobileNumber]) {
        [GBUserAPI getVerifyCodeWithPhone:self.phoneTextFiled.text progress:^(NSProgress *progress) {
            
        } success:^(ApiResponse *response) {
            UserPhoneBindVerifyController *verifyVC = [[UserPhoneBindVerifyController alloc]initWithNibName:@"UserPhoneBindVerifyController" bundle:GBUserBundle];
            verifyVC.userSecurityVM = self.userSecurityVM;
            verifyVC.phone = self.phoneTextFiled.text;
            [self.navigationController pushViewController:verifyVC animated:YES];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }else  if ([self.phoneTextFiled.text jk_isEmailAddress]) {
        [GBUserAPI getVerifyCodeWithEmail:self.phoneTextFiled.text progress:^(NSProgress *progress) {
            
        } success:^(ApiResponse *response) {
            UserPhoneBindVerifyController *verifyVC = [[UserPhoneBindVerifyController alloc]initWithNibName:@"UserPhoneBindVerifyController" bundle:GBUserBundle];
            verifyVC.userSecurityVM = self.userSecurityVM;
            verifyVC.phone = self.phoneTextFiled.text;
            [self.navigationController pushViewController:verifyVC animated:YES];
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
