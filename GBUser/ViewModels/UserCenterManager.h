//
//  UserCenterManager.h
//  GBUser
//
//  Created by yh on 2017/12/4.
//  Copyright © 2017年 chengb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginRequest.h"
#import "UserInfo.h"
#import "UserInfoRespone.h"
#import "UserInfoModifyRespone.h"
#define AppClientNOTI_LOGIN_SUCEESS  @"AppClientNOTI_LOGIN_SUCEESS" //登录成功
#define AppClientNOTI_LOGIN_FAILE  @"AppClientNOTI_LOGIN_FAILE" //登录失败
#define AppClientNOTI_USERINFO_CHANGE  @"AppClientNOTI_USERINFO_CHANGE" //用户信息更新
@interface UserCenterManager : NSObject<NSCoding>{
    NSString * _currentToken;
}
@property (nonatomic ,strong) UserInfo *currentUser;
@property (nonatomic ,copy) NSString *rc_token;
@property (nonatomic ,copy) NSString *currentToken;
@property (nonatomic ,copy) NSString *host;
@property (nonatomic ,copy) NSString *port;

+ (instancetype)shared;


/**
 设置服务器相关信息

 @param host host description
 @param port port description
 */
- (void)setupWith:(NSString *)host port:(NSString *)port;

/**
 注册
 
 @param name name description
 @param passwd passwd description
 
 */
- (void)regisetWith:(NSString *)name passwd:(NSString *)passwd;




/**
 登录接口
 
 @param params params description
 */
- (void)loginWith:(LoginRequest *)params;



/**
 登录
 
 @param name 用户名
 @param passwd 密码
 */
- (void) loginWith:(NSString *)name
            passwd:(NSString *)passwd;


/**
 退出登录 ,退出登录时候应该将相应的 用户信息清除，推送用用相关信息清除，融云聊天相关信息清除
 */
- (void) logout;


/**
 退出登录
 
 @param token token description
 */
- (void)logoutWith:(NSString *)token;



/**
 清除用户信息
 */
- (void)clearUserInfo;


/**
 获取当前用户
 @return return value description
 */
- (UserInfo *)getCurrentUserInfo;




/**
 通过Token 获取用户信息
 
 @param token token
 @param reuslt reuslt description
 */
- (void)getUserInfoWith:(NSString *)token reuslt:(void(^)(UserInfo *userInfo))reuslt;


/**
 通过userId 获取用户信息
 
 @param token token
 @param reuslt reuslt description
 */
- (void)getUserInfoWithUserId:(NSString *)userId reuslt:(void(^)(UserInfo *userInfo))reuslt;


/**
 获取当前用户信息
 
 @param reuslt reuslt description
 */
- (void)getCurrentUserInfoWith:(void(^)(UserInfo *userInfo))reuslt;


/**
 从服务器重新拉去用户信息
 
 @param reuslt reuslt description
 */
- (void)updateCurrentUserInfoWith:(void(^)(UserInfo *userInfo))reuslt;




/**
 修改用户信息
 
 @param userInfo userInfo description
 @param reuslt reuslt description
 */
- (void)modifyUserInfo:(UserInfo *)userInfo result:(void(^)(UserInfo *userInfo))reuslt;



@end
