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
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
- (IBAction)dismissScreen:(UIBarButtonItem *)sender;


@end

@implementation CBAddContactViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.imageView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.imageView.layer.borderWidth = 1.0f;
    self.imageView.layer.cornerRadius = 45.0f;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)dismissScreen:(UIBarButtonItem *)sender {
    
    if ([sender.title isEqualToString:@"Save"]) {
        [self saveContact];
    }
    
    else [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveContact {
    
    if ([self validateInput]) {
        //save
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(BOOL)validateInput {
    
    if ([self.firstNameTextField.text length] >= 5 && [self.lastNameTextField.text length] >= 5 && [self.telephoneTextField.text length] >= 5) {
        return YES;
    }
    
    else {
        if ([self.firstNameTextField.text length] < 5) {
            self.firstNameTextField.textColor = [UIColor redColor];
            
        }
        
        if ([self.lastNameTextField.text length] < 5) {
            self.lastNameTextField.textColor = [UIColor redColor];
            
        }
        
        if ([self.telephoneTextField.text length] < 5) {
            self.telephoneTextField.textColor = [UIColor redColor];
            
        }
        return NO;
    }
}
@end
