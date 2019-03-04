//
//  ZHScrollView.m
//  AFNetworking
//
//  Created by 李明伟 on 2017/10/11.
//

#import "ZHScrollView.h"

@implementation ZHScrollView

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

@end
