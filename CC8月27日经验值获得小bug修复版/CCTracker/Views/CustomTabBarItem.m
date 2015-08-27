//
//  CustomTabBarItem.m
//  CCTravker
//
//  Created by LWB on 15/8/14.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "CustomTabBarItem.h"

@implementation CustomTabBarItem
-(void)awakeFromNib{
    
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor]} forState:UIControlStateSelected];
    
}
@end
