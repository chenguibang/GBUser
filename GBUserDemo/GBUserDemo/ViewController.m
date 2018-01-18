//
//  ViewController.m
//  GBUserDemo
//
//  Created by yh on 2018/1/17.
//  Copyright © 2018年 chengb. All rights reserved.
//

#import "ViewController.h"
#import <GBUser/YTLoginController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)login:(id)sender {
    [self presentViewController:[[YTLoginController alloc] init]   animated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
