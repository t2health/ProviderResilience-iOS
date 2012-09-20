//
//  VirtueCardDeck.m
//  
//  Utilize a plist to provide structure, control and tracking of a Virtues
//  These are .jpg files that describe a virtue
//
//  The plist has the following format (subject to revision!):
//      Key                 Value
//      =========           =========================
//      CurrentVirtue      The # of the Virtue the user was last reading
//      Virtues            <array> of entries for each virtue in the array
//          VirtueName      Name of this virtue
//          Front           Boolean (T: Front F: Reverse) of virtue card
//          VirtueFileName  File containing content for this virtue
//
//  Created by Brian Doherty on 05/14/2012.
//  Copyright 2012 T2 All rights reserved.
//

#import "VirtueCardDeck.h"
#import "Analytics.h"


@implementation VirtueCardDeck

@synthesize pListFileName;
@synthesize CurrentVirtue;
@synthesize Virtues;
@synthesize VirtueFileName;


// Construct the path to the plist file (in the documents folder)
- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [[[NSString alloc] initWithString:pListFileName] autorelease];
    fileName  = [fileName stringByAppendingString:@".xml"];
    return [documentsDirectory stringByAppendingPathComponent:fileName]; 
}

// Initialize this object
- (void)initPlist{
    [Analytics logEvent:@"VIRTUE CARD"];
    
    // Read our data from the plist
    NSString *filePath = [self dataFilePath];
    
    // We first try to find it in our App directory (the updated version)
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // Doesn't exist in our App directory...use the original one in the bundle
        filePath = [[NSBundle mainBundle] pathForResource:pListFileName ofType:@"xml"];
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
            
            // Find out what virtue was being read 
            self.CurrentVirtue = [temp objectForKey:kCurrentVirtue];   
                        
            // Get a copy of all of the virtues
            Virtues = [NSMutableArray arrayWithArray:[temp objectForKey:kVirtueArray ]]; 
            [self.Virtues retain];

        }
    }
    
}


// Retrieve the Virtue Info
- (NSString *)virtueNameForIndex :(NSInteger)index {             // Virtue Name
    NSDictionary *myElement = [Virtues objectAtIndex:index];
    return [myElement objectForKey:kVirtueNameKey];
}

- (NSString *)fileForVirtue :(NSInteger)index{                 // File for the Virtue
    NSDictionary *myElement = [Virtues objectAtIndex:index];
    
    // And look at the Front flag to determine if we show the Front or the Reverse 
    NSNumber *t = [myElement objectForKey:kFrontKey]; 
    BOOL bFront = NO;          
    if ([t intValue] == 1)
        bFront = YES;
    
    // Build the fully qualified file name
    // eg; card_acceptance_front.jpg   // 08/21/12 Leave off the extension
    NSString* buf=[[[NSString alloc] initWithFormat:@"card_%@_%@", [myElement objectForKey:kVirtueNameKey],
                                                                                    (bFront?@"front":@"reverse")] autorelease];
    
    return buf;
    
}

- (NSString *)fileForStretch :(NSInteger)index{                 // File for the Stretch Cards
    NSDictionary *myElement = [Virtues objectAtIndex:index];
        
    // Build the fully qualified file name
    // eg; card_acceptance_front.jpg
    NSString* buf=[[[NSString alloc] initWithFormat:@"%@", [myElement objectForKey:kVirtueNameKey]] autorelease];
    
    return buf;
    
}


// These methods let us know if there is a Prev/Next virtue
// We can then know whether we need to wrap around the beginning or end
- (BOOL)bPrevVirtue{
    if ([CurrentVirtue intValue]>0)
        return YES;
    else
        return NO;
}
- (BOOL)bNextVirtue{
    int nCount = [Virtues count];
    if ( (nCount-1) > [CurrentVirtue intValue])
        return YES;
    else
        return NO;
}


