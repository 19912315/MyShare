//
//  DailyDetailViewController.m
//  CCTracker
//
//  Created by LWB on 15/8/16.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "DailyDetailViewController.h"
#import "SubWorkModel.h"
#import "CountModel.h"
#import "DailyExerciseViewController.h"
#import "CCData.h"
@interface DailyDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    NSArray * _dataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DailyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.workout.chname;
  
    
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    
    

    
  
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     self.workout = [CCData workoutFromCCAtIndex:self.num];
    
      _dataArray = self.workout.subwork;
    
      [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    SubWorkModel * model = _dataArray[section];
    return model.subname;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DailyCell" forIndexPath:indexPath];
    NSArray * arr = @[@"初级",@"中级",@"高级"];
    
    cell.textLabel.text = arr[indexPath.row];
    SubWorkModel * model = _dataArray[indexPath.section];
    CountModel * min = model.norms[indexPath.row];
    if (self.num == 5 && indexPath.section < 3) {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@组%@秒",min.section,min.time];
    }else{
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@组%@个",min.section,min.time];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.workout.level.integerValue >= indexPath.section && self.workout.exp.integerValue/34 >= indexPath.row) {
        NSString * title = [self tableView:self.tableView titleForHeaderInSection:indexPath.section];
        [self performSegueWithIdentifier:@"Daily" sender:@[title,indexPath]];
        
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
                
                
                NSString * title = [self tableView:self.tableView titleForHeaderInSection:self.workout.level.integerValue];
                
                
                [self performSegueWithIdentifier:@"Daily" sender:@[title,[NSIndexPath indexPathForRow:self.workout.exp.integerValue/34 inSection:self.workout.level.integerValue]]];
                
                
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
        
        NSString * title = [self tableView:self.tableView titleForHeaderInSection:self.workout.level.integerValue];
        
        
        [self performSegueWithIdentifier:@"Daily" sender:@[title,[NSIndexPath indexPathForRow:self.workout.exp.integerValue/34 inSection:self.workout.level.integerValue]]];
        

    }
    
    
}





- (IBAction)back:(id)sender {
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)changePageWith:(NSString *)title andIndexPath:(NSIndexPath*)indexPath{
    
    
    [self performSegueWithIdentifier:@"Daily" sender:@[title,indexPath]];
    

    
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
    vc.title = sender[0];
    NSIndexPath * indexPath = sender[1];
       vc.num = self.num;
    vc.section = indexPath.section;
    vc.period = indexPath.row;
    
    vc.hidesBottomBarWhenPushed = YES;

}


@end
