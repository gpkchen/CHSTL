//
//  ZHMacro.h
//  TenantWallet
//
//  Created by 李明伟 on 2017/4/24.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#ifndef ZHMacro_h
#define ZHMacro_h

#import "UIColor+Extension.h"

// debug日志输出
#ifdef DEBUG
#define Log(...) NSLog(__VA_ARGS__)
#else
#define Log(...)
#define NSLog(...)
#endif


//屏幕对象
#define SCREEN [UIApplication sharedApplication].delegate.window

//屏幕宽高
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

//iphone各机型判断
#define IS_IPHONE_3_5               CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size)
#define IS_IPHONE_4_0               CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size)
#define IS_IPHONE_4_7               CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size)
#define IS_IPHONE_5_5               CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size)
#define IS_IPHONE_5_8               CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size)
#define IS_IPHONE_6_1               CGSizeEqualToSize(CGSizeMake(828, 1792), [UIScreen mainScreen].currentMode.size) //iphonexr
#define IS_IPHONE_6_5               CGSizeEqualToSize(CGSizeMake(1242, 2688), [UIScreen mainScreen].currentMode.size) //iphonexsmax

//UI机型尺寸比例（以iphone6为基准）
#define UI_H_SCALE                  SCREEN_WIDTH/375
#define UI_V_SCALE                  SCREEN_HEIGHT/667

//分割线
#define LINE_HEIGHT                 0.5
#define LINE_COLOR                  HexRGB(0xeeeeee)

//屏幕物理像素与现实像素比值
#define SCREEN_SCALE                [UIScreen mainScreen].scale

//判断是否是iphone设备
#define IS_PHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

//字体大小,宏名以iphone6P下的字号为准
#define FONT(x)             [UIFont systemFontOfSize:FONT_SIZE(x)]
#define BOLD_FONT(x)        [UIFont boldSystemFontOfSize:FONT_SIZE(x)]
#define FONT_SIZE(x)        (IS_IPHONE_6_5?x+1:(IS_IPHONE_6_1?x+1:(IS_IPHONE_5_8?x+1:(IS_IPHONE_5_5?x+1:(IS_IPHONE_4_7?x:x-1)))))

#define TABBAR_HEIGHT           (IS_IPHONE_6_5?83:(IS_IPHONE_6_1?83:(IS_IPHONE_5_8?83:49)))  //tabbar的默认高度
#define STATUSBAR_HEIGHT        (IS_IPHONE_6_5?44:(IS_IPHONE_6_1?44:(IS_IPHONE_5_8?44:20)))  //状态栏高度
#define NAVIGATION_BAR_HEIGHT   (STATUSBAR_HEIGHT+44)  //navigation+statue默认高度

//生成颜色对象
#define HexRGB(rgbValue)            [UIColor colorWithHexRGB:rgbValue alpha:1.0]
#define HexRGBAlpha(rgbValue,a)     [UIColor colorWithHexRGB:rgbValue alpha:a]
#define RGB(r, g, b)                [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)        [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

//获取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]
//获取当前APP名字
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//获取当前APP版本号
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//获取当前APPbuild号
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//获取bundle id
#define APP_BUNDLEID [[NSBundle mainBundle] bundleIdentifier]

#endif /** ZHMacro_h */
