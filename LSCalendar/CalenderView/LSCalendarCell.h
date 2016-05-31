//
//  LSCalendarCell.h
//  trip
//
//  Created by noci on 16/5/4.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSDayDataEntity.h"

@interface LSCalendarCell : UICollectionViewCell

+(instancetype)setupLSCalendarCellWith:(UICollectionView *)collectionview andWith:(NSIndexPath *)index;

@property(nonatomic,strong)UILabel * dayLabel;

@property(nonatomic,strong)UILabel * tipLabel;

@property(nonatomic,strong)LSDayDataEntity * lsDayDataEntity;

-(void)updateCellUI;

@end
