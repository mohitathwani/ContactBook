//
//  CBAddContactViewController.m
//  ContactBook
//
//  Created by Labs on 2/11/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import "CBAddContactViewController.h"

@interface CBAddContactViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CBAddContactViewController

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
    
    self.imageView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.imageView.layer.borderWidth = 1.0f;
    self.imageView.layer.cornerRadius = 45.0f;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
