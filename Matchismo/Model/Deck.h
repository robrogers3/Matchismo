//
//  Deck.h
//  Matchismo
//
//  Created by Robert Rogers on 2/2/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

-(void)addCard:(Card *) card atTop: (BOOL) atTop;
-(Card *)drawRandomCard;
@end
