//
//  GBUserMacros.h
//  GBUser
//
//  Created by yh on 2018/1/18.
//  Copyright © 2018年 chengb. All rights reserved.
//

#ifndef GBUserMacros_h
#define GBUserMacros_h


#define GBUserBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"GBUserResource" ofType:@"bundle"]]

#define GBUserImage(a) [UIImage imageNamed:a inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"GBUserResource" ofType:@"bundle"]] compatibleWithTraitCollection:nil]
#define GBUserXIBView(name) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"GBUserResource" ofType:@"bundle"]] loadNibNamed:name owner:nil options:nil][0]



#endif /* GBUserMacros_h */
