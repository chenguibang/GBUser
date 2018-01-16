//
//  GBUserRequest.m
//  GBUser
//
//  Created by yh on 2017/12/5.
//  Copyright © 2017年 chengb. All rights reserved.
//

#import "GBUserRequest.h"
#import "UserCenterManager.h"
@implementation GBUserRequest

+ (instancetype)requestWith:(id)paramters{
    GBUserRequest *request = [[GBUserRequest alloc]init];
    request.paramters = paramters;
    return request;
}

- (NSString *)token{
    return [UserCenterManager shared].currentToken;
}

- (NSString *)serverUrl{
//    NSAssert(([UserCenterManager shared].host == nil )|| ([UserCenterManager shared].port == nil), @"服务器地址不能为空");
    return [NSString stringWithFormat:@"http://%@:%@",[UserCenterManager shared].host,[UserCenterManager shared].port];
}

@end
