//
//  ZHBaseVC.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/24.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**视图控制器基类*/
@interface ZHBaseVC : UIViewController

/**返回按钮图片*/
@property (nonatomic , strong) UIImage *backBtnImg;
/**导航栏透明度，默认1*/
@property (nonatomic , assign) CGFloat navigationBarAlpha;
/**导航栏背景色*/
@property (nonatomic , strong) UIColor *navigationBarColor;
/**是否应该侧滑返回，默认YES*/
@property (nonatomic , assign) BOOL shouldSwipeToBack;
/**是否需要显示返回按钮，默认YES，需要在子类viewDidLoad之前调用*/
@property (nonatomic , assign) BOOL shouldShowBackBtn;

/**自定义导航栏左边按钮*/
@property (nonatomic , strong) NSArray *leftBarItems;
/**自定义导航栏右边按钮*/
@property (nonatomic , strong) NSArray *rightBarItems;
/**自定义导航栏按钮字体*/
@property (nonatomic , strong) UIFont *barItemsFont;
/**自定义导航栏按钮字体颜色*/
@property (nonatomic , strong) UIColor *barItemsTextColor;

/**是否可见*/
@property (nonatomic , assign , readonly) BOOL isVisiable;

/**系统自带导航栏返回按钮事件*/
- (void)nativeComesBackButtonClicked;

/**自定义导航栏按钮事件,用于继承重载*/
- (void)leftBarItemsClicked:(UIButton *)button;
- (void)rightBarItemsClicked:(UIButton *)button;

@end
