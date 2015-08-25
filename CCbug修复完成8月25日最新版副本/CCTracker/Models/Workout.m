//
//  Workout.m
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "Workout.h"
#import "SubWorkModel.h"
@implementation Workout
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        NSArray * array = dic[@"subwork"];
        NSMutableArray * counts = [NSMutableArray array];
        for (NSDictionary * d in array) {
            SubWorkModel * model = [SubWorkModel subworkWithDic:d];
            
            [counts addObject:model];
            
        }
        
       self.subwork = counts;

              
    }
    return self;
}

+(instancetype)workWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}
@end
