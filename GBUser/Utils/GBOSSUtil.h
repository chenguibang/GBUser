//
//  OSSUtil.h
//  BShop
//
//  Created by chenguibang on 2017/8/10.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import <UIKit/UIKit.h>
@interface GBOSSUtil : NSObject
@property (nonatomic ,strong) OSSClient * client;
+ (instancetype)shared;




+ (void)uploadImage:(UIImage *)image
             bucket:(NSString *)bucket
          objectKey:(NSString*)objectKey
     uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress
             result:(void(^)(OSSTask *task ,NSString *url))result;


+ (NSString *)imageUrlWith:(UIImage *)image
              bucket:(NSString *)bucket
            endpoint:(NSString *)endpoint
           objectKey:(NSString *)objectKey
                    ;
;


@end
