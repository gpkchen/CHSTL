//
//  ZHHud.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/8.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHHud : UIView

/**是否正在显示*/
@property (nonatomic , assign , readonly) BOOL isShowing;

/**hud显示方法(以UIScreen作为父视图)*/
- (void)show;
/**hud显示方法*/
- (void)showInView:(UIView * _Nullable)view;
/**hud消失方法*/
- (void)dismiss;

@end
