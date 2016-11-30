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
    
    if (self.game.turnCounter == 1) {
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
    }
    [self turnProgression];
}


#pragma mark - Turn Progress/Reset

-(void)turnProgression
{
    if (self.game.turnCounter % 2 == 0) {
        self.currentPlayerLabel.text = [self.game.player objectAtIndex: 0].name;
    }else{
        self.currentPlayerLabel.text = [self.game.player objectAtIndex: 1].name;
    }
    self.game.turnCounter++;
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
