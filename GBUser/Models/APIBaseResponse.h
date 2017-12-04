//
//  APIBaseResponse.h
//  BShop
//
//  Created by chenguibang on 2017/8/12.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIBaseResponse : NSObject
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, copy) NSString *msg;
@end
