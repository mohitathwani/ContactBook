//
//  CBContactCell.h
//  ContactBook
//
//  Created by Mohit Allianz on 11/02/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBContactCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
