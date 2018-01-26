//
//  UserSecurityController.m
//  BShop
//
//  Created by chenguibang on 2017/8/10.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "UserSecurityController.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "UserAuthPlatform.h"
#import "UserPhoneBindController.h"
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
    
    
    NSDictionary *dict = self.userSecurityVM.menus[indexPath.section][indexPath.row];
    if ([dict[@"content"] isEqual:[NSNull null]]) {
        cell.detailTextLabel.text = @"未绑定";
    }else{
        UserAuthPlatform *platForm = self.userSecurityVM.menus[indexPath.section][indexPath.row][@"content"];
        cell.detailTextLabel.text = platForm.userId;
    }
    cell.textLabel.text = dict[@"title"];
    
    return cell;
}

#pragma mark - UITableView_Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.userSecurityVM.menus[indexPath.section][indexPath.row][@"title"];
    
    if ([title isEqualToString:@"手机"]) {
        
        NSDictionary *dict = self.userSecurityVM.menus[indexPath.section][indexPath.row];
        if ([dict[@"content"] isEqual:[NSNull null]]) {
            UserPhoneBindController *userPhoneBindController = [[UserPhoneBindController alloc]initWithNibName:@"UserPhoneBindController" bundle:nil];
            userPhoneBindController.userSecurityVM = self.userSecurityVM;
            [self.navigationController pushViewController:userPhoneBindController animated:YES];
            
        }else{
            UserAuthPlatform *platForm = self.userSecurityVM.menus[indexPath.section][indexPath.row][@"content"];
            
        }
    }
    
    if ([title isEqualToString:@"邮箱"]) {
        
        NSDictionary *dict = self.userSecurityVM.menus[indexPath.section][indexPath.row];
        if ([dict[@"content"] isEqual:[NSNull null]]) {
            UserPhoneBindController *userPhoneBindController = [[UserPhoneBindController alloc]initWithNibName:@"UserPhoneBindController" bundle:nil];
            userPhoneBindController.userSecurityVM = self.userSecurityVM;
            [self.navigationController pushViewController:userPhoneBindController animated:YES];
            
        }else{
            UserAuthPlatform *platForm = self.userSecurityVM.menus[indexPath.section][indexPath.row][@"content"];
            
        }
    }
    
    
    if ([title isEqualToString:@"QQ"]) {
        
        NSDictionary *dict = self.userSecurityVM.menus[indexPath.section][indexPath.row];
        if ([dict[@"content"] isEqual:[NSNull null]]) {
           [self.userSecurityVM bindWith:100];
        }else{
            UserAuthPlatform *platForm = self.userSecurityVM.menus[indexPath.section][indexPath.row][@"content"];
         
        }
        
        
        

    }if ([title isEqualToString:@"微信"]) {
        NSDictionary *dict = self.userSecurityVM.menus[indexPath.section][indexPath.row];
        if ([dict[@"content"] isEqual:[NSNull null]]) {
            [self.userSecurityVM bindWith:101];
        }else{
            UserAuthPlatform *platForm = self.userSecurityVM.menus[indexPath.section][indexPath.row][@"content"];
            
        }
        
    }if ([title isEqualToString:@"新浪微博"]) {
        NSDictionary *dict = self.userSecurityVM.menus[indexPath.section][indexPath.row];
        if ([dict[@"content"] isEqual:[NSNull null]]) {
            [self.userSecurityVM bindWith:102];
        }else{
            UserAuthPlatform *platForm = self.userSecurityVM.menus[indexPath.section][indexPath.row][@"content"];
            
        }
        
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
