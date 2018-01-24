//
//  GBUserPhoneLoginController.h
//  GBUser
//
//  Created by yh on 2018/1/22.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"
@interface GBUserPhoneLoginController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (nonatomic ,strong) UIButton *cancleBtn;
@property (nonatomic ,strong) LoginViewModel *loginViewModel;
@end
