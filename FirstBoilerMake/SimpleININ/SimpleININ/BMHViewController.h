//
//  BMHViewController.h
//  SimpleININ
//
//  Created by Cameron Wrabel on 10/18/14.
//  Copyright (c) 2014 Cameron Wrabel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMHViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberField;

- (IBAction)getInfo:(id)sender;

-(void) makeCallAndPlayTts:(NSString*) message
                  toNumber:(NSString*)number
                 withAppId:(NSString*)appId
                withAppKey:(NSString*)appKey;

- (BOOL)getNumber:(id)numberBox;

- (IBAction)makeCall:(id)sender;

@end
