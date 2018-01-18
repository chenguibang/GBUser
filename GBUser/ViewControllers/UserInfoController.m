//
//  UserInfoController.m
//  BShop
//
//  Created by chenguibang on 2017/8/10.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "UserInfoController.h"
#import <GBSexPickView.h>
#import <GBDatePickerView.h>
#import "GBTextEditController.h"
#import <PortraitPicker.h>
#import <Photos/PHFetchOptions.h>
#import <Photos/Photos.h>
#import <SDImageCache.h>
#import <AliyunOSSiOS/OSSService.h>
#import "GBOSSUtil.h"
#import "UserHeaderCell.h"
#import <UIImageView+WebCache.h>
#import "UserCenterManager.h"
#import <UIImage+JKSuperCompress.h>

@interface UserInfoController (){

}

@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    
    [RACObserve(self.userInfoVM, menus) subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
    }];
    
    [self.userInfoVM getData];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView{
    self.title = @"个人信息";
    [self.tableView registerNib:[UINib nibWithNibName:@"UserHeaderCell" bundle:GBUserBundle] forCellReuseIdentifier:@"UserHeaderCell"];
}


#pragma mark - UITableView_DataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.userInfoVM.menus.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.userInfoVM.menus[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UserHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserHeaderCell" forIndexPath:indexPath];
        cell.textLabel.text = self.userInfoVM.menus[indexPath.section][indexPath.row][@"title"];
        cell.detailTextLabel.text = @"";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfoVM.menus[indexPath.section][indexPath.row][@"img"]]];
        [cell.contentView bringSubviewToFront:cell.headerImageView];
        return cell;
    }
    
    
    
    
    
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
  
    cell.textLabel.text = self.userInfoVM.menus[indexPath.section][indexPath.row][@"title"];
    cell.detailTextLabel.text = self.userInfoVM.menus[indexPath.section][indexPath.row][@"content"];
    return cell;
}

#pragma mark - UITableView_Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.userInfoVM.menus[indexPath.section][indexPath.row][@"title"];
    if ([title isEqualToString:@"性别"]) {
        GBSexPickView *sexPicker = GBUserXIBView(@"GBSexPickView");
        sexPicker.sexPickResult = ^(NSInteger index, NSString *sexName) {
            UserInfo *userInfo = [[UserInfo alloc]init];
            userInfo.sex = @[@(1),@(2),@(0)][index];
            [self.userInfoVM updateUserInfo:userInfo];
        };
        [sexPicker showAt:self];
    }else if ([title isEqualToString:@"生日"]) {
        GBDatePickerView *timePicker = GBUserXIBView(@"GBDatePickerView");
        timePicker.datePicker.datePickerMode = UIDatePickerModeDate;
        [timePicker pickTimeAt:self];
        timePicker.datePickResult = ^(NSTimeInterval timestamp) {
            UserInfo *userInfo = [[UserInfo alloc]init];
            userInfo.birthday = timestamp;
            [self.userInfoVM updateUserInfo:userInfo];
        };
        
    }
    
    else if ([title isEqualToString:@"昵称"]) {
        
        GBTextEditController *textEditor = [[GBTextEditController alloc] initWithNibName:@"GBTextEditController" bundle:nil];
        textEditor.title = @"修改昵称";
        textEditor.textFiled.placeholder = @"请修改昵称";
        [self.navigationController pushViewController:textEditor animated:YES];
        
    }
    
    else if ([title isEqualToString:@"头像"]) {
        
        PortraitPicker *portraitPicker = [[PortraitPicker alloc]init];
        [portraitPicker pickImage:YES atBase:self complete:^(NSMutableArray *selectedPhotos, NSMutableArray *selectedAssets) {
            [SVProgressHUD showWithStatus:@"上传中"];
            UIImage *image = selectedPhotos[0];
        
            int x = arc4random() % 100000;
            NSString *objectKey = [NSString stringWithFormat:@"123546875654/%d.jpg",x];
            [GBOSSUtil uploadImage: [UIImage imageWithData:[UIImage jk_compressImage:image toMaxLength:0.5*1024*1024 maxWidth:500]] bucket:@"bshop-user" objectKey:objectKey uploadProgress:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
//                [SVProgressHUD showProgress:totalBytesSent/totalBytesExpectedToSend];
            } result:^(OSSTask *task, NSString *url) {
                UserInfo *userInfo = [[UserInfo alloc]init];
                userInfo.avatar = url;
                [self.userInfoVM updateUserInfo:userInfo];
                [SVProgressHUD showInfoWithStatus:@"上传成功"];
            }];
    
        }];
        
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }else{
        return 44;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (UserInfoVM *)userInfoVM{
    if (!_userInfoVM) {
        _userInfoVM = [[UserInfoVM alloc]init];
    }
    return _userInfoVM;
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
