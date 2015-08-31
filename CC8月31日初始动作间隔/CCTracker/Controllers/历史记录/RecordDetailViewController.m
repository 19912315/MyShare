//
//  RecordDetailViewController.m
//  CCTracker
//
//  Created by LWB on 15/8/17.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "RecordDetailViewController.h"
#import "SubWorkModel.h"
#import "DailyExerciseViewController.h"
#import "CCData.h"
@interface RecordDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation RecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    

    // Do any additional setup after loading the view.
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.workout = [CCData workoutFromCCAtIndex:self.num];
    
    [self.tableView reloadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    SubWorkModel * model = self.workout.subwork[section];
    return model.subname;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RecordDetailCell" forIndexPath:indexPath];
    
    SubWorkModel * model = self.workout.subwork[indexPath.section];
    if (model.count.integerValue > 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"完成了%@次",model.count];
        
    }else if(model.count.integerValue == 0){
        cell.textLabel.text = @"你还没有训练过哦";
        
    }
    
    return cell;
    
}
- (IBAction)back:(UIBarButtonItem *)sender {
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    

    [self.navigationController popViewControllerAnimated:YES];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.workout.level.integerValue >= indexPath.section) {
        
        [self performSegueWithIdentifier:@"HisToTrain" sender:[NSIndexPath indexPathForRow:self.workout.exp.integerValue/34 inSection:indexPath.section]];
        
        
    }else{
        
        
        
        
        if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch]){
            
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"请选择适合自己的训练强度以免关节过度磨损" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"返回首页",@"推荐强度", nil];
            [alert show];
            
            
            
        }else{

        UIAlertController * al = [UIAlertController alertControllerWithTitle:@"请选择适合自己的训练强度以免关节过度磨损" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [al addAction:[UIAlertAction actionWithTitle:@"返回首页" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [al addAction:[UIAlertAction actionWithTitle:@"推荐强度" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self performSegueWithIdentifier:@"HisToTrain" sender:[NSIndexPath indexPathForRow:self.workout.exp.integerValue/34 inSection:self.workout.level.integerValue]];
            
            
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
        
        [self performSegueWithIdentifier:@"HisToTrain" sender:[NSIndexPath indexPathForRow:self.workout.exp.integerValue/34 inSection:self.workout.level.integerValue]];
        
        
        
    }
    
    
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
 
 
     DailyExerciseViewController * vc = [segue destinationViewController];
     NSIndexPath * indexPath = sender;
   
 
     vc.num = self.num;
     vc.section = indexPath.section;
     vc.period = indexPath.row;
 
     vc.hidesBottomBarWhenPushed = YES;
 
 

 
 
}


@end
