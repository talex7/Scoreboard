//
//  ViewController.h
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-27.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *playerPicker;


@end

