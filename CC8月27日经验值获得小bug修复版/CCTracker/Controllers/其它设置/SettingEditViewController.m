//
//  SettingEditViewController.m
//  CCTracker
//
//  Created by LWB on 15/8/19.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "SettingEditViewController.h"
#import "CCData.h"
@interface SettingEditViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *repeatPicker;

@property (weak, nonatomic) IBOutlet UISwitch *closeSwitch;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
@end

@implementation SettingEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    
    

    self.title = @"查看定时提醒";
    
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 46, 30);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"button2" ofType:@"png"]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"button" ofType:@"png"]] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(editValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteTip)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[item1,item];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSMutableArray * array = [NSMutableArray arrayWithArray: [CCData tiptimeFromCC]];

    NSDictionary * dic = array[self.num];
    if (dic) {
        if ([dic[@"close"] isEqualToString:@"0"]) {
            _timeLabel.text = @"定时提醒(已开启)";
            _timeLabel.textColor = [UIColor blackColor];
            _closeSwitch.on = YES;
        }else{
            _timeLabel.text = @"定时提醒(已关闭)";
            _timeLabel.textColor = [UIColor grayColor];
            _closeSwitch.on = NO;
        }
        
        [self pickerView:_repeatPicker didSelectRow:[dic[@"repeat"] integerValue]-1 inComponent:0];
    
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        
       NSDate * date = [formatter dateFromString:dic[@"alarm"]];
        
        
        [self.datePicker setDate:date];
        [self.datePicker setEnabled:NO];
        
        
        
        
    }


}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 7;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%ld",row+1];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    
}



-(void)deleteTip{
    
    
    NSArray * localArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    

    
    NSMutableArray * array = [NSMutableArray arrayWithArray: [CCData tiptimeFromCC]];
    
#pragma 取消第num个本地推送
    NSDictionary * dic = array[self.num];
    
    
    for (UILocalNotification * localNoti in localArray) {
        
        NSDictionary * dict = localNoti.userInfo;
        if (dict) {
            NSString * inKey = dict[@"info"];
            if ([inKey isEqualToString:dic[@"info"]]) {
                
                [[UIApplication sharedApplication]cancelLocalNotification:localNoti];
                
                
            }
            
        }
        
    }
    
    
    [array removeObjectAtIndex:self.num];
    
    [CCData changetipTimeWithArray:array];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)editValueChanged:(UIButton *)sender {
    self.saveButton.hidden = sender.selected;
    sender.selected = !self.saveButton.hidden;
    [_datePicker setEnabled:sender.selected];
    _closeSwitch.enabled = sender.selected;
    _repeatPicker.userInteractionEnabled = sender.selected;
    
    
}
- (IBAction)saveTip:(id)sender {
    
    
    NSArray * localArray = [[UIApplication sharedApplication]scheduledLocalNotifications];
    
    
    NSMutableArray * array = [NSMutableArray arrayWithArray: [CCData tiptimeFromCC]];
    NSString * info = array[self.num][@"info"];
    
#pragma 取消第num个本地推送
    
    
    for (UILocalNotification * noti in localArray) {
        
        NSDictionary * dic = noti.userInfo;
        if (dic) {
            
            if ([dic[@"info"] isEqualToString:info]) {
                
                [[UIApplication sharedApplication]cancelLocalNotification:noti];
                
                
            }
            
            
        }
        
        
    }
    
    
    
    
#pragma 添加第num个本地推送
    if (self.closeSwitch.isOn == YES) {
        
        UILocalNotification * newNoti = [[UILocalNotification alloc]init];
        
        
        if (newNoti) {
            newNoti.fireDate = _datePicker.date;
            newNoti.timeZone = [NSTimeZone defaultTimeZone];
           
          newNoti.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
          newNoti.alertBody = @"囚徒健身小助手提醒您:是时候开始今天的锻炼喽";
    newNoti.alertAction = @"打开";
            
            if ([[self pickerView:_repeatPicker titleForRow:[self.repeatPicker selectedRowInComponent:0] forComponent:0] floatValue] == 1) {
                
                
                newNoti.repeatInterval = kCFCalendarUnitDay;
                
                
                
            }
            newNoti.soundName =  UILocalNotificationDefaultSoundName;
            
            NSDictionary * inf = @{@"info":info};
            
            newNoti.userInfo = inf;
            [[UIApplication sharedApplication]scheduleLocalNotification:newNoti];
            
        }
        
        
        
    }
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString * date = [formatter stringFromDate:_datePicker.date];

    [array replaceObjectAtIndex:self.num withObject:@{@"close":[NSNumber numberWithBool:!self.closeSwitch.isOn].stringValue,@"alarm":date,@"repeat":[self pickerView:_repeatPicker titleForRow:[self.repeatPicker selectedRowInComponent:0] forComponent:0],@"info":info}];
    
    [CCData changetipTimeWithArray:array];
    
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (IBAction)back:(id)sender {
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
