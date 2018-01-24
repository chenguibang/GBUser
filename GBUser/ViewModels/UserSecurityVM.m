//
//  UserSecurityVM.m
//  BShop
//
//  Created by chenguibang on 2017/8/13.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "UserSecurityVM.h"
#import "GBUserAPI.h"
@implementation UserSecurityVM


- (instancetype)init
{
    self = [super init];
    if (self) {
        auth = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                @"未绑定",@"QQ",
                @"未绑定",@"微信",
                nil];
    }
    return self;
}


- (void)bindWith:(int)type{
    BindingRequest *parems = [[BindingRequest alloc]init];
    parems.platform = [NSNumber numberWithInt:type];
    
    SSDKPlatformType platformType = SSDKPlatformTypeQQ;
    if (type == 1) {
        platformType = SSDKPlatformTypeQQ;
    }
    
   else if (type == 2) {
        platformType = SSDKPlatformTypeWechat;
   }else{
       
   }
    
    
    [ShareSDK getUserInfo:platformType
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             
             [GBUserAPI bindingWith:parems progress:nil success:^(ApiResponse *response) {
                 NSLog(@"绑定成功 %@",response.data);
                 [self getData];
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 
             }];
             
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
    
    
 
//    [SSEThirdPartyLoginHelper loginByPlatform:platformType
//                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
//                                       parems.access_token = user.credential.token;
//                                       parems.access_userId = user.uid;
//                                       
//                                       associateHandler (user.uid, user, user);
//                                       [GBUserAPI bindingWith:parems progress:nil success:^(ApiResponse *response) {
//                                           NSLog(@"绑定成功 %@",response.data);
//                                           [self getData];
//                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                                           
//                                       }];
//                                       
//                                   }
//                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
//                                    
//                                    if (state == SSDKResponseStateSuccess)
//                                    {
//                                        
//                                    }
//                                    
//                                }];
}


- (void)getData{
    [self setData];
    [GBUserAPI getAuthInfoWith:nil success:^(ApiResponse *response) {
        if ([response.data[@"code"] intValue] == 200) {
            NSArray *auths = response.data[@"userAuths"];
            for (NSDictionary *dict in auths) {
                int  platform = [dict[@"platform"] intValue];
                if (platform == 1) {
                    [auth setObject:@"已绑定" forKey:@"QQ"];
                }else if (platform == 2){
                    [auth setObject:@"已绑定" forKey:@"微信"];
                }
                [self setData];
            }

        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}



- (void)setData{
    self.menus = @[
              @[
                  @{
                      @"title":@"B商城账号",
                      @"content":@"",
                      @"img":@"cancle"
                      },
                  ],
              
              @[
                  
                  @{
                      @"title":@"手机",
                      @"content":@"",
                      @"img":@""
                      },
                  @{
                      @"title":@"邮箱",
                      @"content":@"",
                      @"img":@""
                      
                      },
                  ],
              
              @[
                  @{
                      @"title":@"QQ",
                      @"content":auth[@"QQ"],
                      @"img":@""
                      
                      },
                  
                  @{
                      @"title":@"微信",
                      @"content":auth[@"微信"],
                      @"img":@""
                      
                      },
                  
                  @{
                      @"title":@"新浪微博",
                      @"content":@"",
                      @"img":@""
                      
                      },
                  ],
              @[
                  @{
                      @"title":@"修改密码",
                      @"content":@"",
                      @"img":@""
                      
                      },
                  ]
              
              
              ];
}




@end
