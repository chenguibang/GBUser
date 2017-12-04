//
//  UserInfo.h
//  TDE
//
//  Created by ceo on 2017/7/13.
//  Copyright © 2017年 chengb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSNumber *sex;
@property (nonatomic, assign) NSTimeInterval birthday;
@property (nonatomic, copy) NSString *city;

@end
