//
//  HisCell.m
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "HisCell.h"

@interface HisCell ()

@property (weak, nonatomic) IBOutlet UIProgressView *proline;

@property (weak, nonatomic) IBOutlet UILabel *levelLabel;




@end





@implementation HisCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setWorkout:(Workout *)workout{
    
    _workout = workout;
    self.proline.progress = workout.exp.floatValue/100;
    self.levelLabel.text = [NSString stringWithFormat:@"%@级%@%%",workout.level,workout.exp];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
