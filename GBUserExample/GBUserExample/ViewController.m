//
//  ViewController.m
//  GBUserExample
//
//  Created by yh on 2018/1/16.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import "ViewController.h"
#import <GBUser/UserSettingController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.navigationController pushViewController:[YTLoginController new] animated:YES];
    
    [self presentViewController:[[UserSettingController alloc] init] animated:YES completion:^{
        
    }];
}

@end
