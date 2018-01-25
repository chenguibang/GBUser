//
//  UserAuthPlatform.h
//  GBUser
//
//  Created by yh on 2018/1/25.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAuthPlatform : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic ,copy) NSString *userId;
@property (nonatomic ,copy) NSString *accessId;
@property (nonatomic ,copy) NSString *credential;
@property (nonatomic, strong) NSNumber *platform;
@property (nonatomic, strong) NSDate *creattime;

@end
