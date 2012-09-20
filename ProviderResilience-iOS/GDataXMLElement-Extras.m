//
//  GDataXMLElement-Extras.m
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/17/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import "GDataXMLElement-Extras.h"

@implementation GDataXMLElement(Extras)

- (GDataXMLElement *)elementForChild:(NSString *)childName {
    NSArray *children = [self elementsForName:childName];            
    if (children.count > 0) {
        GDataXMLElement *childElement = (GDataXMLElement *) [children objectAtIndex:0];
        return childElement;
    } else return nil;
}

- (NSString *)valueForChild:(NSString *)childName {    
    return [[self elementForChild:childName] stringValue];    
}

@end
