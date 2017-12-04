//
//  YTLoginController.h
//  YTApp
//
//  Created by chenguibang on 2017/7/31.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTLoginView.h"
#import "LoginViewModel.h"
@interface YTLoginController : UIViewController
@property (nonatomic ,strong) YTLoginView *loginView;
@property (nonatomic ,strong) LoginViewModel *loginViewModel;
@end
