//
//  SettingTableViewController.m
//  CCTravker
//
//  Created by LWB on 15/8/16.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "SettingTableViewController.h"
#import "ChangeTimeView.h"
#import "SettingDetailViewController.h"
#import "CCData.h"
@interface SettingTableViewController ()<UIAlertViewDelegate>{
    ChangeTimeView * _cv;
}

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary * dic = [CCData dicFromCC];
    CATransition * ani1 = [CATransition animation];
    
    ani1.type = @"cube";
    
    
    ani1.duration = 0.5;
    [self.navigationController.view.layer addAnimation:ani1 forKey:nil];
    
    
    

    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.section == 0 && indexPath.row == 0) {
        
     _cv = [[[NSBundle mainBundle]loadNibNamed:@"ChangeTimeView" owner:nil options:nil]lastObject];
      
        
        
        if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] ) {
            
            _cv.myBlock1 = ^(UIAlertView * al){
                al.delegate = self;
                [al show];
                
            };
            
            
            
        }else{
            
        
        _cv.myBlock = ^(UIAlertController* al){
            
            
            
            [self presentViewController:al animated:YES completion:nil];
        };
            
        }
            
            
            _cv.frame = [UIScreen mainScreen].bounds;
                
        [self.view addSubview:_cv];
        
    }else{
        
        
        [self performSegueWithIdentifier:@"Setting" sender:indexPath];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 1) {
        
        
        
        
        CATransition * ani1 = [CATransition animation];
        
        ani1.type = @"pageCurl";
        
        
        ani1.duration = 0.5;
        [_cv.layer addAnimation:ani1 forKey:nil];
        
        _cv.backgroundColor = [UIColor clearColor];
        for (UIView * view in _cv.subviews) {
            [view removeFromSuperview];
            
        }
        [_cv performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
//        [_cv removeFromSuperview];
        

        
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    SettingDetailViewController * vc = [segue destinationViewController];
   
    NSIndexPath* indexpath = sender;
    vc.num1 = indexpath.section;
    vc.num2 = indexpath.row;
    
    vc.hidesBottomBarWhenPushed = YES;
    
    
}


@end
