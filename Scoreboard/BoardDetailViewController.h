//
//  BoardDetailViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import <UIKit/UIKit.h>

@interface BoardDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *leftSliceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightSliceLabel;
@property (weak, nonatomic) IBOutlet UILabel *centreSliceLabel;

@end
