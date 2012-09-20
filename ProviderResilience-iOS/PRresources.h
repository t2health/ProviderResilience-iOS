//
//  PRresources.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 6/28/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

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
