//
//  NSString+LS.m
//  trip
//
//  Created by noci on 16/5/5.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "NSString+LS.h"

@implementation NSString (LS)

- (NSDate *)dateFromString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:self];
    
    return destDate;
    
}

- (NSDate *)dateFromSpecialString
{
    NSRange monthRange = [self rangeOfString:@"月"];
    NSString * month = [self substringToIndex:monthRange.location];
    if (month.length == 1) {
        
        month = [NSString stringWithFormat:@"0%@",month];
    }
    
    NSString * onlyDayStr = [self substringFromIndex:monthRange.location + monthRange.length];
    
    NSRange dayRange = [onlyDayStr rangeOfString:@"日"];
    
    NSString * day = [onlyDayStr substringToIndex:dayRange.location];
    
    
    if (day.length == 1) {
        
        day = [NSString stringWithFormat:@"0%@",day];
    }
    
    NSDate  * date = [NSDate date];
    
    NSInteger  currentYear = [date getDateInfo].year;
    
    //结合组成一个yyyy-MM-dd的字符串
    NSString * newStr = [NSString stringWithFormat:@"%ld-%@-%@",(long)currentYear,month,day];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    date = [dateFormatter dateFromString:newStr];
    
    return date;

}

- (NSString *)stringFromSpecialString
{
    NSRange monthRange = [self rangeOfString:@"月"];
    NSString * month = [self substringToIndex:monthRange.location];
    if (month.length == 1) {
        
        month = [NSString stringWithFormat:@"0%@",month];
    }
    
    NSString * onlyDayStr = [self substringFromIndex:monthRange.location + monthRange.length];
    
    NSRange dayRange = [onlyDayStr rangeOfString:@"日"];
    
    NSString * day = [onlyDayStr substringToIndex:dayRange.location];
    
    
    if (day.length == 1) {
        
        day = [NSString stringWithFormat:@"0%@",day];
    }
    
    NSDate  * date = [NSDate date];
    
    NSInteger  currentYear = [date getDateInfo].year;
    
    //结合组成一个yyyy-MM-dd的字符串
    NSString * newStr = [NSString stringWithFormat:@"%ld-%@-%@",(long)currentYear,month,day];
    
    return newStr;
    
}


- (NSString *)specialStringFromString
{
    NSString * newStr = [self substringFromIndex:5];
    
    NSArray * array = [newStr componentsSeparatedByString:@"-"];
    NSString * month = array[0];
    NSString * day = array[1];
    
    NSString * specialStr = [NSString stringWithFormat:@"%d月%d日",[month intValue],[day intValue]];
    
    return specialStr;
}

@end
