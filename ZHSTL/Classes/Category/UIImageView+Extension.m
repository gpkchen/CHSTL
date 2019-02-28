//
//  UIImageView+Extension.m
//
//  Created by 李明伟 on 16/6/7.
//  Copyright © 2016年 李明伟. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Extension)

- (void)loadImage:(NSString *_Nullable)url{
    [self loadImage:url placeholder:nil];
}

- (void)loadImage:(NSString *_Nullable)url placeholder:(UIImage *_Nullable)placeholder{
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:placeholder
                     options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

@end
