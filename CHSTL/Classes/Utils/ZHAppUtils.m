//
//  ZHAppUtils.m
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/30.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "ZHAppUtils.h"
#import "ZHMacro.h"

static NSString * const kUploadDeviceInfoKey = @"kUploadDeviceInfoKey";

@implementation ZHAppUtils

+ (void) openURL:(NSString *)url{
    NSURL *toUrl = [NSURL URLWithString:url];
    if([[UIApplication sharedApplication] canOpenURL:toUrl]){
        if(IOS_VERSION < 10){
            [[UIApplication sharedApplication] openURL:toUrl];
        }else{
            [[UIApplication sharedApplication] openURL:toUrl
                                               options:@{}
                                     completionHandler:^(BOOL success) {
                                         
                                     }];
        }
    }
}

@end
