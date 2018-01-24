//
//  GBUserPhoneVerifyController.m
//  GBUser
//
//  Created by yh on 2018/1/22.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import "GBUserPhoneVerifyController.h"
#import <Masonry/Masonry.h>
#import "GBUserMacros.h"
@interface GBUserPhoneVerifyController ()

@end

@implementation GBUserPhoneVerifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _cancleBtn = [[UIButton alloc]init];
    [self.view addSubview:_cancleBtn];
    [_cancleBtn setBackgroundImage:GBUserImage(@"cancle") forState:UIControlStateNormal];
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-15);
    }];
    [_cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancleAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
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
