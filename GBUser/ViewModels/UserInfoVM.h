//
//  UserInfoVM.h
//  BShop
//
//  Created by chenguibang on 2017/8/12.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
@interface UserInfoVM : NSObject
@property (nonatomic, strong) NSArray *menus;
- (void)getData;



- (void)updateUserInfo:(UserInfo *)userInfo;

@end
