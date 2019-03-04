//
//  ZHSheetMenu.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/6/19.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHBaseSheet.h"

//选择回调
typedef void (^ZHSheetMenuSelectionAction)(NSUInteger index);
//消失回调
typedef void (^ZHSheetMenuDismissAction)(void);
//取消回调
typedef void (^ZHSheetMenuCancelAction)(void);

/**上拉菜单*/
@interface ZHSheetMenu : ZHBaseSheet

/**数据源NSString*/
@property (nonatomic , strong) NSArray *dateArr;

/**显示方法*/
- (void)show;
/**消失方法*/
- (void)dismissWithCompletion:(ZHSheetMenuDismissAction)completion;
/**设置选择回调*/
- (void)selectionAction:(ZHSheetMenuSelectionAction)action;
/** 设置取消回调*/
- (void)cancelAction:(ZHSheetMenuCancelAction)action;

@end


/*************上拉菜单Cell*************/
@interface ZHSheetMenuCell : UITableViewCell

@property (nonatomic , strong) UIImageView *separator;
@property (nonatomic , copy) NSString *text;

@end
