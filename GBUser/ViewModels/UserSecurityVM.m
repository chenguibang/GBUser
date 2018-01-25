//
//  UserSecurityVM.m
//  BShop
//
//  Created by chenguibang on 2017/8/13.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "UserSecurityVM.h"
#import "GBUserAPI.h"
#import "UserAuthPlatform.h"
#import <MJExtension/MJExtension.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@implementation UserSecurityVM


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)bindWith:(int)type{
    BindingRequest *parems = [[BindingRequest alloc]init];
    parems.platform = [NSNumber numberWithInt:type];
    
    
    
    
    SSDKPlatformType platformType = SSDKPlatformTypeQQ;
    if (type == 100) {
        platformType = SSDKPlatformTypeQQ;
    }
    
   else if (type == 101) {
        platformType = SSDKPlatformTypeWechat;
   } else if (type == 102) {
       platformType = SSDKPlatformTypeSinaWeibo;
   }else{
       
   }
    
    
    
    [SSEThirdPartyLoginHelper loginByPlatform:platformType
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       NSLog(@"uid=%@",user.uid);
                                       NSLog(@"%@",user.credential);
                                       NSLog(@"token=%@",user.credential.token);
                                       NSLog(@"nickname=%@",user.nickname);
                                       parems.access_userId = user.uid;
                                       parems.access_token = user.credential.token;
                                       
                                       [GBUserAPI bindingWith:parems progress:nil success:^(ApiResponse *response) {
                                           NSLog(@"绑定成功 %@",response.data);
                                           [self getData];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
                                       
                                       
                                       associateHandler (user.uid, user, user);
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        
                                    }
                                    
                                }];
    
//    [ShareSDK getUserInfo:platformType
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//     {
//         if (state == SSDKResponseStateSuccess)
//         {
//
//             NSLog(@"uid=%@",user.uid);
//             NSLog(@"%@",user.credential);
//             NSLog(@"token=%@",user.credential.token);
//             NSLog(@"nickname=%@",user.nickname);
//             parems.access_userId = user.uid;
//             parems.access_token = user.credential.token;
//
//             [GBUserAPI bindingWith:parems progress:nil success:^(ApiResponse *response) {
//                 NSLog(@"绑定成功 %@",response.data);
//                 [self getData];
//             } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//             }];
//
//         }
//
//         else
//         {
//             NSLog(@"%@",error);
//         }
//
//     }];
    
    
}


- (void)getData{
    [self setData];
    [GBUserAPI getAuthInfoWith:nil success:^(ApiResponse *response) {
        if ([response.data[@"code"] intValue] == 200) {
            auths = [UserAuthPlatform mj_objectArrayWithKeyValuesArray:response.data[@"userAuths"]];
            [self setData];
     
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}

- (UserAuthPlatform *)platformInfoFor:(NSNumber *)platform{
    for (UserAuthPlatform *item in auths) {
        if ([item.platform isEqualToNumber:platform]) {
            return item;
        }
    }
    return nil;
}


- (void)setData{
    self.menus = @[
              @[
                  @{
                      @"title":@"应用账号",
                      @"content":[self platformInfoFor:@(0)] ? [self platformInfoFor:@(0)] : [NSNull null],
                      @"img":@"cancle"
                      },
                  ],
              
              @[
                  
                  @{
                      @"title":@"手机",
                      @"content":[self platformInfoFor:@(1)] ? [self platformInfoFor:@(1)] : [NSNull null],
                      @"img":@""
                      },
                  @{
                      @"title":@"邮箱",
                      @"content":[self platformInfoFor:@(2)] ? [self platformInfoFor:@(2)] : [NSNull null],
                      @"img":@""
                      
                      },
                  ],
              
              @[
                  @{
                      @"title":@"QQ",
                      @"content":[self platformInfoFor:@(100)] ? [self platformInfoFor:@(100)] : [NSNull null],
                      @"img":@""
                      
                      },
                  
                  @{
                      @"title":@"微信",
                      @"content":[self platformInfoFor:@(101)] ? [self platformInfoFor:@(101)] : [NSNull null],
                      @"img":@""
                      
                      },
                  
                  @{
                      @"title":@"新浪微博",
                      @"content":[self platformInfoFor:@(102)] ? [self platformInfoFor:@(102)] : [NSNull null],
                      @"img":@""
                      
                      },
                  ],
              @[
                  @{
                      @"title":@"修改密码",
                      @"content":[NSNull null],
                      @"img":@""
                      
                      },
                  ]
              
              
              ];
}




@end
