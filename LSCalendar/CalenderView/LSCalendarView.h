//
//  LSCalendarView.h
//  trip
//
//  Created by noci on 16/5/4.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSCalendarEntity.h"

@protocol LSCalendarViewDelegate <NSObject>

////更新日历数据时。
//-(void)onUpdateTheDateData:(NSDate *)currentDate;

//确定选择日期时
-(void)onChooseTheDate:(NSMutableArray *)dateArray;

@end

typedef enum
{
    SingleChoice                    =0,
    In_OutChoice                    =1,
    MultipleChoice                  =2,
    
} LSCalendarViewType;

@interface LSCalendarView : UIView

//@property(nonatomic,strong)NSDate * date;  //月份日期
//@property(nonatomic,strong)NSMutableArray * dateArray; //默认选择的日期


@property(nonatomic,weak)id delegate;


-(instancetype)initWithCalendarType:(LSCalendarViewType)type andChoosedDateArray:(NSArray *)dateArray;



@end
