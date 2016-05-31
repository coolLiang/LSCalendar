//
//  LSCalendarHeaderCollectionReusableView.m
//  trip
//
//  Created by noci on 16/5/30.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "LSCalendarHeaderCollectionReusableView.h"

@interface LSCalendarHeaderCollectionReusableView()

@property(nonatomic,strong)UIView * lineview;

@end

@implementation LSCalendarHeaderCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self buildUI];
        [self buildCS];
    }
    
    return self;
}

-(void)buildUI
{
    self.lineview = [UITools getLineView];
    [self addSubview:self.lineview];
    
    self.dateTipLabel = [UITools getTheLabelWithText:@"" andFont:15 andTextColor:APPBLACKCOLOR];
    [self addSubview:self.dateTipLabel];
    
}

-(void)buildCS
{
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(1);
        
    }];
    
    [self.dateTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
}

@end
