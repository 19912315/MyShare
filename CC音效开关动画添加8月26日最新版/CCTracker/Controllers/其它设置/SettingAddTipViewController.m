//
//  SettingAddTipViewController.m
//  CCTracker
//
//  Created by LWB on 15/8/18.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "SettingAddTipViewController.h"
#import "CCData.h"

@interface SettingAddTipViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UIDatePicker * _datePicker;
    NSString * _dateData;
    NSString * _repeatData;
    
}
@property (weak, nonatomic) IBOutlet UITextField *tipField;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation SettingAddTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    
    
    

    _repeatData = @"1";
    self.title = @"添加定时提醒";
    
    [_pickerView reloadAllComponents];
    
     _datePicker = [[UIDatePicker alloc]init];
    
    NSLocale * locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _datePicker.locale = locale;
    
    
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
   self.tipField.inputView = _datePicker;
    UIToolbar * tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, _datePicker.bounds.size.width, 44)];
    tool.translucent = NO;
    tool.barTintColor = [UIColor orangeColor];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(postValueToField)];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    tool.items = @[item1,item];
    self.tipField.inputAccessoryView = tool;
    
  
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_pickerView selectRow:0 inComponent:0 animated:YES];
}
- (IBAction)saveTipTimeSetting{
    _repeatData = [NSString stringWithFormat:@"%ld",[_pickerView selectedRowInComponent:0]+1];
    
    NSMutableArray * dataArray = [NSMutableArray arrayWithArray:[CCData tiptimeFromCC]];
   
    UILocalNotification * localNoti = [[UILocalNotification alloc]init];

     
    if (localNoti) {
        localNoti.fireDate =_datePicker.date;
        if (_repeatData.integerValue == 1) {
            
            localNoti.repeatInterval = kCFCalendarUnitDay;
        }
        
        localNoti.timeZone = [NSTimeZone defaultTimeZone];
        localNoti.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
        localNoti.alertBody = @"囚徒健身小助手提醒您:是时候开始今天的锻炼喽";
        localNoti.alertAction = @"打开";
        NSDictionary * info = @{@"info":[NSString stringWithFormat:@"%ld",(unsigned long)dataArray.count]};
        localNoti.userInfo = info;
        localNoti.soundName =  UILocalNotificationDefaultSoundName;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
    
    
    
    
    
    
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    [dataArray addObject:@{@"close":@"0",@"info":[NSString stringWithFormat:@"%ld",(unsigned long)dataArray.count],@"alarm":_dateData,@"repeat":_repeatData}];
    [CCData changetipTimeWithArray:dataArray];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}


-(void)postValueToField{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
 _dateData = [formatter stringFromDate:_datePicker.date];
    NSString * date = [[_dateData componentsSeparatedByString:@" "]lastObject];
    self.tipField.text = [NSString stringWithFormat:@"%@",date];
    
    self.saveButton.enabled = YES;
    
    [_tipField resignFirstResponder];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 7;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%ld",row+1];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _repeatData = [NSString stringWithFormat:@"%ld",row+1];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.navigationBar.layer addAnimation:ani1 forKey:nil];
    

    [self.navigationController popViewControllerAnimated:YES];
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
