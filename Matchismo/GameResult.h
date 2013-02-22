//
//  GameResult.h
//  Matchismo
//
//  Created by Robert Rogers on 2/14/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject
+(NSArray *)allGameResults;
@property (readonly,nonatomic) NSDate *start;
@property (readonly,nonatomic) NSDate *end;
@property (readonly,nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
-(NSComparisonResult)dateCompare:(GameResult *)aGameResult;
-(NSComparisonResult)scoreCompare:(GameResult *)aGameResult;
-(NSComparisonResult)durationCompare:(GameResult *)aGameResult;
@end
