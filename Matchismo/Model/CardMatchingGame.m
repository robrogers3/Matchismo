//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Robert Rogers on 2/3/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (nonatomic,readwrite) int score;
@property (strong,nonatomic) NSMutableArray *cards;
@property (nonatomic,readwrite,strong) NSString *lastPlay;
@property (nonatomic,strong) NSMutableArray *cardHistory;
@property (nonatomic) NSUInteger matchCount;
@end

@implementation CardMatchingGame

-(NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}
-(NSMutableArray *) cardHistory {
    if (!_cardHistory)
        _cardHistory = [[NSMutableArray alloc] init];
    return _cardHistory;
}
-(id)initWithCardCount:(NSUInteger) cardCount
             usingDeck:(Deck *) deck
{
    self = [super init];
    if (self) {
        for (int i = 0;i < cardCount;i++) {
            Card *card = [deck drawRandomCard];
            if (card)
                self.cards[i] = card;
            else {
                self = nil;
                break;
            }
        }
    }
    self.lastPlay = @"Your Play!";
    return self;
}
-(NSString *)stringFromCards: (Card *) card andMoreCards: (NSMutableArray *) ocards {
    NSMutableArray *a = [[NSMutableArray alloc] init];
    [a addObject: card.contents];
    for (Card *c in ocards)
        [a addObject:c.contents];
    NSString *s = [a componentsJoinedByString: @", "];
    return s;
}
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIPCOST 1;
-(int)checkMatches:(Card *)card matchMode: (NSUInteger) matchMode
{
    int matchScore = 0;
    self.lastPlay = [NSString stringWithFormat:@"Flipped: %@", card.contents];
    NSMutableArray *playableCards = [[NSMutableArray alloc] init];
    //accumlate
    for (Card *otherCard in self.cards) {
        if ([playableCards count] >= matchMode - 1) {
            NSLog(@"Breaking accuml for matchmode %d, cardcount: %d",matchMode, [playableCards count]);
            break;
        }
        if (otherCard.isFaceUp && !otherCard.isUnPlayable) {
            [playableCards addObject:otherCard];
        }
    }
    NSLog(@"%d, %d", [playableCards count], matchMode);
    //get score
    if ([playableCards count] == matchMode -1) {
        matchScore = [card match: playableCards];
        if (matchScore) {
            self.score += matchScore * MATCH_BONUS;
            card.unplayable = YES;
            for (Card *c in playableCards) {
                c.unplayable = YES;
                c.faceUp = YES;
            }
            self.lastPlay = [NSString stringWithFormat:@"Matched %@ for %d points", [self stringFromCards:card andMoreCards:playableCards], matchScore * MATCH_BONUS];
        } else {
            self.score -= MISMATCH_PENALTY;
            for (Card *c in playableCards) {
                c.unplayable = NO;
                c.faceUp = NO;
            }
            self.lastPlay = [NSString stringWithFormat:@"No Match for %@, %d point penalty",[self stringFromCards:card andMoreCards:playableCards], MISMATCH_PENALTY];
        }
    }
    return matchScore;
}
-(void)flipCardAtIndex:(NSUInteger)index forMatchingMode:(NSUInteger)matchMode
{
    Card *oldcard;
    Card *card = [self cardAtIndex:index];
    int matchScore;
    if (card && !card.isUnPlayable) {
        if (!card.isFaceUp)
        {
            self.lastPlay = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            matchScore = [self checkMatches:card matchMode: matchMode];
            if (!matchScore) {
                if (![self.cardHistory containsObject:card]) {
                    [self.cardHistory addObject: card];
                }
            }
            self.score -= FLIPCOST;

        } else {
            self.lastPlay = [NSString stringWithFormat:@"Flipped down %@", card.contents];
        }
        if (0 && [self.cardHistory count] > 2) {
            NSLog(@"cardhistory count %d", [self.cardHistory count]);
            oldcard = [self.cardHistory objectAtIndex:0];
            NSLog(@"oldcard %@ should go facedown", oldcard.contents);
            [self.cardHistory removeObjectAtIndex:0];
            if (!oldcard.isUnPlayable)
                oldcard.faceUp = NO;
        }
        card.faceUp = !card.isFaceUp;
        
    }
    else {
        self.lastPlay = @"Unplayable Card: Impossible?";
    }
}
-(Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
@end
