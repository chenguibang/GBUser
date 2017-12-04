//
//  UserInfoVM.m
//  BShop
//
//  Created by chenguibang on 2017/8/12.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "UserInfoVM.h"
#import "UserCenterManager.h"
#import <NSDate+JKExtension.h>
@implementation UserInfoVM


- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:AppClientNOTI_USERINFO_CHANGE object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [self setData];
        }];
       
    }
    return self;
}


- (void)getData{
    [[UserCenterManager shared] getCurrentUserInfoWith:^(UserInfo *userInfo) {
        [self setData];
    }];
}



- (void)updateUserInfo:(UserInfo *)userInfo{
    [[UserCenterManager shared] modifyUserInfo:userInfo result:^(UserInfo *userInfo) {
         [self setData];
    }];
}



- (void)setData{
    NSTimeInterval _interval=[UserCenterManager shared].currentUser.birthday/ 1000.0;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [objDateformat stringFromDate: date];

    self.menus = @[
                   @[
                       @{
                           @"title":@"头像",
                           @"content":@"修改头像",
                           @"img":[UserCenterManager shared].currentUser.avatar ? [UserCenterManager shared].currentUser.avatar : @""
                           },
                       ],
                   
                   @[
                       
                       @{
                           @"title":@"昵称",
                           @"content":[UserCenterManager shared].currentUser.nickname ? [UserCenterManager shared].currentUser.nickname : @"未设置",
                           @"img":@""
                           },
                       @{
                           @"title":@"性别",
                           @"content":@[@"保密",@"男",@"女"][[UserCenterManager shared].currentUser.sex.intValue],
                           @"img":@""
                           
                           },
                       
                       @{
                           
                           
                           @"title":@"生日",
                           @"content":time,
                           @"img":@""
                           }
                       ],
                   
                   @[
                       @{
                           @"title":@"地址管理",
                           @"content":@"管理地址",
                           @"img":@""
                           
                           },
                       ],
                   ];

}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setData];
}

@end
