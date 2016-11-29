//
//  PlayerViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//


#import "PageViewController.h"
#import "PlayerViewController.h"

@interface PlayerViewController () <Pages>
@property (weak, nonatomic) IBOutlet UIButton *finshButton;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayerLabel;
@property (nonatomic) NSInteger turnOrder;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.turnOrder = arc4random_uniform(2);
    
    self.finshButton.hidden = YES;
    self.finshButton.userInteractionEnabled = NO;
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Flipping"
                                 message:@"Flipping Coin for Turn Order"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Got It!"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
    switch (self.turnOrder) {
        case 0:
            self.currentPlayerLabel.text = [self.players objectAtIndex:self.turnOrder].name;
            break;
        case 1:
            self.currentPlayerLabel.text = [self.players objectAtIndex:self.turnOrder].name;
            break;
        default:
            break;
    }
}

-(void)turnProgression
{
    self.turnOrder++;
    if (self.turnOrder == 2) {
        self.turnOrder = 0;
        self.currentPlayerLabel.text = [self.players objectAtIndex:self.turnOrder].name;
    }else{
        self.currentPlayerLabel.text = [self.players objectAtIndex:self.turnOrder].name;
    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
