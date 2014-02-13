//
//  CBDetailsViewController.h
//  ContactBook
//
//  Created by Mohit Allianz on 13/02/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *telephoneButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *telephone;
@property (strong, nonatomic) NSString *email;
@end
