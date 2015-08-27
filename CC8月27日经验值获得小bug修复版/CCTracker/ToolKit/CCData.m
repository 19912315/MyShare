//
//  CCData.m
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "CCData.h"
#define DATAPATH [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"cctracker.plist"]
// #define DATAPATH [[NSBundle mainBundle]pathForResource:@"cctracker.plist" ofType:nil]

@implementation CCData

+(NSString*)voiceTurnOffFromCC{
    
    NSDictionary*dic = [CCData dicFromCC];
    
    NSString * str = dic[@"voiceturnoff"];
    
    return str;

    
}

+(NSDictionary*)dicFromCC{
    
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:DATAPATH];
    
    
    if (dic) {
        return dic;
    }else{
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cctracker.plist" ofType:nil]];
    }
    
}
+(NSArray *)arrayFromCCtracker{
    //    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cctracker.plist" ofType:nil]];
   
    NSDictionary * dic = [CCData dicFromCC];
    
    return [NSArray arrayWithArray:dic[@"data"]];
}


+(NSDictionary *)dicFromCCAtIndex:(NSInteger)index
{
    
    return [CCData arrayFromCCtracker][index];
}
+(NSArray*)subworkFromCCAtIndex:(NSInteger)index
{
    return [CCData dicFromCCAtIndex:index][@"subwork"];
}
+(NSDictionary*)subDicFromCCAtIndex:(NSInteger)index section:(NSInteger)section
{
    return [CCData subworkFromCCAtIndex:index][section];
}
+(NSArray *)dailyWorksFromCCAtIndex:(NSInteger)index section:(NSInteger)section
{
    return [CCData subDicFromCCAtIndex:index section:section][@"norms"];
}
+(NSDictionary*)trainNormFromCCAtIndex:(NSInteger)index section:(NSInteger)section period:(NSInteger)period{
    return [CCData dailyWorksFromCCAtIndex:index section:section][period];
    
}



+(void)changeRootValueWith:(NSDictionary*)dic{
    [dic writeToFile:DATAPATH atomically:YES];
    
}


+(NSString *)paddingTimeFromCC{
    
    NSDictionary*dic = [CCData dicFromCC];
   
NSString * str = dic[@"padingtime"];
    
    return str;
    
    
}
+(NSString*)durationFromCC{
    
    NSDictionary*dic = [CCData dicFromCC];
    
    NSString * str = dic[@"restduration"];
    
    return str;
}


#pragma Mark 添加删除定时提醒
+(NSArray*)tiptimeFromCC{
    NSDictionary * dic = [CCData dicFromCC];
    
    NSArray * array = dic[@"tiptime"];
    
    return array;
    
}

+(void)changetipTimeWithArray:(NSArray*)array{
    
    NSDictionary * dic = [CCData dicFromCC];
    
    NSDictionary * d = @{@"tiptime":array,@"data":dic[@"data"],@"padingtime":dic[@"padingtime"],@"restduration":dic[@"restduration"],@"voiceturnoff":dic[@"voiceturnoff"]};
    
    
    [CCData changeRootValueWith:d];
    
    
    

    
}


#pragma mark 修改时间间隔
+(void)changePadingTimeWith:(NSString*)time{
   
  //  NSArray * array = [CCData arrayFromCCtracker];
    NSString * duration = [CCData durationFromCC];
    NSDictionary * dic = [CCData dicFromCC];
    

    
    NSDictionary * d = @{@"tiptime":dic[@"tiptime"],@"data":dic[@"data"],@"padingtime":time,@"restduration":duration,@"voiceturnoff":dic[@"voiceturnoff"]};
    

    [CCData changeRootValueWith:d];
    
    
    
}


+(void)changeRecordTimeWith:(NSString*)duration andPadingTime:(NSString*)time andVoiceTurnOff:(NSString *)turnoff{
    
    
    NSDictionary * dic = [CCData dicFromCC];
    
    
    
    NSDictionary * d = @{@"tiptime":dic[@"tiptime"],@"data":dic[@"data"],@"padingtime":time,@"restduration":duration,@"voiceturnoff":turnoff};
    
    
    [CCData changeRootValueWith:d];
    
    
}


