//
//  CALayer+Extension.m
//
//  Created by 李明伟 on 2016/11/2.
//  Copyright © 2016年 李明伟. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)

- (void)removeAllSublayers{
    while (self.sublayers.count) {
        CALayer* child = self.sublayers.lastObject;
        [child removeFromSuperlayer];
    }
}

@end
