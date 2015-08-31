//
//  SubWorkModel.h
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubWorkModel : NSObject
@property(nonatomic,copy)NSString * count;

@property(nonatomic,copy)NSString *subname;

@property(nonatomic,strong)NSArray* norms;

+(instancetype)subworkWithDic:(NSDictionary *)dic;
@end
