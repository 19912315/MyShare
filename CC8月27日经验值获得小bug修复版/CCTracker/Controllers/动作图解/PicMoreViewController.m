//
//  PicMoreViewController.m
//  CCTracker
//
//  Created by LWB on 15/8/25.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "PicMoreViewController.h"
#import "SubWorkModel.h"
#import "CCData.h"
@interface PicMoreViewController (){
    
    int _index;
   
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation PicMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    
//    
//    
//    _iconImageView.backgroundColor = [UIColor greenColor];
//    _iconImageView.userInteractionEnabled = YES;
 
    _index = (int)self.row;
    
    
    
    UISwipeGestureRecognizer * leftSgr = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    leftSgr.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [_iconImageView addGestureRecognizer:leftSgr];
    
    UISwipeGestureRecognizer * rightSgr = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    rightSgr.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [_iconImageView addGestureRecognizer:rightSgr];
    
       
    
    
 //   [self.view addSubview:_iconImageView];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animate{
    [super viewWillAppear:animate];
    
    self.workout = [CCData workoutFromCCAtIndex:self.num];
    
    SubWorkModel * subworkModel = _workout.subwork[_index];
    self.title = subworkModel.subname;
    _iconImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@%d.jpg",_workout.large_icon,_index] ofType:nil]];
    
    

    
    
    
}





-(void)swipe:(UISwipeGestureRecognizer*)sgr{
    
    CATransition * ani = [CATransition animation];
    if (sgr.direction & UISwipeGestureRecognizerDirectionLeft) {
        
        
        ani.type = @"cube";
        ani.duration = 0.5;
        _index ++;
        if (_index == 10) {
            _index = 0;
        }
        ani.subtype = @"fromRight";
        [_iconImageView.layer addAnimation:ani forKey:nil];
        _iconImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@%d.jpg",_workout.large_icon,_index] ofType:nil]];
        
        SubWorkModel * subworkModel = _workout.subwork[_index];
        self.title = subworkModel.subname;

        
        
    }else if (sgr.direction & UISwipeGestureRecognizerDirectionRight){
        _index--;
        if (_index == -1) {
            _index = 9;
        }
        
        ani.subtype = @"fromLeft";
        [_iconImageView.layer addAnimation:ani forKey:nil];
        
        _iconImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@%d.jpg",_workout.large_icon,_index] ofType:nil]];
        
        
        SubWorkModel * subworkModel = _workout.subwork[_index];
        self.title = subworkModel.subname;

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gotoExercise {
    
    
    if (self.workout.level.integerValue >= self.row) {
        
        [self performSegueWithIdentifier:@"PToE" sender:[NSString stringWithFormat:@"%ld",(long)self.row]];
        
    }else{
        
        
        
        
        
        if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch]){
            
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"请选择适合自己的训练强度以免关节过度磨损" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"返回首页",@"推荐强度", nil];
            [alert show];
            
            
            
        }else{
            
            UIAlertController * al = [UIAlertController alertControllerWithTitle:@"请选择适合自己的训练强度以免关节过度磨损" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [al addAction:[UIAlertAction actionWithTitle:@"返回首页" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }]];
            [al addAction:[UIAlertAction actionWithTitle:@"推荐强度" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self performSegueWithIdentifier:@"PToE" sender:self.workout.level];
                
                
            }]];
            [al addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                
                
            }]];
            
            [self presentViewController:al animated:YES completion:nil];
            
            
        }
        
    }
    
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }else if (buttonIndex == 2){
        
        [self performSegueWithIdentifier:@"PToE" sender:self.workout.level];
        
    }
    
    
}

- (IBAction)back{
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    
    
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
