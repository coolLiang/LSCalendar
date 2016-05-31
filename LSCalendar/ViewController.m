//
//  ViewController.m
//  LSCalendar
//
//  Created by noci on 16/5/31.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "ViewController.h"

#import "LSCalendarView.h"

@interface ViewController ()<LSCalendarViewDelegate>

@property(nonatomic,strong)LSCalendarView * lsCalendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lsCalendarView = [[LSCalendarView alloc]initWithCalendarType:In_OutChoice andChoosedDateArray:nil];
    self.lsCalendarView.delegate = self;
    self.lsCalendarView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400);
    
    [self.view addSubview:self.lsCalendarView];
    
    
    [UIView animateWithDuration:1 animations:^{
        
        self.lsCalendarView.frame = CGRectMake(0, SCREEN_HEIGHT - 464, SCREEN_WIDTH, 400);
        
        
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - calendarDelegate

-(void)onChooseTheDate:(NSMutableArray *)dateArray
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
