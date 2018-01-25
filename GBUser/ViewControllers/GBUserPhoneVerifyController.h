//
//  GBUserPhoneVerifyController.h
//  GBUser
//
//  Created by yh on 2018/1/22.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBUserPhoneVerifyController : UIViewController
@property (nonatomic ,strong) UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTextFiled;

@property (nonatomic ,copy) NSString *phone;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
