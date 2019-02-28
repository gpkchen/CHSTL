//
//  ZHCollectionView.m
//  AFNetworking
//
//  Created by 李明伟 on 2017/10/11.
//

#import "ZHCollectionView.h"

@implementation ZHCollectionView

- (instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
#ifdef __IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#endif
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]){
#ifdef __IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#endif
    }
    return self;
}

@end
