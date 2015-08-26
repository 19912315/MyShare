//
//  Workout.h
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Workout : NSObject
@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *exp;

@property(nonatomic,copy)NSString *level;

@property(nonatomic,copy)NSString *small_icon;


@property(nonatomic,copy)NSString *large_icon;

@property(nonatomic,copy)NSString *chname;

@property(nonatomic,strong)NSArray * subwork;


+(instancetype)workWithDic:(NSDictionary *)dic;
@end
