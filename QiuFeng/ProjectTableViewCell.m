//
//  ProjectTableViewCell.m
//  QiuFeng
//
//  Created by 邱峰 on 4/8/14.
//  Copyright (c) 2014 TongjiUniversity. All rights reserved.
//

#import "ProjectTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation ProjectTableViewCell

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

-(void) setCellWithProject:(Project *)project
{
    self.nameLabel.text=project.name;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:project.iconAddress] ];
}

@end
