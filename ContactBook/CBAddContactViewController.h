//
//  CBAddContactViewController.h
//  ContactBook
//
//  Created by Labs on 2/11/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBAddContactViewControllerDelegate <NSObject>

@required
-(void)updatePLISTWithEntry:(NSDictionary *)newEntry;

@end

@interface CBAddContactViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) id  <CBAddContactViewControllerDelegate> delegate;

@end
