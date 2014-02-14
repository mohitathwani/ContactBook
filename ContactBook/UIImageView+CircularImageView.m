//
//  UIImageView+CircularImageView.m
//  ContactBook
//
//  Created by Mohit Allianz on 14/02/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import "UIImageView+CircularImageView.h"

@implementation UIImageView (CircularImageView)

-(void) makeCircular {
    
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    self.layer.borderWidth = 1.0f;
    self.layer.masksToBounds = YES;
}
@end
