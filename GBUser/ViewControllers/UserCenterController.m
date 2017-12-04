//
//  UserCenterController.m
//  BShop
//
//  Created by chenguibang on 2017/8/10.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "UserCenterController.h"
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import "UserSettingController.h"
#import "YTLoginController.h"
@interface UserCenterController ()

@end

@implementation UserCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}


- (void)setupView{
    UIBarButtonItem *setBtn = [[UIBarButtonItem alloc] bk_initWithImage:UIImageWithNamed(@"setting") style:UIBarButtonItemStyleDone handler:^(id sender) {
       UserSettingController *userSettingController = [UserSettingController new];
        userSettingController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userSettingController animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = setBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[YTLoginController new]] animated:YES completion:^{
        
    }];

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
