//
//  LSCalendarCell.m
//  trip
//
//  Created by noci on 16/5/4.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "LSCalendarCell.h"

@interface LSCalendarCell()

@end

@implementation LSCalendarCell

+(instancetype)setupLSCalendarCellWith:(UICollectionView *)collectionview andWith:(NSIndexPath *)index
{
    static NSString * ID = @"LSCalendarCell";
    
    LSCalendarCell *cell =  [collectionview dequeueReusableCellWithReuseIdentifier:ID forIndexPath:index];
    
    cell.backgroundColor = [UIColor whiteColor];
    [cell removeUI];
    
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self buildUI];
        [self buildCS];
        [self buildMVVM];
    }
    
    return self;
}

-(void)buildUI
{
    self.dayLabel = [UILabel new];
    self.dayLabel.textColor = APPBLACKCOLOR;

    
    self.dayLabel.font = [UIFont systemFontOfSize:16];
    self.dayLabel.textAlignment = 1;
    [self.contentView addSubview:self.dayLabel];
    
    self.tipLabel = [UILabel new];
    self.tipLabel.textColor = [UIColor whiteColor];
    //默认隐藏
    self.tipLabel.textAlignment = 1;
    self.tipLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.tipLabel];
}

-(void)buildCS
{
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

-(void)removeUI
{
    self.tipLabel.text = @"";
    
    [self.dayLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        
    }];
}

-(void)updateCellUI
{
    self.backgroundColor = NAVICOLOR;
    self.dayLabel.textColor = [UIColor whiteColor];
    
    [self.dayLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(3);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.5);
        
    }];
    
    [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.dayLabel.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.5);
    }];
}

-(void)setLsDayDataEntity:(LSDayDataEntity *)lsDayDataEntity
{
    self.hidden = lsDayDataEntity.isHiddenCell;
    
    if (lsDayDataEntity.isToday) {

        
        self.dayLabel.text = @"今天";
        self.dayLabel.textColor = NAVICOLOR;
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiudain_pic_rili_cir"]];
    }
    //不是今天
    else
    {
        self.backgroundView = nil;
        
        if (lsDayDataEntity.isBeforeToday) {
            
            self.dayLabel.textColor = APPGRAYCOLOR;
            self.dayLabel.text = [NSString stringWithFormat:@"%d",(int)lsDayDataEntity.day];
        }
        else
        {
            self.dayLabel.text = [NSString stringWithFormat:@"%d",(int)lsDayDataEntity.day];
            self.dayLabel.textColor = lsDayDataEntity.isWeekend ? [UIColor redColor]:APPBLACKCOLOR;
            
        }
    }
    
}

-(void)buildMVVM
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
