//
//  UserSecurityController.m
//  BShop
//
//  Created by chenguibang on 2017/8/10.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "UserSecurityController.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
@interface UserSecurityController (){
   
}

@end

@implementation UserSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
    [RACObserve(self.userSecurityVM, menus) subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
    }];
    
    [self.userSecurityVM getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)setupView{
    self.title = @"账号安全";
    
    

   }


#pragma mark - UITableView_DataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.userSecurityVM.menus.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.userSecurityVM.menus[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.userSecurityVM.menus[indexPath.section][indexPath.row][@"title"];
    cell.detailTextLabel.text = self.userSecurityVM.menus[indexPath.section][indexPath.row][@"content"];
    return cell;
}

#pragma mark - UITableView_Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.userSecurityVM.menus[indexPath.section][indexPath.row][@"title"];
    if ([title isEqualToString:@"QQ"]) {
        [self.userSecurityVM bindWith:1];

    }if ([title isEqualToString:@"微信"]) {
        [self.userSecurityVM bindWith:2];
        
    }
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}





- (UserSecurityVM *)userSecurityVM{
    if (!_userSecurityVM) {
        _userSecurityVM = [[UserSecurityVM alloc]init];
    }
    return _userSecurityVM;
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
