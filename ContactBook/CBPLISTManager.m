//
//  CBPLISTManager.m
//  ContactBook
//
//  Created by Mohit Allianz on 11/02/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import "CBPLISTManager.h"

@implementation CBPLISTManager



+ (NSString*) getPlistPath:(NSString*) filename{
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:filename];
}


+(BOOL)copyPLISTFileToDocuments {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *contactsPathInDocuments = [CBPLISTManager getPlistPath:@"Contacts.plist"];
    
    BOOL copyResult = NO;
    
    if (![fileManager fileExistsAtPath:contactsPathInDocuments]) {
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
        
        copyResult = [fileManager copyItemAtPath:defaultPath toPath:contactsPathInDocuments error:&error];
    }
    
    return copyResult;
    
}
@end
