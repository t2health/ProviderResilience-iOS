//
//  PRresources.m
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 6/28/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import "PRresources.h"

@implementation PRresources
@synthesize chosenString;
NSString *fileName2;

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    fileName2 = [[[NSString alloc] initWithString:kFilenamePR] autorelease];
    fileName2  = [fileName2 stringByAppendingString:@".plist"];
    return [documentsDirectory stringByAppendingPathComponent:fileName2];
}

- (NSString *)QOLstringForKey:(NSString *)key {  
    // Here's where the return string will go
    NSString *myString;
    
    
    // Read our data from the plist
    NSString *filePath = [self dataFilePath];
    
    // We first try to find it in our App directory (the updated version)
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // Doesn't exist in our App directory...use the original one in the bundle
        filePath = [[NSBundle mainBundle] pathForResource:kFilenamePR ofType:@"plist"];
    }
    
    // Make sure we have a file     
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        // Create a dictionary where we will load the data from the plist
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:filePath];
        
        // Read it in
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
        
        // Only continue if we read the plist
        if (temp) {
            // OK...let's process what we got
            myString = [temp objectForKey:key];       
                      
        }
        
    } 
    
    return myString; 
}



@end
