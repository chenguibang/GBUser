//
//  YTLoginView.h
//  YTApp
//
//  Created by chenguibang on 2017/7/31.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppFoundation/GBImageTextFiled.h>
#import "LoginViewModel.h"
@interface YTLoginView : UIView
@property (nonatomic ,strong) LoginViewModel *loginViewModel;
@property (nonatomic, strong) UIImageView *content;
@property (nonatomic ,strong) GBImageTextFiled *nameTextFiled;
@property (nonatomic ,strong) GBImageTextFiled *passwdTextFiled;
@property (nonatomic ,strong) UIButton *loginBtn;
@property (nonatomic ,strong) UIButton *cancleBtn;
@end
