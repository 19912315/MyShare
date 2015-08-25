//
//  ChangeTimeView.m
//  CCTravker
//
//  Created by LWB on 15/8/16.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "ChangeTimeView.h"
#import "CCData.h"
@interface ChangeTimeView ()

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;



@property (weak, nonatomic) IBOutlet UITextField *workField;
@property (weak, nonatomic) IBOutlet UITextField *restField;

@property (weak, nonatomic)UIAlertView *alert;



@end




@implementation ChangeTimeView




- (IBAction)saveChange:(UIButton *)sender {
    
    
    NSString * title;
    NSString * button;
    if (_workField.text.length&&_restField.text.length) {
        
//        [CCData changePadingTimeWith:_workField.text];
//        [CCData changeRestDurationWith:_restField.text];
        
        [CCData changeRecordTimeWith:_restField.text andPadingTime:_workField.text];
        
        
       title = @"保存成功";
        button = @"返回";
    }else{
        
        title = @"参数设置不能为空";
        button = @"取消设置";
        
    }
    
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
        [self endEditing:YES];
        [self closeView:self.closeBtn];
        
    }]];
        
        self.myBlock(al);
        

    }

    
}


- (IBAction)closeView:(UIButton *)sender {
    [self removeFromSuperview];
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
