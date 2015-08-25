//
//  PicDetailCollectionViewController.m
//  CCTracker
//
//  Created by LWB on 15/8/17.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "PicDetailCollectionViewController.h"
#import "DailyExerciseViewController.h"
#import "PicDetailCell.h"
#import "SubWorkModel.h"
@interface PicDetailCollectionViewController ()<UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>{
    
    NSInteger _apRow;
    
    
}

@end

@implementation PicDetailCollectionViewController

static NSString * const reuseIdentifier = @"PDCell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _apRow = self.row;
    
    
    [self.collectionView reloadData];
    
    
  //  self.navigationController.navigationBarHidden = YES;

    

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[PicDetailCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
      [self scrollToBeginPosition];
}

-(void)scrollToBeginPosition{
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    
    SubWorkModel * subworkModel = _workout.subwork[self.row];
    self.title = [NSString stringWithFormat:@"第%ld式%@",self.row+1,subworkModel.subname];
    


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

#pragma mark <UICollectionViewDataSource>
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.workout.subwork.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PicDetailCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    
    
    cell.bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@%ld.jpg",_workout.large_icon,(long)indexPath.row] ofType:nil]];

    
    
    
    return cell;
}



- (IBAction)gotoExercise:(id)sender {
    
    
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



-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    _apRow = indexPath.row;
}


-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_apRow == indexPath.row) {
    
        return;
    }
    SubWorkModel * subworkModel = _workout.subwork[_apRow];
    self.title = [NSString stringWithFormat:@"第%ld式%@",_apRow+1,subworkModel.subname];
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.bounds.size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
    
    SubWorkModel * subworkModel = _workout.subwork[indexPath.row];
    self.title = [NSString stringWithFormat:@"第%ld式%@",indexPath.row+1,subworkModel.subname];
    
    self.row = indexPath.row;

    
    
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DailyExerciseViewController * vc = [segue destinationViewController];
    
    vc.section = [sender integerValue];
    
    vc.num = self.num;
    
    vc.period = self.workout.exp.integerValue/34;
   
    vc.hidesBottomBarWhenPushed = YES;
    
    
   
}
@end
