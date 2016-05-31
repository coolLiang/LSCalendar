//
//  NSDate+LSCalendar.h
//  trip
//
//  Created by noci on 16/5/4.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LSCalendar)

+(NSMutableArray *)numberOfItemsForEachMonthInHalfAYear;

-(NSUInteger)numberOfItemsInCurrentMonth; //获取这个月数据全部展示出 需要几个item

-(NSUInteger)numberOfDaysInCurrentMonth; //获取日期下这个月共有几天。

-(NSUInteger)numberOfWeeksInCurrentMonth; //获取日期下这个月共有几周

-(NSUInteger)getWeekIndex; //获取这一天是星期几  // 星期天:1 星期1:2........星期六:7

-(NSString *)getWeekInfoString;  //字符串展示是周几。

-(NSDate *)firstDayOfCurrentMonth; //获取这个月第一天的日期

-(NSDate *)lastDatOfCurrentMonth;  //获取这个月的最后一天

-(NSDate *)dayInThePreviousMonth;  //上个月

-(NSDate *)dayInNextMonth;  //下一个月

-(NSDateComponents *)getDateInfo; //获取一个日期 分别的 年 月 日。

- (NSString *)stringFromDate;//NSDate转NSString

- (NSString *)stringWithYearAndMonthNoDayFromDate; //date 转成 XXXX年xx月

+ (int)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday; //获取两个日期对象的时间差(天数)


@end
