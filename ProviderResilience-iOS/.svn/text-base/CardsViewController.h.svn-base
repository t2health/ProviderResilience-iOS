//
//  CardsViewController.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

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
