//
//  CCData.h
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountModel.h"
#import "SubWorkModel.h"
#import "Workout.h"
@interface CCData : NSObject

+(NSArray*)tiptimeFromCC;


+(NSString*)voiceTurnOffFromCC;


+(void)changetipTimeWithArray:(NSArray*)array;
+(NSString *)paddingTimeFromCC;
+(NSString*)durationFromCC;
+(void)changeRecordTimeWith:(NSString*)duration andPadingTime:(NSString*)time andVoiceTurnOff:(NSString *)turnoff;
+(void)changeRestDurationWith:(NSString*)duration;
+(NSDictionary*)dicFromCC;
+(void)changePadingTimeWith:(NSString*)time;
+(NSArray *)arrayFromCCtracker;
+(NSDictionary *)dicFromCCAtIndex:(NSInteger)index;
+(NSArray*)subworkFromCCAtIndex:(NSInteger)index;
+(NSDictionary*)subDicFromCCAtIndex:(NSInteger)index section:(NSInteger)section;
+(NSArray *)dailyWorksFromCCAtIndex:(NSInteger)index section:(NSInteger)section;
+(NSDictionary*)trainNormFromCCAtIndex:(NSInteger)index section:(NSInteger)section period:(NSInteger)period;
+(void)writeDataWith:(NSArray *)array;

+(CountModel *)countFromCCAtIndex:(NSInteger)index section:(NSInteger)section period:(NSInteger)period;
+(SubWorkModel*)subModelCCAtIndex:(NSInteger)index section:(NSInteger)section;
+(Workout*)workoutFromCCAtIndex:(NSInteger)index;

+(NSArray *)worksOfCCTracker;


+(void)replaceElementWithWorkout:(Workout*)workout atIndex:(NSInteger)index;

+(NSDictionary*)dicFromCountModel:(CountModel*)countModel;

+(NSDictionary *)dicFromSubWork:(SubWorkModel*)subwork;
+(NSDictionary*)dicFromWorkout:(Workout *)workout;

+(void)addExpWithWorkout:(Workout*)workout;
+(void)addLevelWithWorkout:(Workout*)workout;

+(Workout*)replaceWorkout:(Workout*)workout AtSection:(NSInteger)section withSubwork:(SubWorkModel*)sub;


@end
