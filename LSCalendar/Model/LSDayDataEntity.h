//
//  LSDayDataEntity.h
//  trip
//
//  Created by noci on 16/5/31.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDayDataEntity : NSObject

//是否是周末
@property(nonatomic,assign)BOOL isWeekend;

//是否是今天
@property(nonatomic,assign)BOOL isToday;

//是否今天之前
@property(nonatomic,assign)BOOL isBeforeToday;

//具体哪一天
@property(nonatomic,assign)NSUInteger day;

//是否是无用cell.
@property(nonatomic,assign)BOOL isHiddenCell;

//这一天的日期 字符串格式
@property(nonatomic,copy)NSString * dateString;

//这一天的日期 date格式
@property(nonatomic,strong)NSDate * date;


@end
