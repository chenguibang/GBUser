//
//  BaseResponse.h
//  FilmInfo
//
//  Created by chenguibang on 2017/10/25.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject
@property (nonatomic ,copy) NSString *errMsg;
@property (nonatomic ,copy) NSString *errType;
@property (nonatomic ,assign) id data;
@end
