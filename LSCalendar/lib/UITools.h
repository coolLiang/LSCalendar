//
//  UITools.h
//  trip
//
//  Created by noci on 16/5/5.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITools : NSObject

+(UIView *)getLineView;

+(UIImageView *)getTheImageViewWithImageName:(NSString *)name;

+(UILabel *)getTheLabelWithText:(NSString *)text andFont:(float)font andTextColor:(UIColor *)color;

+(UIView *)getTheCutOffView;

+(UIView *)getTheSettingCutOffView;


//清空按钮。
+(UIButton *)getTheRemoveButton;

//确定按钮。
+(UIButton *)getTheSubmitButton;




@end
