//
//  UIScrollView+Extension.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/5/8.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "UIScrollView+Extension.h"
#import "ZHMacro.h"

@implementation UIScrollView (Extension)

- (void)addRefreshHeaderWithBlock:(MJRefreshComponentRefreshingBlock)block{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:block];
    header.stateLabel.textColor = HexRGB(0x7f8a97);
    header.stateLabel.font = FONT(13);
//    header.stateLabel.hidden = YES;
    
//    header.lastUpdatedTimeLabel.textColor = HexRGB(0xc3cdd8);
//    header.lastUpdatedTimeLabel.font = FONT(12);
    header.lastUpdatedTimeLabel.hidden = YES;
    
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle bundleForClass:[self class]]
                                                URLForResource:@"BASE_RES"
                                                withExtension:@"bundle"]];
    
    // 设置普通状态的动画图片
    NSString *idleFilePath = [bundle  pathForResource:@"下拉_00000" ofType:@"png"];
    NSArray *idleImages = @[[self scaleWithImageWithSize:CGSizeMake(30, 50) withImage:[UIImage imageNamed:idleFilePath]]];
    [header setImages:idleImages forState:MJRefreshStateIdle];

    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        NSString  * imageName = [bundle  pathForResource:[NSString stringWithFormat:@"下拉_0000%d",i] ofType:@"png"];
        UIImage *image = [self scaleWithImageWithSize:CGSizeMake(30, 50) withImage:[UIImage imageNamed:imageName]];
        [pullingImages addObject:image];
    }
    for (int i = 0; i < 20; i++) {
        NSString  *filePath = [bundle  pathForResource:@"下拉_00012" ofType:@"png"];
        UIImage *image = [self scaleWithImageWithSize:CGSizeMake(30, 50) withImage:[UIImage imageNamed:filePath]];
        [pullingImages addObject:image];
    }
    [header setImages:pullingImages forState:MJRefreshStatePulling];

    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 12; i < 48; i ++) {
        NSString  * imageName = [bundle  pathForResource:[NSString stringWithFormat:@"下拉_000%d",i] ofType:@"png"];
        UIImage *image = [self scaleWithImageWithSize:CGSizeMake(30, 50) withImage:[UIImage imageNamed:imageName]];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages duration:refreshingImages.count*0.07 forState:MJRefreshStateRefreshing];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];

    self.mj_header = header;
}

- (void)addRefreshFooterWithBlock:(MJRefreshComponentRefreshingBlock)block{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"" forState:MJRefreshStatePulling];
    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"已经到底啦" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = FONT(13);
    footer.stateLabel.textColor = HexRGB(0xc3cdd8);
    footer.labelLeftInset = 0;
    self.mj_footer = footer;
}

- (UIImage *)scaleWithImageWithSize:(CGSize)size withImage:(UIImage *)image{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];

    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
