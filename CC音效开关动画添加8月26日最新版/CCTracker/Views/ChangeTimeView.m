//
//  ChangeTimeView.m
//  CCTravker
//
//  Created by LWB on 15/8/16.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "ChangeTimeView.h"
#import "CCData.h"
@interface ChangeTimeView ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    
    NSString * workTime;
    NSString * restTime;
    NSString * voiceclose;
    
    
}

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;



@property (weak, nonatomic) IBOutlet UITextField *workField;
@property (weak, nonatomic) IBOutlet UITextField *restField;



@property (weak, nonatomic) IBOutlet UIPickerView * workPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *restPicker;

@property (weak, nonatomic) IBOutlet UISwitch *voiceSwitch;

@property (weak, nonatomic) IBOutlet UILabel *voiceLabel;




@property (weak, nonatomic)UIAlertView *alert;



@end




@implementation ChangeTimeView

-(void)awakeFromNib{

    [_workPicker selectRow:0 inComponent:0 animated:YES];
    [_restPicker selectRow:0 inComponent:0 animated:YES];
     voiceclose = self.voiceSwitch.isOn?@"1":@"0";
    
    workTime = [self pickerView:_workPicker titleForRow:[_workPicker selectedRowInComponent:0] forComponent:0];
    
   restTime = [self pickerView:_restPicker titleForRow:[_restPicker selectedRowInComponent:0] forComponent:0];
    
    
    
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
    
    
    
}


- (IBAction)voiceChange:(UISwitch*)swt {
    
    self.voiceLabel.text = swt.isOn?@"提示音(开启)":@"提示音(关闭)";
    voiceclose = swt.isOn?@"1":@"0";
    
    
}



-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    NSString * str;
    if (pickerView == _workPicker) {
        str = [NSString stringWithFormat:@"%ld",row+1];
    }else if(pickerView == _restPicker){
        
        str = [NSString stringWithFormat:@"%ld",row*5+10];
    }
    return str;
    

}



- (IBAction)saveChange:(UIButton *)sender {
    
    workTime = [self pickerView:_workPicker titleForRow:[_workPicker selectedRowInComponent:0] forComponent:0];
    
    restTime = [self pickerView:_restPicker titleForRow:[_restPicker selectedRowInComponent:0] forComponent:0];
    

    NSString * title;
    NSString * button;
        
        [CCData changeRecordTimeWith:restTime andPadingTime:workTime andVoiceTurnOff:voiceclose];
    
        
        
       title = @"保存成功";
        button = @"返回";
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch]) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:title message:@"" delegate:nil cancelButtonTitle:@"重新设置" otherButtonTitles:button, nil];
        self.alert = al;
        self.myBlock1(self.alert);

    
    }else{
    UIAlertController * al = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [al addAction:[UIAlertAction actionWithTitle:@"重新设置" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        
    }]];
    [al addAction:[UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [al dismissViewControllerAnimated:YES completion:nil];
     
        [self closeView:self.closeBtn];
        
    }]];
        
        self.myBlock(al);
        

    }

    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    
    return 40;
    
}
- (IBAction)closeView:(UIButton *)sender {
    
    
    
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"pageCurl";
    
    
    ani1.duration = 0.5;
    [self.layer addAnimation:ani1 forKey:nil];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
        
    }

    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
    
    
//    [self removeFromSuperview];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
