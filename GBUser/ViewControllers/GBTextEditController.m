//
//  GBTextEditController.m
//  BShop
//
//  Created by chenguibang on 2017/8/11.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "GBTextEditController.h"
#import <AppFoundation/AppFoundation.h>
#import "GBTextEditController.h"
#import <UITextField+GBExt.h>
#import "UserCenterManager.h"

@interface GBTextEditController ()

@end

@implementation GBTextEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupView];
    
  
}

- (void)setupView{
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] bk_initWithTitle:@"完成" style:UIBarButtonItemStyleDone handler:^(id sender) {
        UserInfo *userInfo = [[UserInfo alloc]init];
        userInfo.nickname = self.textFiled.text;
;
        [[UserCenterManager shared] modifyUserInfo:userInfo result:^(UserInfo *userInfo) {
            if (userInfo) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
        
    }];
    self.navigationItem.rightBarButtonItem = doneBtn;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
