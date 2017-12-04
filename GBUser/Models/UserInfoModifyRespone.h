//
//  UserInfoModifyRespone.h
//  BShop
//
//  Created by chenguibang on 2017/8/12.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "APIBaseResponse.h"
#import "UserInfo.h"
@interface UserInfoModifyRespone : APIBaseResponse
@property (nonatomic ,strong) UserInfo *userInfo;
@end
