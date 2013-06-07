//
//  semesterHeader.m
//  PEM
//
//  Created by Sandra Zollner on 30.05.13.
//  Copyright (c) 2013 Sandra Zollner. All rights reserved.
//

#import "semesterHeader.h"

@implementation semesterHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
        self = [array objectAtIndex:0];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
