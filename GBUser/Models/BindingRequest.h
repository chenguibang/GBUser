//
//  BindingRequest.h
//  BShop
//
//  Created by chenguibang on 2017/8/13.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "APIBaseRequest.h"

@interface BindingRequest : APIBaseRequest
@property (nonatomic ,copy) NSString *access_userId;
@property (nonatomic ,copy) NSString *access_token;
@property (nonatomic ,strong) NSNumber *platform;


@end
