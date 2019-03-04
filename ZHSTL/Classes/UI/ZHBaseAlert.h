//
//  ZHBaseAlert.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/29.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**消失回调*/
typedef void (^ZHBaseAlertDismissBlock)(void);

/**警告框基础类（实现一些基础的动画与事件，用于继承）*/
@interface ZHBaseAlert : UIView

/**是否允许点击旁白消失（默认YES）*/
@property (nonatomic , assign) BOOL shouldTapToDissmiss;
/**浮板视图*/
@property (nonatomic , strong) UIView *panel;

/**显示方法*/
- (void)showWithPanelView:(UIView *)panel;

/**消失方法*/
- (void)dismiss;
- (void)dismissWithBlock:(ZHBaseAlertDismissBlock)block;

@end