+(void)changeRestDurationWith:(NSString*)duration{
     // NSArray * array = [CCData arrayFromCCtracker];
    NSString * time = [CCData durationFromCC];
    
    NSDictionary * dic = [CCData dicFromCC];

    
    
    
    NSDictionary * d = @{@"tiptime":dic[@"tiptime"],@"data":dic[@"data"],@"padingtime":time,@"restduration":duration,@"voiceturnoff":dic[@"voiceturnoff"]};
    

    [CCData changeRootValueWith:d];
    

    
}
+(void)writeDataWith:(NSMutableArray *)array{
    NSDictionary * dic = [CCData dicFromCC];
    
    NSDictionary * d = @{@"tiptime":dic[@"tiptime"],@"data":array,@"padingtime":dic[@"padingtime"],@"restduration":dic[@"restduration"],@"voiceturnoff":dic[@"voiceturnoff"]};
    
    
    [CCData changeRootValueWith:d];
    
    
   
}


+(CountModel *)countFromCCAtIndex:(NSInteger)index section:(NSInteger)section period:(NSInteger)period{
    return [CountModel countWithDic:[CCData dailyWorksFromCCAtIndex:index section:section][period]];
    
    
}
+(SubWorkModel*)subModelCCAtIndex:(NSInteger)index section:(NSInteger)section{
    
    NSDictionary * dic = [CCData subDicFromCCAtIndex:index section:section];
    SubWorkModel * subWork = [SubWorkModel subworkWithDic:dic];
        
    return subWork;
    
    
}


+(Workout*)workoutFromCCAtIndex:(NSInteger)index{
    NSDictionary * dic = [CCData dicFromCCAtIndex:index];
    Workout * workout = [Workout workWithDic:dic];
    return workout;
    
    
}

+(NSArray *)worksOfCCTracker{
    
    
   NSMutableArray * dataArray = [NSMutableArray array];
    NSArray * array = [CCData arrayFromCCtracker];
    for (NSDictionary * dic in array) {
        Workout * workout = [Workout workWithDic:dic];
        [dataArray addObject:workout];
        
    }

    return dataArray;
}

+(void)replaceElementWithWorkout:(Workout*)workout atIndex:(NSInteger)index{
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:[CCData arrayFromCCtracker]];
    NSDictionary * dic = [CCData dicFromWorkout:workout];
    
    [array replaceObjectAtIndex:index withObject:dic];
    [CCData writeDataWith:array];
    
    
    
    
}


+(Workout*)replaceWorkout:(Workout*)workout AtSection:(NSInteger)section withSubwork:(SubWorkModel*)sub{
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:workout.subwork];
    [array replaceObjectAtIndex:section withObject:sub];
    workout.subwork = array;
    return workout;
    
}



+(NSDictionary*)dicFromCountModel:(CountModel*)countModel{
    return @{@"time":countModel.time,@"section":countModel.section};
}

+(NSDictionary *)dicFromSubWork:(SubWorkModel*)subwork{
    NSMutableArray * norms = [NSMutableArray array];
    for (CountModel* c in subwork.norms) {
        NSDictionary * d = [CCData dicFromCountModel:c];
        [norms addObject:d];
    }
    return @{@"count":subwork.count,@"subname":subwork.subname,@"norms":norms};
    
    
    
}
+(NSDictionary*)dicFromWorkout:(Workout *)workout{
    NSMutableArray * subworks = [NSMutableArray array];
    for (SubWorkModel* sub in workout.subwork) {
        NSDictionary * d = [CCData dicFromSubWork:sub];
        [subworks addObject:d];
    }
    
    return @{@"icon":workout.icon,@"exp":workout.exp,@"level":workout.level,@"small_icon":workout.small_icon,@"large_icon":workout.large_icon,@"chname":workout.chname,@"subwork":subworks};
    
    
    
    
}


+(void)addExpWithWorkout:(Workout*)workout{
    NSInteger a = workout.exp.integerValue;
    a++;
    
    workout.exp = [NSString stringWithFormat:@"%ld",a];
    
}

+(void)addLevelWithWorkout:(Workout*)workout{
    
    NSInteger a = workout.level.integerValue;
    a++;
    
    workout.exp = @"0";
    workout.level = [NSString stringWithFormat:@"%ld",a];
    
    
}
+(void)addCountWith:(SubWorkModel *)subwork ofWorkout:(Workout*)workout atIndex:(NSInteger)section{
    subwork.count = [NSString stringWithFormat:@"%ld",subwork.count.integerValue+1];
    
    NSMutableArray * array = [NSMutableArray arrayWithArray:workout.subwork];
    [array replaceObjectAtIndex:section withObject:subwork];
   
    
    
    workout.subwork = array;
    
    
}


@end
