//
//  NSString+LS.h
//  trip
//
//  Created by noci on 16/5/5.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+LSCalendar.h"

@interface NSString (LS)

- (NSDate *)dateFromString;//NSString转NSDate

- (NSDate *)dateFromSpecialString; //将5月6日这样的字符串转出date

- (NSString *)stringFromSpecialString; //将5月6日这样的字符串转成2016-05-06这样的。

- (NSString *)specialStringFromString; //将2016-06-05 这样的字符串 转成 6月5日这样的。


@end
