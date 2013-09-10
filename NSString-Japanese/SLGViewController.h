//
//  SLGViewController.h
//  NSString-Japanese
//
//  Created by Steven Grace on 4/19/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLGViewController : UIViewController


@property(nonatomic,readwrite,assign)IBOutlet UILabel *selectedTextLabel;
@property(nonatomic,readwrite,assign)IBOutlet UITextView *visibleTextView;
@property(nonatomic,readwrite,assign)IBOutlet UITextView *secretTextView;
@property(nonatomic,readwrite,assign)IBOutlet UISegmentedControl *segementedControl;

@property(nonatomic,readwrite,assign)IBOutlet UISwitch* editableSwitch;
@property(nonatomic,readwrite,assign)IBOutlet UISwitch* languageLoupeSwitch;


-(IBAction)editableSwitchAction:(id)sender;
-(IBAction)languageLoupeSwitchAction:(id)sender;



@end
