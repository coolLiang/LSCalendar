//
//  UITools.m
//  trip
//
//  Created by noci on 16/5/5.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "UITools.h"

@implementation UITools

+(UIView *)getLineView
{
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithString:@"#e1e1e1"];
    return lineView;
    
}

+(UIImageView *)getTheImageViewWithImageName:(NSString *)name
{
    UIImageView * imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:name];
    return imageview;
}

+(UILabel *)getTheLabelWithText:(NSString *)text andFont:(float)font andTextColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]init];
    label.text = text;
    
    if (font != 0) {
        
        label.font = [UIFont systemFontOfSize:font];
    }

    if (color == nil) {
        
        color = [UIColor blackColor];
    }
    
    label.textColor = color;
    return label;
    
}

+(UIView *)getTheCutOffView
{
    UIView * view = [[UIView alloc]init];
    
    view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    return view;
    
}

+(UIView *)getTheSettingCutOffView
{
    UIView * view = [[UIView alloc]init];
    
    view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor alloc]initWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    return view;
}

//清空按钮。
+(UIButton *)getTheRemoveButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"清空" forState:UIControlStateNormal];
    [button setTitleColor:NAVICOLOR forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = NAVICOLOR.CGColor;
    button.layer.borderWidth = 1;
    return button;
}

//确定按钮。
+(UIButton *)getTheSubmitButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    button.backgroundColor = NAVICOLOR;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    return button;
}

@end
