//
//  PlayingCard.m
//  Matchismo
//
//  Created by Robert Rogers on 2/2/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//
#import "PlayingCard.h"
@implementation PlayingCard
-(int) match:(NSArray*) otherCards
{
    int score = 0;
    for(PlayingCard* card in otherCards)
    {
        if (self.rank == card.rank)
            score += 4;
        if ([self.suit isEqualToString:card.suit])
            score += 1;
    }
    if([otherCards count]>1)
    {
        NSRange range;
        range.location=1;
        range.length = [otherCards count]-1;
        score+= [otherCards[0] match:[otherCards subarrayWithRange:range]];
    }
    return score;
}
-(int)matchX:(NSArray *)otherCards //not used.
{
    int score = 0;
    if (otherCards.count == 1)
    {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *) otherCard; 
            if ([otherPlayingCard.suit isEqualToString:self.suit]) score = 1;
            else if (otherPlayingCard.rank == self.rank) score = 4;
        }
    }
    else
    {
        for (Card *scoreCard in otherCards)
        {
            int cardScore = [self match:@[scoreCard]];
            if (!cardScore) return 0;
            else score += cardScore;
        }
    }
    return score;
    
}
-(NSString *)contents {
    //NSArray *rankStrings = [PlayingCard rankStrings];
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
    //return [rankStrings[self.rank] stringByAppendingString:self.suit];
}
@synthesize suit = _suit;
+(NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}
-(void) setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
-(NSString *)suit {
    return _suit ? _suit : @"";
}

+(NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+(NSUInteger)maxRank {
    return [self rankStrings].count - 1;
}
-(void) setRank:(NSUInteger)rank {
    if ( rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
