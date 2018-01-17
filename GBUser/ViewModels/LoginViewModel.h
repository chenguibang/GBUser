//
//  LoginViewModel.h
//  YTApp
//
//  Created by chenguibang on 2017/8/1.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface LoginViewModel : NSObject
@property (nonatomic ,strong) LoginModel *loginModel;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *passwd;
@property (nonatomic, assign) BOOL showProgress;

@property (nonatomic, assign) RACSignal* loginEnableSig;
@property (nonatomic, strong) RACSubject *loginSub;
@property (nonatomic, strong) RACSubject *cancleSub;

- (void)login;

- (void)qqLogin;

- (void)weChatLogin;

- (void)weiBoLogin;

@end
