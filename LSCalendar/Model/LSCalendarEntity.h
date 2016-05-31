//
//  LSCalendarEntity.h
//  trip
//
//  Created by noci on 16/5/30.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCalendarEntity : NSObject

//月份下的总天数
@property(nonatomic,assign)NSUInteger days;

//日期
@property(nonatomic,copy)NSString * stringDate;

//还是日期
@property(nonatomic,strong)NSDate * date;

//月份下的第一天是哪天。
@property(nonatomic,assign)NSUInteger firstDays;

@property(nonatomic,strong)NSArray * dayDataArray;



@end
