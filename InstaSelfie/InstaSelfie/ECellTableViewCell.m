//
//  ECellTableViewCell.m
//  InstaSelfie
//
//  Created by robint on 10/21/14.
//  Copyright (c) 2014 robint. All rights reserved.
//

#import "ECellTableViewCell.h"

@implementation ECellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
