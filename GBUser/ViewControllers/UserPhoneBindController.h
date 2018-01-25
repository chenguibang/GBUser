//
//  UserPhoneBindController.h
//  GBUser
//
//  Created by yh on 2018/1/25.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSecurityVM.h"
@interface UserPhoneBindController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic ,strong) UserSecurityVM *userSecurityVM;
@end
