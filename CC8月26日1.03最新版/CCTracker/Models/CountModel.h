//
//  CountModel.h
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountModel : NSObject

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *section;

+(instancetype)countWithDic:(NSDictionary *)dic;
@end
