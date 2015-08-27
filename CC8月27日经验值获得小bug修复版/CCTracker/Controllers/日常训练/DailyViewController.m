//
//  DailyViewController.m
//  CCTracker
//
//  Created by LWB on 15/8/16.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "DailyViewController.h"
#import "CCData.h"
#import "Workout.h"
#import "WorkView.h"
#import "DailyDetailViewController.h"
@interface DailyViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray * _dataArray;
}

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation DailyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    

    
    _dataArray = [CCData worksOfCCTracker];

    // Do any additional setup after loading the view.
}




-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataArray.count;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    WorkView * workView = [WorkView workViewWithReusingView:view];
    workView.workout = _dataArray[row];
    return workView;
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return [WorkView workViewHeight];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    DailyDetailViewController * vc = [segue destinationViewController];
    
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    
    vc.num = row;
    
   
    vc.hidesBottomBarWhenPushed = YES;
    
    
    
    
    
}


@end
