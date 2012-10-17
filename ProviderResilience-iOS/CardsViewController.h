//
//  CardsViewController.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
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
#import <UIKit/UIKit.h>
#import "VirtueCardDeck.h"

@interface CardsViewController : UIViewController {
    IBOutlet UIImageView *viewVirtueCard;
    IBOutlet UILabel *labelTitle;
    IBOutlet UILabel *labelCopyright;
    IBOutlet UIButton *buttonProceed;
    IBOutlet UILabel *labelSwipeHorz;
    
    BOOL bStartupMode;
    
    // Definition of the Virtual Card Deck
    VirtueCardDeck  *virtueCards;
}

@property (copy, nonatomic) VirtueCardDeck *virtueCards;
@property (retain, nonatomic) UIImageView *viewVirtueCard;
@property (retain, nonatomic) UILabel *labelTitle;
@property (retain, nonatomic) UILabel *labelCopyright;
@property (retain, nonatomic) UIButton *buttonProceed;
@property (retain, nonatomic) UILabel *labelSwipeHorz;

- (IBAction)buttonProceed_Clicked:(id)sender;
- (void)StartupMode;


@end
