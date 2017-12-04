//
//  UserSettingController.m
//  BShop
//
//  Created by chenguibang on 2017/8/10.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "UserSettingController.h"
#import "UserInfoController.h"
#import "UserSecurityController.h"
#import "UserCenterManager.h"
@interface UserSettingController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *menus;
}

@end

@implementation UserSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView{
    self.title = @"设置";
    
    
//    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    [self.view addSubview:self.tableView];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//     [_tableView setContentOffset:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    menus = @[
              @[
                  @{
                      @"title":@"个人信息"
                      }
                  ],
              
              @[
                  @{
                      @"title":@"账号安全"
                      }
                  ],
              
              
              @[
                  @{
                      @"title":@"通用"
                      }
                  ],
              
              @[
                  @{
                      @"title":@"帮助与反馈"
                      },
                  @{
                      @"title":@"关于B商城"
                      },
                  ],
              
              @[
                  @{
                      @"title":@"退出登录"
                      }
                  ],
              
              ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableView_DataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return menus.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [menus[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = menus[indexPath.section][indexPath.row][@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

#pragma mark - UITableView_Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = menus[indexPath.section][indexPath.row][@"title"];
    if ([title isEqualToString:@"个人信息"]) {
        [self.navigationController pushViewController:[UserInfoController new] animated:YES];
    }else if ([title isEqualToString:@"账号安全"]) {
        [self.navigationController pushViewController:[UserSecurityController new] animated:YES];
    }else if ([title isEqualToString:@"退出登录"]) {
        [[UserCenterManager shared] logout];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
