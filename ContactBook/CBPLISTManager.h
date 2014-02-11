//
//  CBPLISTManager.h
//  ContactBook
//
//  Created by Mohit Allianz on 11/02/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBPLISTManager : NSObject


+(BOOL)copyPLISTFileToDocuments;
+ (NSString*) getPlistPath;
+(NSMutableArray *)sortArray:(NSMutableArray *)array withKey:(NSString *)key ascending:(BOOL)ascending;
@end
