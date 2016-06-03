//
//  LSCalendarView.m
//  trip
//
//  Created by noci on 16/5/4.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "LSCalendarView.h"
#import "LSCalendarCell.h"
#import "LSCalendarHeaderCollectionReusableView.h"

#import "NSDate+LSCalendar.h"
#import "NSString+LS.h"

@interface LSCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource>

{
    NSMutableArray * _chooseDateArray;
    LSCalendarViewType _type;
    
    
}

@property(nonatomic,strong)UIView * headView;
//
//@property(nonatomic,strong)UIButton * nextButton; //向下翻页
//
//@property(nonatomic,strong)UIButton * beforeButton; //向上翻页
//
//@property(nonatomic,strong)UILabel * monthDateLabel; //当前显示的月份展示

@property(nonatomic,strong)UICollectionView * dayCollectionView; //每个日子所对应的cell

@property(nonatomic,strong)NSArray * dataArray;

@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)UIButton * submitButton;
@property(nonatomic,strong)UIView * topLineView;

@end

@implementation LSCalendarView

-(instancetype)initWithCalendarType:(LSCalendarViewType)type andChoosedDateArray:(NSArray *)dateArray;
{
    self = [super init];
    
    if (self) {
        
        [self buildUI];
        [self buildCS];
        [self buildMVVM];
        
        _type = type;
        _chooseDateArray = [NSMutableArray arrayWithArray:dateArray];

    }
    
    return self;
    
}

//-(instancetype)init
//{
//    self = [super init];
//    
//    if (self) {
//        
//        [self buildUI];
//        [self buildCS];
//        [self buildMVVM];
//        
////        self.type = 1;//默认类型 单选。
//        _chooseDateArray = [NSMutableArray new];
//    }
//    
//    return self;
//}

-(void)buildUI
{
    
    //顶部视图 展示当前月份 切换月份按钮。
    self.headView = [[UIView alloc]init];
    self.headView.backgroundColor = NAVICOLOR;
    [self addSubview:self.headView];

    NSArray * weekTitleArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    float width = SCREEN_WIDTH/weekTitleArray.count;
    
    //星期内容的视图
    for (int i = 0; i < 7; i ++) {

        
        UILabel * weekLabel = [[UILabel alloc]init];
        weekLabel.text = weekTitleArray[i];
        weekLabel.textAlignment = 1;
        weekLabel.font = [UIFont systemFontOfSize:14];
        weekLabel.textColor = [UIColor whiteColor];
        
        if (i == 0 || i == 6) {
            
            weekLabel.textColor = [UIColor redColor];
        }
        
        [self.headView addSubview:weekLabel];
        
        [weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.headView.mas_centerY);
            make.left.equalTo(self.mas_left).offset(i * width);
            make.width.mas_equalTo(width);
            make.height.equalTo(self.headView.mas_height).multipliedBy(0.5);
        }];
        
    }
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;//行间距(最小值)
    layout.minimumInteritemSpacing = 0;//item间距(最小值)

    
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/7,SCREEN_WIDTH/7);//item的大小
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    
    self.dayCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self.dayCollectionView registerClass:[LSCalendarCell class] forCellWithReuseIdentifier:@"LSCalendarCell"];
    //header
    [self.dayCollectionView registerClass:[LSCalendarHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LSCalendarHeaderCollectionReusableView"];
    
    self.dayCollectionView.backgroundColor = [UIColor whiteColor];
    self.dayCollectionView.delegate = self;
    self.dayCollectionView.dataSource = self;
    [self addSubview:self.dayCollectionView];
    
    //底部确定视图
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomView];
    
    self.topLineView = [UITools getLineView];
    [self.bottomView addSubview:self.topLineView];
    
    self.submitButton = [UITools getTheSubmitButton];
    [self.submitButton addTarget:self action:@selector(submitThechoose) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.submitButton];
    
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @strongify(self);
        
        
        self.dataArray = (NSArray *)[NSDate numberOfItemsForEachMonthInHalfAYear];
        
        dispatch_async(dispatch_get_main_queue(), ^{
         
            [self.dayCollectionView reloadData];
            
        });
        
    });
    
    
    
}

-(void)buildCS
{
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(40);
        
    }];
    
    [self.dayCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headView.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-60);
        
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(60);
        
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.bottomView.mas_top);
        make.left.equalTo(self.bottomView.mas_left);
        make.right.equalTo(self.bottomView.mas_right);
        make.height.mas_equalTo(1);
        
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(46);
        
    }];
}

//section 的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
//cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return [self.dataArray[section] days];;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //计算屏幕宽度除以7.(去掉小数点后的数据为多少).
    int minWidth = floorf(SCREEN_WIDTH/7);
    //7个最小宽度是多宽
    int minAllWidth = minWidth * 7;
    //计算跟屏幕宽度的差距.(得到1行下需要变宽的item个数)
    int widthRst = SCREEN_WIDTH - minAllWidth;
    
    
    
    
    if (indexPath.row % 7 > 7 - widthRst - 1) {
        
        return CGSizeMake(ceil(SCREEN_WIDTH/7), ceil(SCREEN_WIDTH/7));
        
    }
    
    return CGSizeMake(floorf(SCREEN_WIDTH/7), ceil(SCREEN_WIDTH/7));
    
}

