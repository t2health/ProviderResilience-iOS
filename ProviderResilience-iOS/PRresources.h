//
//  PRresources.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 6/28/12.
//  Copyright (c) 2012 T2. All rights reserved.
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
#import "UIKit/UIKit.h"

// This is a plist (the type extension is appended in the code)
#define kFilenamePR       @"PR-Resources"

#define kQOLLowCompassion @"QOL-Low-Compassion" 
#define kQOLMedCompassion @"QOL-Med-Compassion" 
#define kQOLHighCompassion @"QOL-High-Compassion" 

#define kQOLLowBurnout @"QOL-Low-Burnout" 
#define kQOLMedBurnout @"QOL-Med-Burnout" 
#define kQOLHighBurnout @"QOL-High-Burnout"

#define kQOLLowTrauma @"QOL-Low-Trauma" 
#define kQOLMedTrauma @"QOL-Med-Trauma" 
#define kQOLHighTrauma @"QOL-High-Trauma"

#define kQOLPreviewCompassion @"QOL-Preview-Compassion" 
#define kQOLPreviewBurnout @"QOL-Preview-Burnout" 
#define kQOLPreviewTrauma @"QOL-Preview-Trauma"

@interface PRresources : NSObject {
    NSString *chosenString;         // Return one string at a time...whatever they ask for!
}

@property (copy, nonatomic) NSString *chosenString;

- (NSString *)dataFilePath;     // Path to the plist (in the user's document folder)

- (NSString *)QOLstringForKey:(NSString *)key;

@end
