//
//  YTLoginView.m
//  YTApp
//
//  Created by chenguibang on 2017/7/31.
//  Copyright © 2017年 chenguibang. All rights reserved.
//

#import "YTLoginView.h"
#import <UIView+DBCorner.h>
#import <UIImage+Additions/UIImage+Additions.h>
#import <JKCategories/JKUIKit.h>
#import "AuthorityView.h"
@implementation YTLoginView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}


- (void)setupViews{
    self.backgroundColor = [APPManager shared].theme.viewControllerBackgroundColor;
    WeakSelf(self)
    _content = [[UIImageView alloc]init];
    [self addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself).offset(20);
        make.right.equalTo(weakself).offset(-20);
        make.height.equalTo(@80);
        make.centerY.equalTo(weakself).offset(-64);
    }];
    _content.userInteractionEnabled = YES;
    _content.layer.borderWidth = 1;
    _content.layer.borderColor = [APPManager shared].theme.colorOfTitleSeparate.CGColor;
    
    
    _nameTextFiled = [[GBImageTextFiled alloc]init];
    _nameTextFiled.imageView.image = [UIImage imageNamed:@"contacts_hover"];
    [_content addSubview:_nameTextFiled];
    [_nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_content).offset(10);
        make.right.equalTo(_content).offset(-10);
        make.height.equalTo(@40);
        make.top.equalTo(_content);
    }];
    _nameTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    _nameTextFiled.placeholder = @"请输入账号";
    _nameTextFiled.font = [UIFont systemFontOfSize:14];
    _nameTextFiled.jk_maxLength = 11;
    _passwdTextFiled = [[GBImageTextFiled alloc]init];
    _passwdTextFiled.imageView.image = [UIImage imageNamed:@"contacts_hover"];
    [_content addSubview:_passwdTextFiled];
    [_passwdTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_content).offset(10);
        make.right.equalTo(_content).offset(-10);
        make.height.equalTo(@40);
        make.top.equalTo(_nameTextFiled.mas_bottom);
    }];
    _passwdTextFiled.placeholder = @"请输入密码";
    _passwdTextFiled.font = [UIFont systemFontOfSize:14];
    _passwdTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    
    _loginBtn = [[UIButton alloc]init];
    [self addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_content);
        make.right.equalTo(_content);
        make.top.equalTo(_content.mas_bottom).offset(20);
        make.height.equalTo(@40);
    }];
    
    
    UIView *line = [[UIView alloc]init];
    [_content addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_content).offset(15);
        make.right.equalTo(_content).offset(-15);
        make.centerY.equalTo(_content);
        make.height.equalTo(@1);
    }];
    line.backgroundColor =  [APPManager shared].theme.colorOfTitleSeparate;
    
    
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage add_resizableImageWithColor:[APPManager shared].theme.navigationBarBackgorundColor cornerRadius:5] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _cancleBtn = [[UIButton alloc]init];
    [self addSubview:_cancleBtn];
    [_cancleBtn setBackgroundImage:[UIImage imageNamed:@"cancle"] forState:UIControlStateNormal];
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(self).offset(40);
        make.right.equalTo(self).offset(-15);
    }];
    [_cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    AuthorityView *authorityView = XIB(@"AuthorityView");
    [self addSubview:authorityView];
    [authorityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
        make.height.equalTo(@90);
    }];
    
    [authorityView.qqBtn addTarget:self action:@selector(qqLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    [authorityView.weChatBtn addTarget:self action:@selector(weChatLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    [authorityView.weiBoBtn addTarget:self action:@selector(weiBoLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (void)setLoginViewModel:(LoginViewModel *)loginViewModel{
    _loginViewModel = loginViewModel;
    RAC(_loginViewModel,name) = _nameTextFiled.rac_textSignal;
    RAC(_loginViewModel,passwd) = _passwdTextFiled.rac_textSignal;
    
//    [_loginViewModel.loginEnableSig subscribeNext:^(id  _Nullable x) {
//        _loginBtn.enabled = [x boolValue];
//    }];
    
    [RACObserve(_loginViewModel, showProgress) subscribeNext:^(id  _Nullable x) {
        NSNumber *isShow = x;
        if ([isShow boolValue]) {
            [SVProgressHUD show];
        }else{
            [SVProgressHUD dismiss];
        }
    }];
    
}

- (void)qqLogin:(UIButton *)sender{
    [_loginViewModel qqLogin];
}
- (void)weChatLogin:(UIButton *)sender{
    [_loginViewModel weChatLogin];
}
- (void)weiBoLogin:(UIButton *)sender{
    [_loginViewModel weiBoLogin];
}


- (void)loginBtnAction:(UIButton *)sender{
    [_loginViewModel login];
}
- (void)cancleAction:(UIButton *)sender{
    [_loginViewModel.cancleSub sendNext:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
