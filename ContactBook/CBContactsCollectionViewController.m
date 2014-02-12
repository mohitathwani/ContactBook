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
@end

@implementation CBContactsCollectionViewController

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
    [self loadData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadCollectionView:)
                                                 name:@"newEntryAdded" object:nil];
    
}

- (void) loadData {
    self.contactsArray = [NSMutableArray arrayWithContentsOfFile:[CBPLISTManager getPlistPath]];
    
    self.sortedContactsArray = [CBPLISTManager sortArray:self.contactsArray withKey:@"firstName" ascending:YES];
}
- (void)reloadCollectionView:(NSNotification *)notification {
    [self loadData];
    [self.collectionView reloadData];
    [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if (self.sortedContactsArray[indexPath.row][@"image"] != nil) {
        NSData *imageData = [[NSData alloc] initWithContentsOfFile:[[CBPLISTManager getImagesFolderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.png", self.sortedContactsArray[indexPath.row][@"firstName"], self.sortedContactsArray[indexPath.row][@"lastName"]]]];
        UIImage *image =  [UIImage imageWithData:imageData];
        cell.imageView.image = image;
    }
    
    else {
        NSData *imageData = [[NSData alloc] initWithContentsOfFile:[[CBPLISTManager getImagesFolderPath] stringByAppendingPathComponent:@"no_icon.png"]];
        UIImage *image =  [UIImage imageWithData:imageData];
        cell.imageView.image = image;
    }
    

    return cell;
}

/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/
@end
