//
//  NSObject+ZHDynamic.m
//  Finance
//
//  Created by Apple on 2017/9/29.
//  Copyright © 2017年 fintechzh. All rights reserved.
//

#import "NSObject+ZHDynamic.h"
#import <objc/runtime.h>
#import "ZHMacro.h"

static NSString * const kDicParamKey = @"kDicParamKey";
static NSString * const kCallBackKey = @"kCallBackKey";
static NSString * const kIdentifierKey = @"kIdentifierKey";

@implementation NSObject (ZHDynamic)

#pragma mark - getter/setter
-(NSDictionary*)dicParam{
    return objc_getAssociatedObject(self, &kDicParamKey);
}

-(void)setDicParam:(NSDictionary *)dicParam{
    objc_setAssociatedObject(self, &kDicParamKey,
                             dicParam,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (id)callBack{
    return objc_getAssociatedObject(self, &kCallBackKey);
}

- (void)setCallBack:(id)callBack{
    objc_setAssociatedObject(self, &kCallBackKey,
                             callBack,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)identifier{
    return objc_getAssociatedObject(self, &kIdentifierKey);
}

-(void)setIdentifier:(NSString *)identifier{
    objc_setAssociatedObject(self, &kIdentifierKey,
                             identifier,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)dynamicCheckIsExistClassWithviewController:(NSString *)viewController{
    
    
    NSString *classStr = [NSString stringWithFormat:@"%@",viewController];
    const char *className = [classStr cStringUsingEncoding:NSASCIIStringEncoding];
    
    Class newClass = objc_getClass(className);
    if (newClass == nil) {
        
        // 进入该判断,表示该project里面，没有该类
        Log(@"路由错误：控制器\"%@\"不存在！",viewController);
        return NO;
    }
    
    return YES;
}


- (void)dynamicDeliverWithViewController:(UIViewController *)viewController
                                     dic:(NSDictionary *)dic{
    // 处理传递数据
    if (dic != nil) {
        
        //单独把对象整体给控制器
        [viewController setDicParam:dic];
        
        // 遍历字典
//        [dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//            
//            if ([viewController dynamicCheckIsExistProperty:key]) {
//                // 单独把对象的Key 给控制器
//                [viewController setValue:obj forKey:key];
//                
//            }
//        }];
    }
}

// 动态检测instance对象里面是否存在verifyPropertyName属性
- (BOOL)dynamicCheckIsExistProperty:(NSString *)propertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:propertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    return NO;
}
@end
