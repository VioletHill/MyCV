//
//  ExperienceCell.h
//  QiuFeng
//
//  Created by 邱峰 on 4/9/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Experience.h"

@interface ExperienceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subtitle;

-(void) setCellWithTitle:(NSString*)title andSubtitle:(NSString*)subTitle;

-(void) setCellWithExperience:(Experience*)ex;

@end
