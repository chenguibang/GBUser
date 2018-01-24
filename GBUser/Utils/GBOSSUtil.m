//
//  OSSUtil.m
//  BShop
//
//  Created by chenguibang on 2017/8/10.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "GBOSSUtil.h"
#import <SDWebImage/SDImageCache.h>
#import "GBUserAPI.h"

@implementation GBOSSUtil

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static GBOSSUtil *shareInstatnce;
    dispatch_once(&onceToken, ^{
        shareInstatnce = [[self alloc]init];
    });
    return shareInstatnce;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {

           __block OSSFederationToken *osstoken;
        
            [GBUserAPI getOSSToken:^(OSSTaskCompletionSource *task, OSSFederationToken *token) {
                osstoken = token;
            }];
        
            return osstoken;
          
        }];
        NSString *  endPoint = @"https://oss-cn-shanghai.aliyuncs.com";
        self.client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    }
    return self;
}




+ (void)uploadImage:(UIImage *)image
             bucket:(NSString *)bucket
          objectKey:(NSString*)objectKey
     uploadProgress:(OSSNetworkingUploadProgressBlock)uploadProgress
             result:(void(^)(OSSTask *task ,NSString *url))result{
    OSSClient *client = [GBOSSUtil shared].client;
    
    [[SDImageCache sharedImageCache] storeImage:image forKey:objectKey completion:^{
        NSString *url = [[SDImageCache sharedImageCache] defaultCachePathForKey:objectKey];
        OSSPutObjectRequest * put = [OSSPutObjectRequest new];
        put.bucketName = bucket;
        put.uploadingFileURL = [NSURL fileURLWithPath:url];
        
        
        put.objectKey = objectKey;
        put.uploadProgress = uploadProgress;
        OSSTask * putTask = [client putObject:put];
        [putTask continueWithBlock:^id(OSSTask *task) {
            NSLog(@"objectKey: %@", put.objectKey);
            if (!task.error) {
                
                NSString *remoteUrl = [self imageUrlWith:image bucket:bucket endpoint:client.endpoint objectKey:objectKey];
                NSLog(@"upload object success! remote URL : %@",remoteUrl);
                if (result) {
                    result(task,remoteUrl);
                }
                
            } else {
                if (result) {
                    result(task,nil);
                } 
            }
            return nil;
        }];
    }];;
}






+ (NSString *)imageUrlWith:(UIImage *)image bucket:(NSString *)bucket endpoint:(NSString *)endpoint objectKey:(NSString *)objectKey{
//    http://bucket.<endpoint>/object?x-oss-process=image/action,parame_value
    return [NSString stringWithFormat:@"https://%@.%@/%@?size=%d.%d",bucket,@"oss-cn-shanghai.aliyuncs.com",objectKey,(int)image.size.width,(int)image.size.height];
    
}
@end
