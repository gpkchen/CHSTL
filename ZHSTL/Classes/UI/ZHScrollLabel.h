//
//  ZHScrollLabel.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/2.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**点击回调*/
typedef void(^ZHScrollLabelAction)(NSUInteger index);

/**滚动显示文字lab，用于公告等*/
@interface ZHScrollLabel : UIView

/**文字列表*/
@property (nonatomic , strong) NSArray *textArray;
/**文字颜色*/
@property (nonatomic , strong) UIColor *textColor;
/**文字字体*/
@property (nonatomic , strong) UIFont *font;
/**内容偏移量*/
@property (nonatomic , assign) UIEdgeInsets contentInsert;
/**设置点击事件*/
- (void)action:(ZHScrollLabelAction)action;

@end
