//
//  LoginViewModel.m
//  YTApp
//
//  Created by chenguibang on 2017/8/1.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "LoginViewModel.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import "APiSessionManager.h"
#import "ApiRequest.h"
#import "LoginRequest.h"
#import <MJExtension/MJExtension.h>
#import "UserCenterManager.h"
@interface LoginViewModel(){
    
}
@property (nonatomic, strong) LoginRequest *loginParam;
@end


@implementation LoginViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



- (void)login{
//[[ApiTool shared] testApi];
    
    
    self.loginParam.access_userId = self.name;
    self.loginParam.access_token = self.passwd;
    self.loginParam.paltform = @(0);
    [self sendLogin];
    
   
   
}

- (void)sendLogin{
    [[UserCenterManager shared] loginWith:self.loginParam];
    
}


- (void)qqLogin{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       NSLog(@"登录的id == %@",user.uid);
                                       self.loginParam.access_userId = user.uid;
                                       self.loginParam.paltform = @(1);
                                       self.loginParam.access_token = user.credential.token;
                                       [self sendLogin];
                                       associateHandler (user.uid, user, user);
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        
                                    }
                                    
                                }];
}

- (void)weChatLogin{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       NSLog(@"登录的id == %@",user.uid);
                                       self.loginParam.access_userId = user.uid;
                                       self.loginParam.paltform = @(2);
                                       self.loginParam.access_token = user.credential.token;
                                       [self sendLogin];
                                       associateHandler (user.uid, user, user);
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        
                                    }
                                    
                                }];
}

- (void)weiBoLogin{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeSinaWeibo
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       NSLog(@"登录的id == %@",user.uid);
                                       
                                       associateHandler (user.uid, user, user);
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        
                                    }
                                    
                                }];
}


- (RACSignal *)loginEnableSig{
    if (!_loginEnableSig) {
        RACSignal *nameSig = RACObserve(self, name);
        RACSignal *passwdSig = RACObserve(self, passwd);
        _loginEnableSig = [RACSignal
                           combineLatest:@[nameSig, passwdSig]
                           reduce:^id(NSString *userName, NSString *password){
                               return @(userName.length >= 3 && password.length >= 3);
                           }];
    }
    return _loginEnableSig;
    
}


- (RACSubject *)loginSub{
    if (!_loginSub) {
        _loginSub = [RACSubject subject];
    }
    return _loginSub;
}

- (RACSubject *)cancleSub{
    if (!_cancleSub) {
        _cancleSub = [RACSubject subject];
    }
    return _cancleSub;
}

- (LoginModel *)loginModel{
    if (!_loginModel) {
        _loginModel = [[LoginModel alloc]init];
    }
    return _loginModel;
}

- (LoginRequest *)loginParam{
    if (!_loginParam) {
        _loginParam = [[LoginRequest alloc]init];
    }
    return _loginParam;
}
@end
