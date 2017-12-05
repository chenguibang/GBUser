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

@end
