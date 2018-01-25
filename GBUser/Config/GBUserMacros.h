//
//  GBUserMacros.h
//  GBUser
//
//  Created by yh on 2018/1/18.
//  Copyright © 2018年 chengb. All rights reserved.
//

#ifndef GBUserMacros_h
#define GBUserMacros_h


//#define GBUserBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"GBUserResource" ofType:@"bundle"]]
//#define GBUserImage(a) [UIImage imageNamed:a inBundle:GBUserBundle compatibleWithTraitCollection:nil]
//#define GBUserXIBView(name) [GBUserBundle loadNibNamed:name owner:nil options:nil][0]

//#define GBUserBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"GBUserResource" ofType:@"bundle"]]
#define GBUserBundle [NSBundle mainBundle]
#define GBUserImage(a) [UIImage imageNamed:a]
#define GBUserXIBView(name) [GBUserBundle loadNibNamed:name owner:nil options:nil][0]



#endif /* GBUserMacros_h */
