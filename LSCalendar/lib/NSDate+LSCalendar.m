//
//  NSDate+LSCalendar.m
//  trip
//
//  Created by noci on 16/5/4.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "NSDate+LSCalendar.h"

#import "LSCalendarEntity.h"
#import "LSDayDataEntity.h"
#import "NSString+LS.h"

@implementation NSDate (LSCalendar)

+(NSMutableArray *)numberOfItemsForEachMonthInHalfAYear
{
    NSMutableArray * dataArray = [NSMutableArray new];
    //获取当前日期。之后获取包括当前月份下半年内的每个月的天数。
    NSDate * currentDate = [NSDate date];
    
    for (int i = 0; i < 6 ; i ++) {
        
        LSCalendarEntity * entity = [LSCalendarEntity new];
        
        //基础数据
        NSUInteger firstday = [[currentDate firstDayOfCurrentMonth]getWeekIndex];
        entity.days = [currentDate numberOfDaysInCurrentMonth] + firstday - 1;
        entity.stringDate = [currentDate stringWithYearAndMonthNoDayFromDate];
        entity.date = currentDate;
        entity.firstDays = [[currentDate firstDayOfCurrentMonth]getWeekIndex];
        
        //具体每一天的数据。
        NSMutableArray * dayDataArray = [NSMutableArray new];
        
        //遍历每一天。
        for (NSUInteger j = 0; j < entity.days; j ++) {
            
            LSDayDataEntity * dayEntity = [LSDayDataEntity new];
            
            //是否无用cell
            if (j < entity.firstDays - 1) {
                
                dayEntity.isHiddenCell = YES;
                [dayDataArray addObject:dayEntity];
                continue;
            }
            
            //是否周末
            if (j % 7 == 0 || j % 7 == 6) {
                
                dayEntity.isWeekend = YES;
            }

            
            dayEntity.day = j - entity.firstDays + 2;
            
            //是否是今天
            if ([[currentDate stringFromDate] isEqualToString:[[NSDate date]stringFromDate]]
                 && dayEntity.day == [[NSDate date]getDateInfo].day ) {
                
                dayEntity.isToday = YES;
            }
            //是否今天之前
            else if ([[currentDate stringFromDate] isEqualToString:[[NSDate date]stringFromDate]] && dayEntity.day < [[NSDate date]getDateInfo].day)
            {
                dayEntity.isBeforeToday = YES;
            }
            
            NSString * dateString;
            
            if (dayEntity.day <= 9) {
                
                dateString = [NSString stringWithFormat:@"%@-0%li",[currentDate stringFromDate],(long)dayEntity.day];
                
            }
            else
            {
                dateString = [NSString stringWithFormat:@"%@-%li",[currentDate stringFromDate],(long)dayEntity.day];
            }
            
            dayEntity.dateString = dateString;
            dayEntity.date = [dateString dateFromString];
            
            [dayDataArray addObject:dayEntity];
        }
        
        
        
        entity.dayDataArray = (NSArray *)dayDataArray;
        
        [dataArray addObject:entity];
        currentDate =  [currentDate dayInNextMonth];
    }
    
    return dataArray;
    
}

-(NSUInteger)numberOfItemsInCurrentMonth
{
    NSUInteger totaldays = [self numberOfDaysInCurrentMonth];  //总天数
    NSUInteger firstDayWeek = [[self firstDayOfCurrentMonth]getWeekIndex];  //第一天是星期几
    
    return totaldays + firstDayWeek - 1;
    
}

-(NSUInteger)numberOfDaysInCurrentMonth
{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return daysInLastMonth.length;
}

-(NSUInteger)numberOfWeeksInCurrentMonth
{
    NSUInteger weekday = [[self firstDayOfCurrentMonth] getWeekIndex];
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}


-(NSUInteger)getWeekIndex
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];

}

-(NSString *)getWeekInfoString
{
    NSUInteger  index = [self getWeekIndex];
    NSString * weekInfoStr;
    
    switch (index) {
        case 1:
            weekInfoStr = @"周日";
            break;
        case 2:
            weekInfoStr = @"周一";
            break;
        case 3:
            weekInfoStr = @"周二";
            break;
        case 4:
            weekInfoStr = @"周三";
            break;
        case 5:
            weekInfoStr = @"周四";
            break;
        case 6:
            weekInfoStr = @"周五";
            break;
        case 7:
            weekInfoStr = @"周六";
        default:
            break;
    }
    
    return weekInfoStr;
    
}

-(NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

-(NSDate *)lastDatOfCurrentMonth
{
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self];
    dateComponents.day = [self numberOfDaysInCurrentMonth];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

-(NSDate *)dayInThePreviousMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

-(NSDate *)dayInNextMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

-(NSDateComponents *)getDateInfo
{
    return [[NSCalendar currentCalendar] components:
            NSCalendarUnitYear|
            NSCalendarUnitMonth|
            NSCalendarUnitDay|
            NSCalendarUnitWeekday fromDate:self];
}



- (NSString *)stringFromDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:self];
    
    destDateString = [destDateString substringToIndex:7];
    
    return destDateString;
}

- (NSString *)stringWithYearAndMonthNoDayFromDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:self];
    
    NSArray * infoArray = [destDateString componentsSeparatedByString:@"-"];
    
    NSString * string = [NSString stringWithFormat:@"%@年%@月",infoArray[0],infoArray[1]];
    
    return string;
}

+ (int)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//日历控件对象
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:today toDate:beforday options:0];
    //    NSDateComponents *components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today toDate:beforday options:0];
    NSInteger day = [components day];//两个日历之间相差多少月//    NSInteger days = [components day];//两个之间相差几天
    
    return (int)day;
}


@end
