//
//  FirstCell.m
//  BI-IOS-TableView
//
//  Created by Dominik Vesely on 21/10/14.
//  Copyright (c) 2014 Ackee s.r.o. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)prepareForReuse
{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
