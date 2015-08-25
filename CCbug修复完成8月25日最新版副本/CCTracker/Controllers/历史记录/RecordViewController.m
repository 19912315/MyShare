//
//  RecordViewController.m
//  CCTracker
//
//  Created by LWB on 15/8/17.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "RecordViewController.h"

#import "HisCell.h"
#import "CCData.h"
#import "RecordDetailViewController.h"
@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * _dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _dataArray = [CCData worksOfCCTracker];
    [self.tableView reloadData];
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HisCell" forIndexPath:indexPath];
    cell.workout = _dataArray[indexPath.section];
    
    
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    Workout* workout =  _dataArray[section];
    
    
    return workout.chname;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Workout * workout = _dataArray[indexPath.section];
    
    [self performSegueWithIdentifier:@"HisPush" sender:@[workout,indexPath]];
    
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
 
 
 RecordDetailViewController* vc = [segue destinationViewController];
 
 
 Workout * workout = sender[0];
 
 NSIndexPath * indexPath = sender[1];
 
 vc.title = [NSString stringWithFormat:@"%@训练历史",workout.chname];
 
 vc.num = indexPath.section;
 
 vc.hidesBottomBarWhenPushed = YES;
 
}


@end
