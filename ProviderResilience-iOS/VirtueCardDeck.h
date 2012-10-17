//
//  VirtueCardDeck.h
//  
//  05/15/2012 Bit of a kludge but didn't see that we had more uses for this Class
//              Adjusting it to handle 'Exercises' also...but will call the Exercises 'Virtues'
//
//  Created by Brian Doherty on 05/14/2012.
//  Copyright 2012 T2. All rights reserved.
//
/*
 *
 * Provider Resilience
 *
 * Copyright © 2009-2012 United States Government as represented by
 * the Chief Information Officer of the National Center for Telehealth
 * and Technology. All Rights Reserved.
 *
 * Copyright © 2009-2012 Contributors. All Rights Reserved.
 *
 * THIS OPEN SOURCE AGREEMENT ("AGREEMENT") DEFINES THE RIGHTS OF USE,
 * REPRODUCTION, DISTRIBUTION, MODIFICATION AND REDISTRIBUTION OF CERTAIN
 * COMPUTER SOFTWARE ORIGINALLY RELEASED BY THE UNITED STATES GOVERNMENT
 * AS REPRESENTED BY THE GOVERNMENT AGENCY LISTED BELOW ("GOVERNMENT AGENCY").
 * THE UNITED STATES GOVERNMENT, AS REPRESENTED BY GOVERNMENT AGENCY, IS AN
 * INTENDED THIRD-PARTY BENEFICIARY OF ALL SUBSEQUENT DISTRIBUTIONS OR
 * REDISTRIBUTIONS OF THE SUBJECT SOFTWARE. ANYONE WHO USES, REPRODUCES,
 * DISTRIBUTES, MODIFIES OR REDISTRIBUTES THE SUBJECT SOFTWARE, AS DEFINED
 * HEREIN, OR ANY PART THEREOF, IS, BY THAT ACTION, ACCEPTING IN FULL THE
 * RESPONSIBILITIES AND OBLIGATIONS CONTAINED IN THIS AGREEMENT.
 *
 * Government Agency: The National Center for Telehealth and Technology
 * Government Agency Original Software Designation: Provider Resilience001
 * Government Agency Original Software Title: Provider Resilience
 * User Registration Requested. Please send email
 * with your contact information to: robert.kayl2@us.army.mil
 * Government Agency Point of Contact for Original Software: robert.kayl2@us.army.mil
 *
 */
#import <Foundation/Foundation.h>

// Keys to the data in the plist
// Keys of the plist variables
#define kCurrentVirtue @"CurrentVirtue"   // Current Virtue being used (0-index)
#define kVirtueArray @"VirtueArray"       // Array containing the Virtues

// Keys of the Virtue Array
#define kVirtueNameKey @"VirtueName"        // Key Name for a Virtue
#define kFrontKey @"Front"                  // Key Name for boolean: Front==TRUE (show front of card)
                                            // Front==FALSE (show reverse side of card)

@interface VirtueCardDeck : NSObject {
    // The filename of the plist containing the data
    NSString *pListFileName;
    
    // This is where the contents of the plist goes
    NSString *VirtueFileName;
    NSNumber *CurrentVirtue;
    NSMutableArray *Virtues; 
    
    
}

@property (copy, nonatomic) NSString *pListFileName;
@property (copy, nonatomic) NSString *VirtueFileName;
@property (copy, nonatomic) NSNumber *CurrentVirtue;
@property (nonatomic, retain) NSMutableArray *Virtues;


- (NSString *)dataFilePath;         // Path to the Virtue plist (in the user's document folder)
- (void)initPlist;                  // Initialization for this object
- (void)writeToPlist;               // Write out the current plist

// Retrieve the Virtue Info
- (NSString *)virtueNameForIndex :(NSInteger)index;     // Virtue name of this card, e.g.: charity, love...
- (NSString *)fileForVirtue :(NSInteger)index;          // File name:  card_charity_reverse.jpg
- (NSString *)fileForStretch :(NSInteger)index;          // File name:  stretch_one.png

// Toggle the Front attribute (YES<--->No)...of the current Virtue Card
- (BOOL)bToggleFront:(BOOL)bSaveIt;

// These methods let us know if there is a Prev/Next virtue
// Let's us know if we should 'wrap' around the beginning and/or the end
- (BOOL)bPrevVirtue;
- (BOOL)bNextVirtue;

// And these methods get us the new virtue # (and increment/decrement/set the CurrentVirtue)
- (NSInteger)getPrevVirtue;
- (NSInteger)getNextVirtue;
- (NSInteger)getRandomVirtue;
- (NSInteger)changeCurrentVirtue :(NSInteger)newVirtueIndex;



@end
