//
//  CBPLISTManager.h
//  ContactBook
//
//  Created by Mohit Allianz on 11/02/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBPLISTManager : NSObject

/**
 *  Copies the PLIST file from the app bundle to the Documents directory
 *
 *  @return Success or failure
 */
+(BOOL)copyPLISTFileToDocuments;

/**
 *  Returns the path to the PLIST file in the documents directory
 *
 *  @return the path as a string
 */
+ (NSString*) getPlistPath;

/**
 *  Sorts an array according to the key and returns it
 *
 *  @param array     An unsorted array
 *  @param key       key to apply the sort on
 *  @param ascending YES or NO
 *
 *  @return A mutable sorted array
 */
+(NSMutableArray *)sortArray:(NSMutableArray *)array withKey:(NSString *)key ascending:(BOOL)ascending;

/**
 *  Updates the PLIST file in Documents folder with a new entry
 *
 *  @param newEntry The dictionary to be added to the PLIST
 */
+(void)updatePLISTWithEntry:(NSDictionary *)newEntry;

/**
 *  Update the PLIST in Documents with a new sorted Array
 *
 *  @param sortedArray Sorted array to be entered into the PLIST
 */
+(void)updatePLISTWithSortedArray:(NSMutableArray *)sortedArray;

/**
 *  Creates the "Images" folder in Documents
 */
+(void)createImagesFolder;

/**
 *  Returns the path of the Images folder in Documents
 *
 *  @return path of the Images folder as string.
 */
+(NSString *)getImagesFolderPath;
@end
