//
//  UserCenterManager.m
//  GBUser
//
//  Created by yh on 2017/12/4.
//  Copyright © 2017年 chengb. All rights reserved.
//

#import "UserCenterManager.h"
#import "GBUserAPI.h"
#import <MJExtension/MJExtension.h>
#define ENCODE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/app.data"]
@implementation UserCenterManager
MJCodingImplementation
+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static UserCenterManager *shareInstance = nil;
    dispatch_once(&onceToken, ^{
        UserCenterManager *app = [NSKeyedUnarchiver unarchiveObjectWithFile:ENCODE_PATH];
        if (!app) {
            shareInstance = [[UserCenterManager alloc]init];
            [NSKeyedArchiver archiveRootObject:shareInstance toFile:ENCODE_PATH];
        }else{
            shareInstance = app;
        }
    });
    return shareInstance;
}



- (void)loginWith:(LoginRequest *)params{
    [GBUserAPI loginWith:params progress:^(NSProgress *progress) {
        
    } success:^(ApiResponse *response) {
        int code = [response.data[@"code"] intValue];
        if (code == 200) {
            self.currentUser = nil;
            self.currentToken = response.data[@"user_token"];
            self.rc_token = response.data[@"rc_token"];
            [[NSNotificationCenter defaultCenter] postNotificationName:AppClientNOTI_LOGIN_SUCEESS object:response];
            if([NSKeyedArchiver archiveRootObject:self toFile:ENCODE_PATH]){
                NSLog(@"用户归档成功");
            }
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:AppClientNOTI_LOGIN_FAILE object:response];
        }
        [NSKeyedArchiver archiveRootObject:self toFile:ENCODE_PATH];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:AppClientNOTI_LOGIN_FAILE object:error];
    }];
}

/**
 注册
 
 @param name name description
 @param passwd passwd description
 
 */
- (void)regisetWith:(NSString *)name passwd:(NSString *)passwd{
    
}


/**
 登录
 
 @param name 用户名
 @param passwd 密码
 */
- (void) loginWith:(NSString *)name
            passwd:(NSString *)passwd{
    
}


/**
 退出登录 ,退出登录时候应该将相应的 用户信息清除，推送用用相关信息清除，融云聊天相关信息清除
 */
- (void) logout{
    [self logoutWith:self.currentToken];
}

- (void)logoutWith:(NSString *)token{
    [GBUserAPI logoutWith:token progress:nil success:^(ApiResponse *response) {
        [self clearUserInfo];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)clearUserInfo{
    self.currentToken = nil;
    self.currentUser = nil;
    self.rc_token = nil;
    if([NSKeyedArchiver archiveRootObject:self toFile:ENCODE_PATH]){
        NSLog(@"用户归档成功");
    }
}


- (void)getUserInfoWith:(NSString *)token reuslt:(void (^)(UserInfo *))reuslt{
    //TODU
    if (self.currentUser) {
        if (reuslt) {
            reuslt(self.currentUser);
        }
        return;
    }
}

- (void)getUserInfoWithUserId:(NSString *)userId reuslt:(void(^)(UserInfo *userInfo))reuslt{
    UserInfoParam *parm = [[UserInfoParam alloc]init];
    parm.userId = userId;
    [GBUserAPI getUserInfoWithUserInfoParam:parm progress:^(NSProgress *progress) {
        
    } success:^(ApiResponse *response) {
        UserInfoRespone *data = [UserInfoRespone mj_objectWithKeyValues:response.data];
        if ([data.code intValue] == 200) {
            UserInfo *user = data.userInfo;
            if (reuslt) {
                reuslt(user);
            }
        }else{
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)getCurrentUserInfoWith:(void (^)(UserInfo *))reuslt{
    if (self.currentUser) {
        if (reuslt) {
            reuslt(self.currentUser);
        }
        return;
    }else{
        [self updateCurrentUserInfoWith:reuslt];
        
    }
}

- (void)updateCurrentUserInfoWith:(void (^)(UserInfo *))reuslt{
    [GBUserAPI getCurrentUserInfoWith:^(NSProgress *progress) {
        
    } success:^(ApiResponse *response) {
        UserInfoRespone *data = [UserInfoRespone mj_objectWithKeyValues:response.data];
        if ([data.code intValue] == 200) {
            self.currentUser = data.userInfo;
            if (reuslt) {
                reuslt(self.currentUser);
            }
        }else{
            if (reuslt) {
                reuslt(nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (reuslt) {
            reuslt(nil);
        }
    }];
    
}



- (void)modifyUserInfo:(UserInfo *)userInfo result:(void (^)(UserInfo *))reuslt{
    [GBUserAPI modifyUserInfo:userInfo progress:^(NSProgress *progress) {
        
    } success:^(ApiResponse *response) {
        UserInfoModifyRespone *data = [UserInfoModifyRespone mj_objectWithKeyValues:response.data];
        
        if ([data.code intValue] == 200) {
            
            self.currentUser = data.userInfo;
            [[NSNotificationCenter defaultCenter] postNotificationName:AppClientNOTI_USERINFO_CHANGE object:self.currentUser];
            if (reuslt) {
                reuslt(self.currentUser);
            }
        }else{
            if (reuslt) {
                reuslt(nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (reuslt) {
            reuslt(nil);
        }
    }];
}


/**
 获取当前用户
 @return return value description
 */
- (UserInfo *)getCurrentUserInfo{
    return nil;
}


- (void)setCurrentToken:(NSString *)currentToken{
    _currentToken = currentToken;
    [[NSUserDefaults standardUserDefaults] setObject:currentToken forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)currentToken{
    NSString *localToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    return localToken;
}

@end
