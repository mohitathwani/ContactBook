//
//  CBPLISTManager.m
//  ContactBook
//
//  Created by Mohit Allianz on 11/02/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import "CBPLISTManager.h"

@implementation CBPLISTManager

+(BOOL)copyPLISTFileToDocuments {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *contactsPathInDocuments = [CBPLISTManager getPlistPath];
    
    BOOL copyResult = NO;
    
    if (![fileManager fileExistsAtPath:contactsPathInDocuments]) {
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
        
        copyResult = [fileManager copyItemAtPath:defaultPath toPath:contactsPathInDocuments error:&error];
    }
    
    return copyResult;
    
}

+ (NSString*) getPlistPath{
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"Contacts.plist"];
}

+(NSMutableArray *)sortArray:(NSMutableArray *)array withKey:(NSString *)key ascending:(BOOL)ascending {
    NSMutableArray *sortedArray;
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending selector:@selector(caseInsensitiveCompare:)];
                                    
    sortedArray = [[array sortedArrayUsingDescriptors:@[descriptor]] mutableCopy];
    
    [CBPLISTManager updatePLISTWithSortedArray:sortedArray];
                                    
    return sortedArray;
    
}

+(void)updatePLISTWithSortedArray:(NSMutableArray *)sortedArray {
    
    
    [sortedArray writeToFile:[CBPLISTManager getPlistPath] atomically:YES];
}

+(void)updatePLISTWithEntry:(NSDictionary *)newEntry {
    NSMutableArray *contactsArray = [CBPLISTManager contactsArrayFromPLIST];
    [contactsArray addObject:newEntry];
    [CBPLISTManager updatePLISTWithSortedArray:contactsArray];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newEntryAdded" object:nil];
    
}

/**
 *  Gets the latest contacts from the PLIST
 *
 *  @return returns the latest array from the PLIST file
 */
+(NSMutableArray *)contactsArrayFromPLIST {
    NSMutableArray *contactsArray = [NSMutableArray arrayWithContentsOfFile:[CBPLISTManager getPlistPath]];
    
    return contactsArray;
}

+(void)createImagesFolder {
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[CBPLISTManager getImagesFolderPath]]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:[CBPLISTManager getImagesFolderPath] withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
        
        NSString *defaultImagePath = [[CBPLISTManager getImagesFolderPath] stringByAppendingPathComponent:@"no_icon.png"];
        
        NSData *imageDataToStore = UIImagePNGRepresentation([UIImage imageNamed:@"no_icon.png"]);
        [imageDataToStore writeToFile:defaultImagePath atomically:YES];
    
    
}
    
}

+(NSString *)getImagesFolderPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/Images"];
    
    return dataPath;
}
@end
