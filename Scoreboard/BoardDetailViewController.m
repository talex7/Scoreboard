//
//  BoardDetailViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//
#import <QuartzCore/QuartzCore.h>
#import "BoardDetailViewController.h"

typedef enum : NSUInteger {
    clockWiseTurn,
    counterClockWiseTurn
} Spin;

@interface BoardDetailViewController ()
@property (strong) NSArray *centreSpaces;
@property (nonatomic) NSInteger currentCentre;
@property (weak, nonatomic) IBOutlet UIImageView *boardView;
@property (nonatomic) CGFloat boardRotation;
@end

@implementation BoardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftSliceLabel setTransform:CGAffineTransformMakeRotation(-M_PI_2/4.5)];
    [self.rightSliceLabel setTransform:CGAffineTransformMakeRotation(M_PI_2/4.5)];
    self.currentCentre = 0;
    self.boardRotation = 0;
    self.centreSpaces = @[@"20", @"1", @"18", @"4", @"13", @"6", @"10", @"15", @"2", @"17", @"3", @"19", @"7", @"16", @"8", @"11", @"14", @"9", @"12", @"5"];
    
    self.centreSliceLabel.text = [self.centreSpaces objectAtIndex:self.currentCentre];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
-(void)spinBoard:(Spin)spin
{
    switch (spin) {
        case clockWiseTurn:
            [self runSpinAnimationOnView:self.boardView duration:1 rotations:-0.314 repeat:0];
            break;
        case counterClockWiseTurn:
            
            break;
            
        default:
            break;
    }
}
- (IBAction)clockwiseTurn:(id)sender {
    self.currentCentre++;
    if (self.currentCentre == 20) {
        self.currentCentre = 0;
    }
    [self spinBoard:clockWiseTurn];
    [self.boardView setTransform:CGAffineTransformMakeRotation(self.boardRotation-=0.314)];
    [self setSliceLabels: self.centreSpaces[self.currentCentre]];
}
- (IBAction)counterclockwiseTurn:(id)sender {
    self.currentCentre--;
    if (self.currentCentre == -1) {
        self.currentCentre = 19;
    }
    [self setSliceLabels: self.centreSpaces[self.currentCentre]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: rotations*duration];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
