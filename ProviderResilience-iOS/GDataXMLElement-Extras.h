//
//  GDataXMLElement-Extras.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/17/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface GDataXMLElement (Extras)

- (GDataXMLElement *)elementForChild:(NSString *)childName;
- (NSString *)valueForChild:(NSString *)childName;

@end
