//
//  PicMoreViewController.h
//  CCTracker
//
//  Created by LWB on 15/8/25.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
@interface PicMoreViewController : UIViewController
@property(nonatomic,strong)Workout * workout;
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,assign)NSInteger row;
@end
