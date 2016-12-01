//
//  BoardDetailViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import <UIKit/UIKit.h>

@protocol displayBoard <NSObject>
@property (nonatomic) NSArray *shotValues;
@end

@interface BoardDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *leftSliceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightSliceLabel;
@property (weak, nonatomic) IBOutlet UILabel *centreSliceLabel;
@property id<displayBoard> delegate;

@end
