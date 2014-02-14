//
//  CBContactsCollectionViewController.m
//  ContactBook
//
//  Created by Labs on 2/10/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import "CBContactsCollectionViewController.h"

@interface CBContactsCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *contactsArray;
@property (strong, nonatomic) NSMutableArray *sortedContactsArray;

//Need access to the popovercontroller in iPad so that it can be dismissed by the buttons.
@property (weak, nonatomic) UIPopoverController *popOverController;
@end

@implementation CBContactsCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadData];
    
    //Start listening to new entry added notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadCollectionView:)
                                                 name:@"newEntryAdded" object:nil];
    
    //Setting up longpress gesture to delete entries
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(activateDeletionMode:)];
    [self.collectionView addGestureRecognizer:longPress];
    
}

/**
 *  Loads the data from the PLIST file
 */
- (void) loadData {
    self.contactsArray = [NSMutableArray arrayWithContentsOfFile:[CBPLISTManager getPlistPath]];
    
    self.sortedContactsArray = [CBPLISTManager sortArray:self.contactsArray withKey:@"firstName" ascending:YES];
}

/**
 *  This method is responsible for deleting the entry on which long press occured
 *
 *  @param gestureRecognizer long press gesture
 */
- (void) activateDeletionMode:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    // Get the index path of the cell on which long press occured
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gestureRecognizer locationInView:self.collectionView]];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        //Have to check for UIGestureRecognizerStateBegan to prevent multiple entries from being deleted.
        [self.sortedContactsArray removeObjectAtIndex:indexPath.row];
        [self.collectionView reloadData];
        [CBPLISTManager updatePLISTWithSortedArray:self.sortedContactsArray];
    }
    
}


- (void)reloadCollectionView:(NSNotification *)notification {
    [self loadData];
    [self.collectionView reloadData];
//    [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.sortedContactsArray count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CBContactCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"contactCell" forIndexPath:indexPath];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@\n%@", self.sortedContactsArray[indexPath.row][@"firstName"], self.sortedContactsArray[indexPath.row][@"lastName"]];
    
    
    [cell.imageView makeCircular];
    
    NSData *imageData;
    UIImage *contactImage;
    
    if (self.sortedContactsArray[indexPath.row][@"image"] != nil) {
        imageData = [[NSData alloc] initWithContentsOfFile:[[CBPLISTManager getImagesFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.png", self.sortedContactsArray[indexPath.row][@"firstName"], self.sortedContactsArray[indexPath.row][@"lastName"]]]];
        contactImage =  [UIImage imageWithData:imageData];
    }
    
    else {
        imageData = [[NSData alloc] initWithContentsOfFile:[[CBPLISTManager getImagesFolderPath] stringByAppendingPathComponent:@"no_icon.png"]];
        contactImage =  [UIImage imageWithData:imageData];
    }
    
    cell.imageView.image = contactImage;

    return cell;
}

/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"addContactPopOver"]) {
        if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
            self.popOverController = [(UIStoryboardPopoverSegue*)segue popoverController];
            [segue.destinationViewController setDelegate:self];
        }
    }
    
    else if ([segue.identifier isEqualToString:@"showDetailsPhone"] || [segue.identifier isEqualToString:@"showDetailsPad"]) {
        CBDetailsViewController *dVC = (CBDetailsViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        
        dVC.firstName = self.sortedContactsArray[indexPath.row][@"firstName"];
        dVC.lastName = self.sortedContactsArray[indexPath.row][@"lastName"];
        dVC.telephone = self.sortedContactsArray[indexPath.row][@"telephone"];
        dVC.email = self.sortedContactsArray[indexPath.row][@"email"];
    }
}

/**
 *  Delegate call back from the popover VC to hide the pop over
 */
-(void)hidePopOver {
    [self.popOverController dismissPopoverAnimated:YES];
}
@end
