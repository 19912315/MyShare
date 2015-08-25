//
//  DailyExerciseViewController.m
//  CCTracker
//
//  Created by LWB on 15/8/16.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "DailyExerciseViewController.h"
#import "SubWorkModel.h"
#import "CountModel.h"
#import "CCData.h"
 #import <AVFoundation/AVFoundation.h>
@interface DailyExerciseViewController ()
{
    
    NSTimer * _workTimer;
    NSTimer * _restTimer;
    NSString * _imagePath;
    NSInteger _count;
    CountModel * _model;
    NSInteger _workCounts;
    SubWorkModel * _subwork;
    CGFloat _padingtime;
    CGFloat _restDuration;
    AVSpeechSynthesizer * _speech;
    AVSpeechUtterance * _utterance;

}
@property(nonatomic,strong)Workout * workout;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelBottomConstraint;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewBottomConstraint;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *restImageView;


@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;



@end

@implementation DailyExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
       NSArray * dataArray = [CCData worksOfCCTracker];
    self.workout = dataArray[self.num];
    
    
    
  _speech = [[AVSpeechSynthesizer alloc]init];

    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)loadData{
    
    _workCounts = 0;
    _count = 0;
    _subwork = self.workout.subwork[self.section];
    self.title = _subwork.subname;
    
    _model = _subwork.norms[self.period];
    _imagePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@%ld.jpg",self.workout.large_icon,self.section] ofType:nil];
    
    self.restImageView.image = [UIImage imageWithContentsOfFile:_imagePath];
    
    self.recordLabel.text = [NSString stringWithFormat:@"0/%@",_model.time];
    
    
    
}

- (IBAction)closeCurrentWindow{
    [self.bgView removeFromSuperview];
    
    self.startButton.hidden = NO;
}

- (IBAction)startTraining:(UIButton *)sender {
    
    
    
    
    
    
    
    if (_workCounts < _model.section.integerValue) {
        _utterance = [AVSpeechUtterance speechUtteranceWithString:@"准备好了吗?现在开始锻炼"];
        _utterance.rate = 0.1;
        [_speech speakUtterance:_utterance];
    }
    if (_workCounts < _model.section.integerValue) {
        
    
        self.bgView.hidden = NO;
    
        self.closeButton.hidden = YES;
        sender.hidden = YES;
        [self performSelector:@selector(addWorkTimer) withObject:nil afterDelay:5];
        
        
          }else{
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
    
    
    
}

-(void)addWorkTimer{
    _padingtime = [CCData paddingTimeFromCC].floatValue;
    
    _workTimer = [NSTimer scheduledTimerWithTimeInterval:_padingtime target:self selector:@selector(countChange:) userInfo:nil repeats:YES];
    
    
    
}

-(void)countChange:(NSTimer *)timer{
    
    if (_count < _model.time.integerValue) {
        _count++;
        self.recordLabel.text = [NSString stringWithFormat:@"%ld/%@",_count,_model.time];
        
        _utterance = [AVSpeechUtterance speechUtteranceWithString:[NSString stringWithFormat:@"%ld",_count]];
        
        _utterance.rate = 0.1;
        [_speech speakUtterance:_utterance];
        
        
        
    }else{
        
        
        _restDuration = [CCData durationFromCC].floatValue;
        
        [_workTimer invalidate];
        _workTimer = nil;
        _count = _restDuration;
        _workCounts++;
        
        
        if (_workCounts<_model.section.integerValue) {
            self.restImageView.image = [UIImage imageNamed:@"rest.png"];
            _utterance = [AVSpeechUtterance speechUtteranceWithString:@"现在开始休息"];
            
            _utterance.rate = 0.1;
            [_speech speakUtterance:_utterance];
            

            _restTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(restTime:) userInfo:nil repeats:YES];
            
            
        }else{
            
            
            _utterance = [AVSpeechUtterance speechUtteranceWithString:@"恭喜完成这次的锻炼"];
            
            _utterance.rate = 0.1;
            [_speech speakUtterance:_utterance];
            

            
            
            if ((self.workout.level.integerValue == self.section && self.workout.exp.integerValue/34 > self.period)|| self.workout.level.integerValue > self.section) {
                
                
                self.recordLabel.text = @"完成任务,需进行更高等级任务才可获得EXP";
                
            }else{
                
                
                
                if (self.workout.exp.integerValue<99) {
                    [CCData addExpWithWorkout:self.workout];
                    self.recordLabel.text = @"完成任务EXP+1";
                }else{
                    [CCData addLevelWithWorkout:self.workout];
                    self.recordLabel.text = @"EXP+1等级提升";
                    
                }
                
                
            }
            
            
            _subwork.count = [NSString stringWithFormat:@"%ld",_subwork.count.integerValue+1];
            
            self.workout = [CCData replaceWorkout:self.workout AtSection:self.section withSubwork:_subwork];
            
            
            [CCData replaceElementWithWorkout:self.workout atIndex:self.num];
            
            
            [self.restImageView removeFromSuperview];
            
            
            
            self.recordLabel.textColor = [UIColor blueColor];
            
            self.bgView.alpha = 1;
            self.bgView.backgroundColor = [UIColor grayColor];
            

            [UIView animateWithDuration:1 animations:^{
                
                
                
                self.bgViewBottomConstraint.constant = 0;
                
                
                self.recordLabel.textColor = [UIColor greenColor];
                
                self.bgView.alpha = 0.5;
                self.bgView.backgroundColor = [UIColor yellowColor];
                
                
                
                
            } completion:^(BOOL finished) {
                self.closeButton.hidden = NO;
                
                self.bgViewBottomConstraint.constant = 0;
                self.labelBottomConstraint.constant = self.view.bounds.size.height/2;
                
                [self.startButton setTitle:@"返回首页" forState:UIControlStateNormal];
                self.navigationController.navigationBarHidden = NO;
                self.startButton.titleLabel.font = [UIFont systemFontOfSize:15];
                
              
                
                self.bgView.backgroundColor = [UIColor brownColor];
                
                self.bgView.alpha = 0.7;
                
                self.recordLabel.font = [UIFont boldSystemFontOfSize:30];
                
                self.recordLabel.alpha = 1;
                self.recordLabel.textColor = [UIColor orangeColor];
                
                self.recordLabel.backgroundColor = [UIColor purpleColor];
               
              
                
                
               
                
                
                
                
                
            }];
            
            
            
        }
        
        
        
        
    }
    
    
    
}


- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)restTime:(NSTimer*)timer{
    
    if(_count <= 5){
        
        _utterance = [AVSpeechUtterance speechUtteranceWithString:[NSString stringWithFormat:@"%ld",_count]];
        
        _utterance.rate = 0.1;
        [_speech speakUtterance:_utterance];
        

    }
    
    
    
    
    if (_count>0){
        
        
        
        
        _restDuration = [CCData durationFromCC].floatValue;
        self.recordLabel.text = [NSString stringWithFormat:@"休息:%ld/%f",_count,_restDuration];
        
        _count--;
        
    }else{
        self.restImageView.image = [UIImage imageWithContentsOfFile:_imagePath];
        
        
        [_restTimer invalidate];
        _restTimer=nil;
        [self addWorkTimer];
    }
    
    
    
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
