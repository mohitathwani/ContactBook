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
    
    [self.imageView makeCircular];
    
    if ([self.email isEqualToString:@""]) {
        self.emailButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) showEmailModalView {
    
    MFMailComposeViewController *mailComposeVC = [[MFMailComposeViewController alloc] init];
    mailComposeVC.mailComposeDelegate = self;
    
    [mailComposeVC setSubject:[NSString stringWithFormat:@"Hello %@ %@", self.firstName, self.lastName]];
    
    
    [mailComposeVC setToRecipients:@[self.email]];
    
    NSString *emailBody =
    [NSString stringWithFormat:@"<b>Hello World !</b>"];
    
    [mailComposeVC setMessageBody:emailBody isHTML:YES];
    
    [self presentViewController:mailComposeVC animated:YES completion:nil];
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:+11111"]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.telephone]]];
            
        }
    }
    
    else {
        MFMessageComposeViewController *messageComposeVC = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            messageComposeVC.body = @"Hello World !";
            messageComposeVC.recipients = [NSArray arrayWithObjects:self.telephone, @"87654321", nil];
            messageComposeVC.messageComposeDelegate = self;
            [self presentViewController:messageComposeVC animated:YES completion:nil];
        }
    }
}
- (IBAction)telephoneButtonClicked:(UIButton *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose an option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call", @"Message", nil];
    
    [actionSheet showInView:self.view];
}
- (IBAction)emailButtonClicked:(UIButton *)sender {
    [self showEmailModalView];
}
- (IBAction)swipeGesture:(UISwipeGestureRecognizer *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
