//
//  NSDate+Extension.h
//
//  Created by 李明伟 on 16/6/2.
//  Copyright © 2016年 李明伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

NS_ASSUME_NONNULL_BEGIN

/**从1970年开始后的毫秒数*/
- (long long)millisecondSince1970;

/**计算这个月有多少天*/
- (NSUInteger)numberOfDaysInCurrentMonth;

/**获取这个月有多少周*/
- (NSUInteger)numberOfWeeksInCurrentMonth;

/**计算这个月最开始的一天*/
- (NSDate *)firstDayOfCurrentMonth;

/**计算这个月最后的一天*/
- (NSDate *)lastDayOfCurrentMonth;

/**上一个月*/
- (NSDate *)dayInThePreviousMonth;

/**下一个月*/
- (NSDate *)dayInTheFollowingMonth;

/**获取当前日期之后的时间*/
- (NSDate *)dayInTheFollowingMonth:(NSInteger)month;
- (NSDate *)dayInTheFollowingDay:(NSInteger)day;

/**
 NSString转NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;

/**格式化*/
- (NSString *)format:(NSString *)format;

/**两个之间相差几天*/
+ (NSInteger)getDayNumberOfDay:(NSDate *)day beforDay:(NSDate *)beforday;

/**周日是“1”，周一是“2”...*/
- (NSInteger)getWeekIntValue;

/**截取特定位的值*/
- (NSInteger)getYearValue;
- (NSInteger)getMonthValue;
- (NSInteger)getDayValue;
- (NSInteger)getHourValue;
- (NSInteger)getMinuteValue;

NS_ASSUME_NONNULL_END
@end
