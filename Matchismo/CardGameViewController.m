//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Robert Rogers on 2/2/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"


@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong,nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation CardGameViewController

-(Deck *)deck {
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}
-(void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    for (UIButton *cardButton in cardButtons) {
        Card *card = [self.deck drawRandomCard];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
    }
}
-(void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}
- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.flipCount++;
}

@end
