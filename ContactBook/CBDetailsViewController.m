//
//  CBDetailsViewController.m
//  ContactBook
//
//  Created by Mohit Allianz on 13/02/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import "CBDetailsViewController.h"

@interface CBDetailsViewController ()


@end

@implementation CBDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.firstNameLabel.text = self.firstName;
    self.lastNameLabel.text = self.lastName;
    [self.telephoneButton setTitle:self.telephone forState:UIControlStateNormal];
    [self.emailButton setTitle:self.email forState:UIControlStateNormal];
    
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:[[CBPLISTManager getImagesFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.png", self.firstName, self.lastName]]];
    UIImage *image =  [UIImage imageWithData:imageData];
    
    if (image == nil) {
        imageData = [[NSData alloc] initWithContentsOfFile:[[CBPLISTManager getImagesFolderPath] stringByAppendingPathComponent:@"no_icon.png"]];
        image = [UIImage imageWithData:imageData];
    }
    self.imageView.image = image;
    
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2;
    self.imageView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.imageView.layer.borderWidth = 1.0f;
    self.imageView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
