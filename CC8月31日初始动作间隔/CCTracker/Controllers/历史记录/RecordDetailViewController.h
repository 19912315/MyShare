//
//  RecordDetailViewController.h
//  CCTracker
//
//  Created by LWB on 15/8/17.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
@interface RecordDetailViewController : UIViewController
@property(nonatomic,strong)Workout * workout;
@property(nonatomic,assign)NSInteger num;
@end
