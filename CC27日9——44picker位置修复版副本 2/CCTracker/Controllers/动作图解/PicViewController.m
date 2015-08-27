//
//  PicViewController.m
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "PicViewController.h"
#import "Workout.h"
#import "PicCell.h"
#import "CCData.h"
#import "SubWorkModel.h"

#import "PicMoreViewController.h"
@interface PicViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIPickerViewDataSource,UIPickerViewDelegate>{

    NSArray * _dataArray;
    Workout * _selectedWorkout;
    
    NSInteger _num;
    NSInteger _apRow;
   
}



@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation PicViewController

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
    
    _dataArray = [CCData worksOfCCTracker];

    [self.tableView reloadData];
    
    
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _collectionView.frame.size;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"tabCell" forIndexPath:indexPath];

    
    Workout * workout = _dataArray[indexPath.row];
   
    
    cell.textLabel.text = workout.chname;
    return cell;

}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     PicCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PicCell" forIndexPath:indexPath];
    
    cell.iconImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@%ld.jpg",_selectedWorkout.large_icon,(long)indexPath.row] ofType:nil]];
    
    return cell;
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return pickerView.bounds.size.height/3;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
      SubWorkModel* subWorkModel = _selectedWorkout.subwork[row];
    
    return [NSString stringWithFormat:@"第%ld式%@",row+1,subWorkModel.subname];
    

    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   _selectedWorkout = _dataArray[indexPath.row];
    _num = indexPath.row;
    [_pickerView reloadAllComponents];
    [_collectionView reloadData];
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    // collectionView 水平滚动到相应位置UICollectionViewScrollPositionRight
    
   [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
  [self performSegueWithIdentifier:@"PicMore" sender:indexPath];

    
    
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
   
  
        _apRow = indexPath.row;
        
    
    
    
}



-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_apRow == indexPath.row) {
        return;
    }
    [_pickerView selectRow:_apRow inComponent:0 animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
   PicMoreViewController * vc = [segue destinationViewController];

    vc.num = _num;
    NSIndexPath * indexPath = sender;
    
    vc.row = indexPath.row;
    
    vc.hidesBottomBarWhenPushed = YES;
   
    
}


@end
