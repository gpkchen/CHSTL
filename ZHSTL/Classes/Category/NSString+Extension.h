//
//  NSString+Extension.h
//  BuOne
//
//  Created by 李明伟 on 16/6/2.
//  Copyright © 2016年 李明伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>

@interface NSString (Extension)

//判断是否为空（空格也算空）
+ (BOOL)isBlank:(NSString *)str;
/**NSString转字典*/
- (NSDictionary *)toDictionary;
/**寻找字符串中网址的位置(NSValue)*/
- (NSArray *)urlLocations;
/**是否是网址*/
- (BOOL)isUrl;
/**14位字符串转换为今天明天显示*/
- (NSString *)distanceNow;
/**unicode字符数*/
- (NSUInteger)unicodeLength;
/**是否字母数字组合*/
- (BOOL)isLettersNumber;
/**手机号有效性检查*/
- (BOOL)isTelNumber;
/**判断字符串是不是整数*/
- (BOOL) isInt;
/**判断字符串是不是双精度浮点型*/
- (BOOL) isDouble;
/**判断字符串是不是身份证号码*/
- (BOOL)isIdentityCardNumber;
/**判断字符串是不是邮箱*/
- (BOOL)isEmailAddress;
/**判断字符串是不是qq*/
- (BOOL)isQQNumber;
/**银行卡格式不正确*/
- (BOOL)isBankCard;
/**md5加密*/
- (NSString *)md5;
/**3DES加解密*/
- (NSString *)tripleDES:(CCOperation)operation key:(NSString *)key;
/**URLEncode编码*/
- (NSString *)URLEncode;
/**URLEncode解码*/
- (NSString *)URLDecode;

@end