// And these methods get us the new virtue # (and increment/decrement/set the CurrentVirtue)
- (NSInteger)getPrevVirtue{
    
    // We will be changing this...but save the current value
    NSInteger curVal = [CurrentVirtue intValue];
    [CurrentVirtue release];
    CurrentVirtue = nil;
    
    // Make sure we have a previous virtue before we go load it
    if (curVal>0) 
    {
        // First decrement the CurrentVirtue
        NSInteger newInt = curVal - 1;
        CurrentVirtue = [[NSNumber alloc] initWithInteger:newInt];
    } else {
        // We are at the beginning...wrap around to the end
        NSInteger oldInt = [Virtues count]-1;
        CurrentVirtue = [[NSNumber alloc] initWithInteger:oldInt];
    }
    
    // Save our changes
    [self writeToPlist];
    
    // Now return it
    return [CurrentVirtue intValue];
}
- (NSInteger)getNextVirtue{
    // We will be changing this...but save the current value
    NSInteger curVal = [CurrentVirtue intValue];
    int nCount = [Virtues count];
    [CurrentVirtue release];
    CurrentVirtue = nil;
    
    // Make sure we have a next virtue before we go load it
    if (curVal < (nCount-1)) 
    {
        // First increment the CurrentVirtue
        NSInteger newInt = curVal + 1;
        CurrentVirtue = [[NSNumber alloc] initWithInteger:newInt];
    } else {
        // We are at the end...wrap around to the beginning
        CurrentVirtue = [[NSNumber alloc] initWithInteger:0];   // Beginning == 0
    }
    
    // Save our changes
    [self writeToPlist];
    
    // Now return it
    return [CurrentVirtue intValue];
}

- (NSInteger)getRandomVirtue{
    // We will be changing the current card...but we won't save our new value
    // This is a temporary selection only for startup
    int nCount = [Virtues count];
    [CurrentVirtue release];
    CurrentVirtue = nil;
    
    // Get a random card
    NSInteger newInt = arc4random() % nCount;
    CurrentVirtue = [[NSNumber alloc] initWithInteger:newInt];
    
    // Note: We are not saving this new value!
    
    // Now return it
    return [CurrentVirtue intValue];
}


- (NSInteger)changeCurrentVirtue :(NSInteger)newVirtueIndex{
    // Set the new Current Virtue
    [CurrentVirtue release];
    CurrentVirtue = nil;
    CurrentVirtue = [[NSNumber alloc] initWithInteger:newVirtueIndex];
    
    // Save our changes
    [self writeToPlist];
    
    return newVirtueIndex;         // Just return what they sent us!
}


// Toggle the Front attribute (YES<--->No)...of the current Virtue Card
- (BOOL)bToggleFront:(BOOL)bSaveIt  {
    NSDictionary *myElement = [Virtues objectAtIndex:[[self CurrentVirtue] intValue]];
    
    // Look at the Front flag and toggle it 
    NSNumber *t = [myElement objectForKey:kFrontKey]; 
    BOOL bFront = YES;          // Assume the NEW 'toggled' value will be YES
    if ([t intValue] == 1)      // But, if the Current Value is YES, then the new Value will be NO
        bFront = NO;
    
    // Update this array element with the new value
    // Note:  These get Semanitic warnings but it works (and I can't figure out how to tell the compiler it is ok!)
    if (bFront)
        [myElement setObject:(id)kCFBooleanTrue forKey:kFrontKey]; 
    else
        [myElement setObject:(id)kCFBooleanFalse forKey:kFrontKey];
    
    // Write back the updated value
    if (bSaveIt) {
        [self writeToPlist];
    }
    
    // Return the new value
    return bFront;
}


- (void)writeToPlist
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    // Set the values for Front (for current virtue) and CurrentVirtue
    [data setObject:CurrentVirtue forKey:kCurrentVirtue];
    
    [data setObject:Virtues  forKey:kVirtueArray];   // Kinda overkill...write everything in the virtue array
        
    [data writeToFile:[self dataFilePath] atomically:YES];
    [data release];    
}

- (void)dealloc {;
    [pListFileName release];
    [Virtues release];
    [CurrentVirtue release];
    [super dealloc];
}
@end
