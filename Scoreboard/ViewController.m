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
    
    GameManager *gm = [GameManager new];
    
    
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
    PageViewController *pVC = (PageViewController*)[segue destinationViewController];
    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
//    NSInteger idNo = 01;
//    [request setPredicate:[NSPredicate predicateWithFormat:@"id == %@", idNo]];
//    
//    NSError *error = nil;
//    NSArray *results = [self.moc executeFetchRequest:request error:&error];
//    if (!results) {
//        Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
//        results = [results arrayByAddingObject:player];
////        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
////        abort();
//    }
//    
//    if (self.noOfPlayers == 2) {
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
//        NSInteger idNo = 02;
//        [request setPredicate:[NSPredicate predicateWithFormat:@"id == %@", idNo]];
//        
//        NSError *error = nil;
//        NSArray *results2 = [self.moc executeFetchRequest:request error:&error];
//        if (!results2) {
//            Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
//            results = [results arrayByAddingObject:player];
//            //        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
//            //        abort();
//        } else {
//            results = [results arrayByAddingObjectsFromArray:results2];
//        }
//    }
//    [pVC.players addObjectsFromArray:results];
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
            rowLabel = @"Single Player";
            self.noOfPlayers = 1;
            return rowLabel;
        case 1:
            rowLabel = @"2 Players";
            self.noOfPlayers = 2;
            return rowLabel;
    }
    return rowLabel;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}



@end
