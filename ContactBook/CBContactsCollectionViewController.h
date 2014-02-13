//
//  CBContactsCollectionViewController.h
//  ContactBook
//
//  Created by Labs on 2/10/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBContactCell.h"
#import "CBAddContactViewController.h"
#import "CBDetailsViewController.h"

@interface CBContactsCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate, CBAddContactViewControllerDelegate>

@end
