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
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game.turnCounter = arc4random_uniform(2);
    
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
    switch (self.game.turnCounter) {
        case 0:
            self.currentPlayerLabel.text = [self.players objectAtIndex: self.game.turnCounter].name;
            break;
        case 1:
            self.currentPlayerLabel.text = [self.players objectAtIndex: self.game.turnCounter].name;
            break;
        default:
            break;
    }
}

-(void)turnProgression
{
    self. self.game.turnCounter++;
    if (self.game.turnCounter == 2) {
        self.game.turnCounter = 0;
        self.currentPlayerLabel.text = [self.players objectAtIndex: self.game.turnCounter].name;
    }else{
        self.currentPlayerLabel.text = [self.players objectAtIndex: self.game.turnCounter].name;
    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
