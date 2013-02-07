//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Robert Rogers on 2/3/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

#define TWO_CARDS_MATCHING_GAME     2 // segmented control index for 2-cards matching game - 2
#define THREE_CARDS_MATCHING_GAME   3 // segmented control index for 3-cards matching game -2

@interface CardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger) cardCount usingDeck:(Deck *) deck; // andMatchCount: (NSUInteger) count;
-(void)flipCardAtIndex:(NSUInteger) index forMatchingMode:(NSUInteger) mode;
-(Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic,readonly) int score;
@property (nonatomic,readonly,strong) NSString *lastPlay;

@end
