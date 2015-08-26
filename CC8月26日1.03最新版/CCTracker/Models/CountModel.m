//
//  CountModel.m
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "CountModel.h"

@implementation CountModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)countWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}
@end
