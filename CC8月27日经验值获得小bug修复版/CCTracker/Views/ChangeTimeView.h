//
//  ChangeTimeView.h
//  CCTravker
//
//  Created by LWB on 15/8/16.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeTimeView : UIView
@property(nonatomic,copy)void(^myBlock)(UIAlertController*);
@property(nonatomic,copy)void(^myBlock1)(UIAlertView*);
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
- (IBAction)closeView:(UIButton *)sender;
@end
