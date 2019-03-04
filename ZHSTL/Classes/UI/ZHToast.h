//
//  ZHToast.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/9.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**提示框控件*/
@interface ZHToast : UIWindow

+ (void)showWithTitle:(NSString *)title centerY:(CGFloat)centerY completion:(void(^)(void))completion;
+ (void)showWithTitle:(NSString *)title completion:(void(^)(void))completion;
+ (void)showWithTitle:(NSString *)title centerY:(CGFloat)centerY;
+ (void)showWithTitle:(NSString *)title;

@end
