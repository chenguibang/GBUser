//
//  GBUserAPI.m
//  GBUser
//
//  Created by yh on 2017/12/4.
//  Copyright © 2017年 chengb. All rights reserved.
//

#import "GBUserAPI.h"

@implementation GBUserAPI
+ (void)getOSSToken:(void (^)(OSSTaskCompletionSource *, OSSFederationToken *))reult{
    GBUserRequest *loginReq = [GBUserRequest requestWith:nil];
    NSURL * url = [NSURL URLWithString:[loginReq.serverUrl stringByAppendingString:@"/api/ossToken"]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    OSSTaskCompletionSource * tcs = [OSSTaskCompletionSource taskCompletionSource];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionTask * sessionTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        [tcs setError:error];
                                                        return;
                                                    }
                                                    [tcs setResult:data];
                                                }];
    
    [sessionTask resume];
    [tcs.task waitUntilFinished];
    if (tcs.task.error) {
        
        if (reult) {
            reult(tcs,nil);
        }
    } else {
        // 返回数据是json格式，需要解析得到token的各个字段
        NSDictionary * object = [NSJSONSerialization JSONObjectWithData:tcs.task.result
                                                                options:kNilOptions
                                                                  error:nil][@"credentials"];
        OSSFederationToken * token = [OSSFederationToken new];
        token.tAccessKey = [object objectForKey:@"accessKeyId"];
        token.tSecretKey = [object objectForKey:@"accessKeySecret"];
        token.tToken = [object objectForKey:@"securityToken"];
        token.expirationTimeInGMTFormat = [object objectForKey:@"expiration"];
        NSLog(@"get token: %@", token);
        if (reult) {
            reult(tcs,token);
        }
    }
}




+ (void)loginWith:(LoginRequest *)params progress:(void (^)(NSProgress *))downloadProgress success:(void (^)(ApiResponse *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    GBUserRequest *loginReq = [GBUserRequest requestWith:params];
    loginReq.apiInterface = @"/api/login";
    [[APiSessionManager shared] API_GET:loginReq progress:downloadProgress success:success failure:failure];
    
}

+ (void)logoutWith:(NSString *)token  progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(ApiResponse *response))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    GBUserRequest *loginReq = [GBUserRequest requestWith:@{@"token":token ? token : @""}];
    loginReq.apiInterface = @"/api/logout";
    [[APiSessionManager shared] API_GET:loginReq progress:downloadProgress success:success failure:failure];
}

+ (void)getCurrentUserInfoWith:(void (^)(NSProgress *))downloadProgress success:(void (^)(ApiResponse *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    GBUserRequest *requst = [GBUserRequest requestWith:nil];
    requst.showMsg = NO;
    requst.apiInterface = @"/api/userInfo/get";
    [[APiSessionManager shared] API_GET:requst progress:downloadProgress success:success failure:failure];
}

+ (void)getUserInfoWithUserInfoParam:(UserInfoParam *)param progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(ApiResponse *response))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure{
    GBUserRequest *requst = [GBUserRequest requestWith:param];
    requst.showMsg = NO;
    requst.apiInterface = @"/api/userInfo/get";
    [[APiSessionManager shared] API_GET:requst progress:downloadProgress success:success failure:failure];
}

+ (void)modifyUserInfo:(UserInfo *)userInfo progress:(void (^)(NSProgress *))downloadProgress success:(void (^)(ApiResponse *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    GBUserRequest *requst = [GBUserRequest requestWith:userInfo];
    requst.apiInterface = @"/api/userInfo/update";
    [[APiSessionManager shared] API_GET:requst progress:downloadProgress success:success failure:failure];
}


+ (void)bindingWith:(BindingRequest *)params progress:(void (^)(NSProgress *))downloadProgress success:(void (^)(ApiResponse *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    GBUserRequest *requst = [GBUserRequest requestWith:params];
    
    requst.apiInterface = @"/api/binding";
    [[APiSessionManager shared] API_GET:requst progress:downloadProgress success:success failure:failure];
}

+ (void)getAuthInfoWith:(void (^)(NSProgress *))downloadProgress success:(void (^)(ApiResponse *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    GBUserRequest *requst = [GBUserRequest requestWith:nil];
    requst.apiInterface = @"/api/userInfo/getAuths";
    requst.showMsg = NO;
    [[APiSessionManager shared] API_GET:requst progress:downloadProgress success:success failure:failure];
}

@end
