//
//  UserPhoneBindVerifyController.h
//  GBUser
//
//  Created by yh on 2018/1/25.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSecurityVM.h"
@interface UserPhoneBindVerifyController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *codeTextFiled;
@property (nonatomic ,strong) UserSecurityVM *userSecurityVM;
@property (nonatomic ,copy) NSString *phone;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
