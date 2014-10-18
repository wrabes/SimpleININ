//
//  BMHViewController.m
//  SimpleININ
//
//  Created by Cameron Wrabel on 10/18/14.
//  Copyright (c) 2014 Cameron Wrabel. All rights reserved.
//

#import "BMHViewController.h"

@interface BMHViewController ()

@end

@implementation BMHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",self.phoneNumberField.text);
    [self.phoneNumberField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getInfo:(id)sender {
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    
    UIColor *color = [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
    
   // [sender.view setBackgroundColor:color];
    
    [self.view setBackgroundColor:color];
}

- (BOOL)getNumber:(id)numberBox{
    
    NSString *number = self.phoneNumberField.text;
    
    if([number length] != 10){
        return NO;
    }else{
        
        return YES;
    }
    
    
}

- (IBAction)makeCall:(id)sender{
    
    NSString *number, *appId, *appKey, *message;
    
    appId = @"458722";
    appKey = @"ff05e0969ea3b133d9624e434c";
    message = @"Hello, Mom and Dad. This is part of our hack this weekend. Hopefully this isn't too weird for you. Go Bucks!";
    number = self.phoneNumberField.text;
    
    
    
    [self makeCallAndPlayTts:(NSString*)(message) toNumber:(NSString*) number withAppId:(NSString*)(appId) withAppKey:(NSString*)(appKey)];
}


-(void) makeCallAndPlayTts:
                        (NSString*) message
                  toNumber:(NSString*)number
                 withAppId:(NSString*)appId
                withAppKey:(NSString*)appKey
                            

{
    
    NSLog(@"You entered message %@",message);
    NSLog(@"You entered number %@",number);
    NSLog(@"You entered appId %@",appId);
    NSLog(@"You entered appKey %@",appKey);

    
    NSError* error = nil;
    NSURL *restURL =
    [NSURL URLWithString:
     [NSString stringWithFormat:@"http://hackathonapi.inin.com/api/%@/call/callandplaytts", appId]];
    
    
    
    NSMutableURLRequest *restRequest = [NSMutableURLRequest requestWithURL:restURL];
    
    [restRequest setValue:appKey forHTTPHeaderField:@"Api-Key"];
    NSDictionary *data = @{ @"number" : number ,
                            @"message" : message };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [NSString stringWithUTF8String:[jsonData bytes]];
    NSLog(@"%@", jsonString);
    
    [restRequest setHTTPBody:jsonData];
    [restRequest setHTTPMethod:@"POST"];
    [restRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [restRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    NSHTTPURLResponse* response;
    
    NSData *resp = [NSURLConnection sendSynchronousRequest:restRequest  returningResponse:&response error:&error];
    NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:resp
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
    

    
}

@end
