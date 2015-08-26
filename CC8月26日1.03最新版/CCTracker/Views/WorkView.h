//
//  WorkView.h
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Workout;
@interface WorkView : UIView

@property(nonatomic)Workout * workout;

+(instancetype)workViewWithReusingView:(UIView *)reusingView;
+(CGFloat)workViewHeight;
@end
