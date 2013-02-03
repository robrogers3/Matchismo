//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Robert Rogers on 2/2/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong,nonatomic) PlayingCardDeck *deck;
@end

@implementation CardGameViewController

-(PlayingCardDeck *)deck {
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

-(void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}
- (IBAction)flipCard:(UIButton *)sender {
    Card *card;
    
    if (!sender.selected) {
        card = (PlayingCard *)[self.deck drawRandomCard];
        if (card) {
            [sender setTitle: card.contents forState: UIControlStateSelected];
            NSLog(@"card %@", card.contents);
        } else {
            [sender setTitle: @"?" forState: UIControlStateSelected];
        }

    }

    sender.selected = !sender.selected;
    self.flipCount++;
}

@end
