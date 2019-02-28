//
//  UIAlertView+Extension.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/6/19.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertViewActionBlock)(NSInteger index);

@interface UIAlertView (Extension)

- (UIAlertView *)initWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSArray *)otherButtonTitles
                   clickAction:(UIAlertViewActionBlock)clickAction;

@end