-(UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    LSCalendarCell * cell = [LSCalendarCell setupLSCalendarCellWith:collectionView andWith:indexPath];
    
    cell.lsDayDataEntity = [self.dataArray[indexPath.section] dayDataArray][indexPath.row];
    
    //选择2个日期后。判断是否在其中间
        
    if (_type == In_OutChoice && _chooseDateArray.count == 2) {
        
        
        
            NSDate * date = [[self.dataArray[indexPath.section] dayDataArray][indexPath.row] date];
        
            LSDayDataEntity * in_entity = [_chooseDateArray firstObject];
            LSDayDataEntity * out_entity = [_chooseDateArray lastObject];
            
            if ([date laterDate:in_entity.date] == date && [date earlierDate:out_entity.date] == date&& ![date isEqualToDate:in_entity.date] && ![date isEqualToDate:out_entity.date]) {
                
                cell.backgroundColor = [UIColor colorWithRed:231/255.0 green:234/255.0 blue:242/255.0 alpha:1];
                
            }
    }
    
    //相应的选中后的判断
    for (int i = 0 ; i < _chooseDateArray.count; i ++)
    {
        LSDayDataEntity * entity = _chooseDateArray[i];

        if ([[[self.dataArray[indexPath.section] dayDataArray][indexPath.row] dateString] isEqualToString:entity.dateString]) {
            
            //单选
            if (_type == SingleChoice) {
                
                cell.tipLabel.text = @"入住";
            }
            //双选
            if (_type == In_OutChoice && i == 0) {
                
                cell.tipLabel.text = @"入住";
                [cell updateCellUI];
            }
            else if (_type == In_OutChoice && i == 1)
            {
                cell.tipLabel.text = @"离店";
                [cell updateCellUI];
            }
            
        }

    }
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSDayDataEntity * dayDateEntity = [self.dataArray[indexPath.section] dayDataArray][indexPath.row];
    
    if (dayDateEntity.isHiddenCell) {
        
        NSLog(@"点击了奇怪的东西");
        
    }
    
    else
    {
        
        //判断是否是在今天之前
        if (dayDateEntity.day < [[NSDate date]getDateInfo].day && [[[self.dataArray[indexPath.section] date] stringFromDate] isEqualToString:[[NSDate date]stringFromDate]]) {
            
            NSLog(@"点击了之前的日子");
            return;
        }
        //单选。
        if (_type == 0) {
            
            [_chooseDateArray removeAllObjects];
            [_chooseDateArray addObject:dayDateEntity];
            [self.dayCollectionView reloadData];
  
        }
        //双选
        else if (_type == 1)
        {
            //判断当前选择的几个。如果为2个。代表默认传入2个。~ 再次选择先清除前两个。再新增加一个。
            if (_chooseDateArray.count == 2) {
                
                [_chooseDateArray removeAllObjects];

                
                [_chooseDateArray addObject:dayDateEntity];
                [self.dayCollectionView reloadData];

            }
            else if (_chooseDateArray.count < 2 )
            {

                
                //如果已经选择的一个入住日期。需要进行对比。判断第二个选择的日期是否可用。
                if (_chooseDateArray.count == 1) {
                    
                    LSDayDataEntity * firstEntity = _chooseDateArray[0];
                    //入住时间的相关数据
                    NSDate * date = firstEntity.date;
                    //离店时间的相关数据
                    NSDate * out_Date = [dayDateEntity.dateString dateFromString];
                    
                    //比较时间。
                    
                    if ([out_Date isEqualToDate:date]) {
                        
                        NSLog(@"选择了相同的时间。");
                        return;
                    }
                    
                    
                    if ([out_Date laterDate:date] == date) {
                        
                        NSLog(@"新选择的日期。比已选择的日期旧");
                        return;
                    }
                }

                [_chooseDateArray addObject:dayDateEntity];
                [self.dayCollectionView reloadData];

            }
        }

        //多选
        else if (_type == 2)
        {

            [_chooseDateArray addObject:dayDateEntity];
            [self.dayCollectionView reloadData];
            
        }
    }
    
}

//确定选择。
-(void)submitThechoose
{
    if (_type == In_OutChoice && _chooseDateArray.count < 2) {
        
        NSLog(@"选择的数据不完全");
    }
    
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onChooseTheDate:)]) {
            
            [self.delegate onChooseTheDate:_chooseDateArray];
        }
    }
}

//headerview的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{

    return CGSizeMake(SCREEN_WIDTH, 35);

}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
       
        LSCalendarHeaderCollectionReusableView * headerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LSCalendarHeaderCollectionReusableView" forIndexPath:indexPath];
        
        headerview.dateTipLabel.text = [self.dataArray[indexPath.section] stringDate];
        
        reusableview = headerview;

    }

    return reusableview;
}


-(void)buildMVVM
{
    
}

-(void)reloadDateData
{
    
}

-(void)setDateArray:(NSMutableArray *)dateArray
{
    _chooseDateArray = dateArray;
    [self.dayCollectionView reloadData];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
