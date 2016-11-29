//
//  BoardDetailViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import <QuartzCore/QuartzCore.h>
#import "BoardDetailViewController.h"


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
    [UIView animateWithDuration:1 animations:^{
        self.boardView.transform = CGAffineTransformMakeRotation(self.boardRotation);
    }];
    [self performSelector:@selector(setSliceLabels:) withObject:self.centreSpaces[self.currentCentre] afterDelay:0.5];
    
}
- (IBAction)counterclockwiseTurn:(id)sender {
    self.currentCentre--;
    if (self.currentCentre == -1) {
        self.currentCentre = 19;
    }
    self.boardRotation += 0.314;
    [UIView animateWithDuration:1 animations:^{
        self.boardView.transform = CGAffineTransformMakeRotation(self.boardRotation);
    }];
    [self performSelector:@selector(setSliceLabels:) withObject:self.centreSpaces[self.currentCentre] afterDelay:0.5];
}

@end
