//
//  ZHPhotoUtils.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/30.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZHPhotoUtilsRequireAccessResult)(BOOL granted);

/**照片管理工具*/
@interface ZHPhotoUtils : NSObject

/**单例*/
+ (instancetype) utils;

/**检测相机权限*/
+ (BOOL)isAuthAccessCarmera:(ZHPhotoUtilsRequireAccessResult)result;
/**检测相册权限*/
+ (BOOL)isAuthAccessPhotos;

/**拍照*/
- (void)callCamera:(UIViewController *)viewController
         callback:(void(^)(UIImage *image))callback;
- (void)callCamera:(UIViewController *)viewController
         callback:(void(^)(UIImage *image))callback
   dismissCallback:(void(^)(void))dismissCallback;

/**相册选择*/
- (void)callAlbum:(UIViewController *)viewController
        callback:(void(^)(UIImage *image))callback;
- (void)callAlbum:(UIViewController *)viewController
        callback:(void(^)(UIImage *image))callback
  dismissCallback:(void(^)(void))dismissCallback;

@end
