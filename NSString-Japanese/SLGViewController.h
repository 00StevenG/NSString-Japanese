//
//  SLGViewController.h
//  NSString-Japanese
//
//  Created by Steven Grace on 4/19/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLGViewController : UIViewController


@property(nonatomic,readwrite)IBOutlet UILabel *selectedTextLabel;
@property(nonatomic,readwrite)IBOutlet UITextView* textView;
@property(nonatomic,readwrite)IBOutlet UILabel* outputLabel;
@property(nonatomic,readwrite)IBOutlet UISegmentedControl* segementedControl;


@end
