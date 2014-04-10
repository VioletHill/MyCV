//
//  ExperienceCell.m
//  QiuFeng
//
//  Created by 邱峰 on 4/9/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "ExperienceCell.h"

@interface ExperienceCell ()

@end


@implementation ExperienceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCellWithTitle:(NSString *)title andSubtitle:(NSString *)subTitle
{
    self.titleLabel.text=title;
    self.subtitle.text=subTitle;
}

-(void) setCellWithExperience:(Experience *)ex
{
    [self setCellWithTitle:[NSString stringWithFormat:@"%d",ex.year] andSubtitle:ex.event];
}

@end
