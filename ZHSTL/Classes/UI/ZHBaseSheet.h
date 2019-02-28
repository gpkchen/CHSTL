//
//  ZHBaseSheet.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/6/19.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZHBaseSheetPanelViewShowType){
    ZHBaseSheetPanelViewShowTypeFromBottom = 1,
    ZHBaseSheetPanelViewShowTypeFromTop = 2,
    ZHBaseSheetPanelViewShowTypeFromRight = 3,
    ZHBaseSheetPanelViewShowTypeFromLeft = 4,
    ZHBaseSheetPanelViewShowTypeFromNavBottom = 5,
};

/**显示菜单基类，支持各方向*/
@interface ZHBaseSheet : UIView

/**是否轻触消失(默认yes)*/
@property (nonatomic , assign) BOOL shouldTapToDismiss;
/**展示的面板*/
@property (nonatomic , strong) UIView *panelView;
/**面板展示方式 默认从底部出来*/
@property (nonatomic , assign) ZHBaseSheetPanelViewShowType showType;

//显示消失
- (void)show;
- (void)dismiss:(void(^)(void))finish;

@end
