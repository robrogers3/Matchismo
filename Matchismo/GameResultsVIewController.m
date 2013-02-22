//
//  CardGameResultsVIewControllerViewController.m
//  Matchismo
//
//  Created by Robert Rogers on 2/14/13.
//  Copyright (c) 2013 Rob Rogers. All rights reserved.
//

#import "GameResultsVIewController.h"
#import "GameResult.h"
@interface GameResultsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *display;
@property (strong,nonatomic) NSArray *allGameResults;
@end

@implementation GameResultsViewController
-(IBAction)sortbyDate {
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(dateCompare:)];
    [self updateUI];
}
- (IBAction)sortByScore {
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(scoreCompare:)];
    [self updateUI];
}
- (IBAction)sortByDuration {
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(durationCompare:)];
    [self updateUI];
}
-(void)updateUI {
    NSString *displayText = @"";
    for( GameResult *result in self.allGameResults) {
        displayText = [displayText stringByAppendingFormat:@"Score: %4d (%@, %0g)\n",result.score,
                       [NSDateFormatter localizedStringFromDate:result.end dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle],
                       round(result.duration)];
    }
    self.display.text = displayText;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.allGameResults = [GameResult allGameResults];
    [self updateUI];
}
-(void) setup
{
    //;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    [self setup];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
