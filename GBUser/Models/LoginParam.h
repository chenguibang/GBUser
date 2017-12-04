//
//  LoginParam.h
//  BShop
//
//  Created by chenguibang on 2017/8/10.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginParam : NSObject

@property (nonatomic, copy) NSString *access_userId;
@property (nonatomic, copy) NSString *access_token;

@property (nonatomic ,strong) NSNumber *paltform;
@end
