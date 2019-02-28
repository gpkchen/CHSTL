//
//  UIScrollView+Extension.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/8.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface UIScrollView (Extension)

/**设置下拉刷新组件*/
- (void)addRefreshHeaderWithBlock:(MJRefreshComponentRefreshingBlock)block;
/**设置上拉加载组件*/
- (void)addRefreshFooterWithBlock:(MJRefreshComponentRefreshingBlock)block;

@end
