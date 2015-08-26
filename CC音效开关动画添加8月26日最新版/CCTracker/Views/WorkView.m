//
//  WorkView.m
//  CCTravker
//
//  Created by LWB on 15/8/15.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "WorkView.h"
#import "Workout.h"


@interface WorkView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end




@implementation WorkView

+(CGFloat)workViewHeight{
    
    
    return 90;
}

-(void)setWorkout:(Workout *)workout{
    
    self.nameLabel.text = workout.chname;
    self.iconView.image = [UIImage imageNamed:workout.icon];
  
}

+(instancetype)workViewWithReusingView:(UIView *)reusingView{
    if (reusingView == nil) {
        return [[[NSBundle mainBundle]loadNibNamed:@"WorkView" owner:nil options:nil]lastObject];
    }else{
        return (WorkView *)reusingView;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
