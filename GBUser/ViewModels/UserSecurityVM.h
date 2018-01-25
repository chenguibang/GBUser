//
//  UserSecurityVM.h
//  BShop
//
//  Created by chenguibang on 2017/8/13.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ShareSDK/ShareSDK.h>

#import "BindingRequest.h"

#import <GBNetWork/ApiResponse.h>
@interface UserSecurityVM : NSObject{
    NSArray *auths;
}
@property (nonatomic ,strong) NSArray *menus;
- (void)bindWith:(int)type;

- (void)getData;

@end
