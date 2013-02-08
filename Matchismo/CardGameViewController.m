//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Robert Rogers on 2/2/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchControl;
@property (nonatomic) NSUInteger matchMode;
@end

@implementation CardGameViewController
-(CardMatchingGame *) game {
    if (!_game)
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck: [[PlayingCardDeck alloc] init]];
    return _game;
}
-(void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    NSLog(@"setCardButtons Called");
    [self updateUI];
}
-(void) updateUI {
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    if (self.flipCount)
        self.matchControl.enabled = NO;
   
    UIEdgeInsets insets = UIEdgeInsetsMake(6,6,6,6);
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setImage: card.isFaceUp ? nil : cardBackImage  forState:UIControlStateNormal];
        [cardButton setImageEdgeInsets:insets];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected];
        [cardButton setTitle:card.contents
                    forState:UIControlStateDisabled|UIControlStateSelected];//maps model to UI
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.statusLabel.text = self.game.lastPlay;
}
-(void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}
- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender] forMatchingMode:self.matchMode];
    self.flipCount++;
    [self updateUI];
}
- (IBAction)deal {
    self.flipCount = 0;
    self.flipsLabel.text = @"Flips: 0";
    self.scoreLabel.text = @"Score: 0";
    self.statusLabel.text = @"New Deal";
    self.game = nil;
    self.matchControl.selectedSegmentIndex = self.matchMode - 2;
    self.matchControl.enabled = YES;
    [self updateUI];
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.statusLabel.text = @"Your Play!";
    self.matchMode = TWO_CARDS_MATCHING_GAME;
}
- (IBAction)changeMatchMode:(UISegmentedControl *)sender {
    NSUInteger m = sender.selectedSegmentIndex;
    self.matchMode = sender.selectedSegmentIndex + 2;
    NSLog(@"toggle controler %d, matchmode %d", m, self.matchMode);
}
@end
