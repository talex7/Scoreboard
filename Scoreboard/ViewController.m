//
//  ViewController.m
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-27.
//
//

#import "ViewController.h"
#import "GameManager.h"
#import "PageViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (nonatomic) NSInteger noOfPlayers;
@property (nonatomic) NSManagedObjectContext *moc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playerPicker.dataSource = self;
    self.playerPicker.delegate = self;
    
    AppDelegate *appDelegate = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    
    self.moc = appDelegate.persistentContainer.viewContext;
                                   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *nav = (UINavigationController*)[segue destinationViewController];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Player"];

    NSInteger gameType = [self.playerPicker selectedRowInComponent:0];
    PageViewController *pVC = (PageViewController*)nav.topViewController;
    
    NSError *error = nil;
    NSArray *fetchResults = [self.moc executeFetchRequest:request error:&error];
    NSMutableArray <Player *>*playerArray = [NSMutableArray new];
    
    if (gameType == 0) {
        Game *game = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.moc];
        game.timeStarted = [NSDate date];
        pVC.game = game;
        
        if (fetchResults.count < 1) {
            Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
            player.name = @"Player";
            [playerArray addObject:player];
        } else {
            [playerArray addObject:fetchResults[0]];
        }
        
        if (fetchResults.count < 2) {
            Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
            player.name = @"Opponent";
            [playerArray addObject:player];
            
        } else {
            [playerArray addObject:fetchResults[1]];
        }
        
        pVC.game.player = (NSOrderedSet<Player*>*)[NSOrderedSet orderedSetWithArray:playerArray];
    }
    
    
    pVC.players = playerArray;
    
    
    if ([[self moc] save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    pVC.pageIndex = 0;
}



#pragma mark - PickerView

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *rowLabel;
    switch (row) {
        case 0:
            rowLabel = @"New Game";
            
            return rowLabel;
        case 1:
            rowLabel = @"Continue";
            return rowLabel;
    }
    return rowLabel;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return 2;
}



@end
