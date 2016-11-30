//
//  BoardDetailViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//
#import "PlayerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BoardDetailViewController.h"


@interface BoardDetailViewController ()
@property (strong) NSArray *centreSpaces;
@property (nonatomic) NSInteger currentCentre;
@property NSMutableArray *shotValues;
@property (weak, nonatomic) IBOutlet UILabel *shot1Val;
@property (weak, nonatomic) IBOutlet UILabel *shot2Val;
@property (weak, nonatomic) IBOutlet UILabel *shot3Val;
@property (weak, nonatomic) IBOutlet UIImageView *boardView;
@property (nonatomic) CGFloat boardRotation;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *multiplierButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *bullButtons;
@property (weak, nonatomic) IBOutlet UIButton *confirmScores;
@property (nonatomic) NSInteger shotCount;
@end

@implementation BoardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftSliceLabel setTransform:CGAffineTransformMakeRotation(-M_PI_2/4.5)];
    [self.rightSliceLabel setTransform:CGAffineTransformMakeRotation(M_PI_2/4.5)];
    
    self.shotCount = 0;
    self.shotValues = [[NSMutableArray alloc]initWithObjects:@"", @"", @"", nil];
    [self updateShotValueLabels];
    self.currentCentre = 0;
    self.boardRotation = 0;
    self.centreSpaces = @[@"20", @"1", @"18", @"4", @"13", @"6", @"10", @"15", @"2", @"17", @"3", @"19", @"7", @"16", @"8", @"11", @"14", @"9", @"12", @"5"];
    self.centreSliceLabel.text = [self.centreSpaces objectAtIndex:self.currentCentre];
    for (UIButton* button in self.multiplierButtons) {
        [button addTarget:self action:@selector(enterScore:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (UIButton* button in self.bullButtons) {
        [button addTarget:self action:@selector(enterScore:) forControlEvents:UIControlEventTouchUpInside];
    }
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
    UITapGestureRecognizer *tapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
    tapGestureRecognizer1.numberOfTapsRequired = 1;
    tapGestureRecognizer2.numberOfTapsRequired = 1;
    tapGestureRecognizer3.numberOfTapsRequired = 1;
    [self.shot1Val addGestureRecognizer:tapGestureRecognizer1];
    [self.shot2Val addGestureRecognizer:tapGestureRecognizer2];
    [self.shot3Val addGestureRecognizer:tapGestureRecognizer3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Confirm Scores and Unwind Segue

- (IBAction)confirmScore:(id)sender {
    [self unwindForSegue:(UIStoryboardSegue*)sender towardsViewController:(PlayerViewController*)self.delegate];
}

-(IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController*)subsequentVC
{
    self.delegate = unwindSegue.sourceViewController;
    self.delegate.shotValues = self.shotValues;
}

#pragma mark - Score Buttons

-(void)enterScore:(UIButton*)sender
{
    if ([self.multiplierButtons containsObject:sender]) {
        [self.shotValues replaceObjectAtIndex:self.shotCount withObject:[NSString stringWithFormat:@"%@*%ld", self.centreSpaces[self.currentCentre], sender.tag]];
    }
    if ([self.bullButtons containsObject:sender]) {
        [self.shotValues replaceObjectAtIndex:self.shotCount withObject:[NSString stringWithFormat:@"25*%ld", sender.tag]];
    }
    self.shotCount++;
    [self updateShotValueLabels];
}

-(void)updateShotValueLabels
{
    self.shot1Val.text = [self.shotValues objectAtIndex:0];
    self.shot2Val.text = [self.shotValues objectAtIndex:1];
    self.shot3Val.text = [self.shotValues objectAtIndex:2];
    UIColor *highlightColour = [UIColor colorWithRed:(float)222 green:(float)165 blue:(float)9 alpha:0.5];
    
    switch (self.shotCount) {
        case 0:
            self.shot1Val.backgroundColor = highlightColour;
            self.shot2Val.backgroundColor = nil;
            self.shot3Val.backgroundColor = nil;
            self.shot1Val.userInteractionEnabled = NO;
            break;
        case 1:
            self.shot1Val.backgroundColor = nil;
            self.shot2Val.backgroundColor = highlightColour;
            self.shot3Val.backgroundColor = nil;
            self.shot1Val.userInteractionEnabled = YES;
            self.shot2Val.userInteractionEnabled = NO;
            break;
        case 2:
            self.shot1Val.backgroundColor = nil;
            self.shot2Val.backgroundColor = nil;
            self.shot3Val.backgroundColor = highlightColour;
            self.shot1Val.userInteractionEnabled = NO;
            self.shot2Val.userInteractionEnabled = YES;
            self.shot3Val.userInteractionEnabled = NO;
            break;
        default:
            self.shot1Val.backgroundColor = nil;
            self.shot2Val.backgroundColor = nil;
            self.shot3Val.backgroundColor = nil;
            self.shot2Val.userInteractionEnabled = NO;
            self.shot3Val.userInteractionEnabled = YES;
            break;
    }
    if (self.shotCount == 3) {
        [self setInteractivity:self.multiplierButtons To:NO];
        [self setInteractivity:self.bullButtons To:NO];
        self.confirmScores.hidden = NO;
        self.confirmScores.userInteractionEnabled = YES;
    }else{
        [self setInteractivity:self.multiplierButtons To:YES];
        [self setInteractivity:self.bullButtons To:YES];
        self.confirmScores.hidden = YES;
        self.confirmScores.userInteractionEnabled = NO;
    }
}

#pragma mark - Rotate DartBoard methods

-(void)setSliceLabels:(NSString *)centreIndex
{
    NSInteger centre = [self.centreSpaces indexOfObject:centreIndex];
    NSInteger right;
    NSInteger left;
    
    switch (centre) {
        case 0:
            left = 19;
            right = centre+1;
            break;
        case 19:
            right = 0;
            left = centre-1;
            break;
        default:
            right = centre+1;
            left = centre-1;
            break;
    }
    self.centreSliceLabel.text = [self.centreSpaces objectAtIndex:centre];
    self.leftSliceLabel.text = [self.centreSpaces objectAtIndex:left];
    self.rightSliceLabel.text = [self.centreSpaces objectAtIndex:right];
}
- (IBAction)clockwiseTurn:(id)sender {
    self.currentCentre++;
    if (self.currentCentre == 20) {
        self.currentCentre = 0;
    }
    self.boardRotation -= 0.314;
    [UIView animateWithDuration:0.5 animations:^{
        self.boardView.transform = CGAffineTransformMakeRotation(self.boardRotation);
    }];
    [self performSelector:@selector(setSliceLabels:) withObject:self.centreSpaces[self.currentCentre] afterDelay:0.25];
}
- (IBAction)counterclockwiseTurn:(id)sender {
    self.currentCentre--;
    if (self.currentCentre == -1) {
        self.currentCentre = 19;
    }
    self.boardRotation += 0.314;
    [UIView animateWithDuration:0.5 animations:^{
        self.boardView.transform = CGAffineTransformMakeRotation(self.boardRotation);
    }];
    [self performSelector:@selector(setSliceLabels:) withObject:self.centreSpaces[self.currentCentre] afterDelay:0.25];
}

#pragma mark - Button Interactivity
-(void)setInteractivity:(NSArray*)buttons To:(BOOL)toSet
{
    for (UIButton* button in buttons) {
        button.userInteractionEnabled = toSet;
    }
}

-(void)labelTapped:(UILabel*)sender {
    if (self.shotCount == 1) {
        self.shotValues[0] = @"";
        self.shotCount--;
        [self updateShotValueLabels];
    } else if (self.shotCount == 2) {
        self.shotValues[1] = @"";
        self.shotCount--;
        [self updateShotValueLabels];
    } else {
        self.shotValues[2] = @"";
        self.shotCount--;
        [self updateShotValueLabels];
    }
    
}

@end
