//
//  SubWorkModel.m
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "SubWorkModel.h"
#import "CountModel.h"

@implementation SubWorkModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        NSArray * array = dic[@"norms"];
        NSMutableArray * counts = [NSMutableArray array];
        for (NSDictionary * d in array) {
            CountModel * model = [CountModel countWithDic:d];
            
            [counts addObject:model];
            
        }
        
        self.norms = counts;
        
        
    }
    return self;
}

+(instancetype)subworkWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}
@end
