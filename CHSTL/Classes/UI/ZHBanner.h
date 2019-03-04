//
//  ZHBanner.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/7/10.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHBanner;

/**Banner操作代理*/
@protocol ZHBannerDelegate <NSObject>
@optional
/**
 *  选中banner某一cell时触发的回调
 *
 *  @param banner Banner对象
 *  @param index      cell下标
 */
- (void) banner:(ZHBanner *)banner didSelectCellAtIndex:(NSUInteger)index;

@end


/**Banner数据源代理*/
@protocol ZHBannerDataSource <NSObject>
@required
/**
 *  cell数代理
 *
 *  @param banner Banner对象
 *
 *  @return cell数
 */
- (NSUInteger)numOfCellInBanner:(ZHBanner *)banner;
/**
 *  cell样式代理
 *
 *  @param banner Banner对象
 *  @param index      cell下标
 *
 *  @return cell样式
 */
- (UIView *)banner:(ZHBanner *)banner viewForCellAtIndex:(NSUInteger)index;
@end


/**banner控件*/
@interface ZHBanner : UIView

/**Page Control y坐标*/
@property (nonatomic , assign) CGFloat pageControlY;

@property (nonatomic , weak) id<ZHBannerDelegate> delegate;
@property (nonatomic , weak) id<ZHBannerDataSource> dataSource;

/**
 *  刷新banner方法
 */
- (void)reloadData;

@end
