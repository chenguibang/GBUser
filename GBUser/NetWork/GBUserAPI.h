//
//  GBUserAPI.h
//  GBUser
//
//  Created by yh on 2017/12/4.
//  Copyright © 2017年 chengb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiResponse.h"
#import "ApiResponse.h"
#import "ApiRequest.h"
#import "APiSessionManager.h"
#import <AliyunOSSiOS/OSSService.h>
#import "BindingRequest.h"
#import "LoginRequest.h"
#import "UserInfo.h"
@interface GBUserAPI : NSObject

//登录网络请求
+ (void)loginWith:(LoginRequest *)params progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(ApiResponse *response))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


/**
 退出登录
 
 @param token <#token description#>
 */
+ (void)logoutWith:(NSString *)token progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(ApiResponse *response))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;;


/**
 获取OSStoken
 
 @param reult reult description
 */
+ (void)getOSSToken:(void(^)(OSSTaskCompletionSource *task,OSSFederationToken
                             *token))reult;



/**
 获取当前用户信息
 
 @param downloadProgress downloadProgress description
 @param success success description
 @param failure failure description
 */
+ (void)getCurrentUserInfoWith:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(ApiResponse *response))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


/**
 修改用户信息
 
 @param userInfo userInfo description
 @param downloadProgress downloadProgress description
 @param success success description
 @param failure failure description
 */
+ (void)modifyUserInfo:(UserInfo *)userInfo progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(ApiResponse *response))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


/**
 绑定第三方平台
 
 @param params params description
 @param downloadProgress downloadProgress description
 @param success success description
 @param failure failure description
 */
+ (void)bindingWith:(BindingRequest *)params  progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(ApiResponse *response))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


/**
 获取授权信息
 
 @param downloadProgress downloadProgress description
 @param success success description
 @param failure failure description
 */
+ (void)getAuthInfoWith:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(ApiResponse *response))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


@end
