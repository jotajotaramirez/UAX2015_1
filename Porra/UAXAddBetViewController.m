//
//  UAXAddBetViewController.m
//  Porra
//
//  Created by Juan Jose Ramirez Escribano on 20/1/15.
//  Copyright (c) 2015 UAX. All rights reserved.
//

#import "UAXAddBetViewController.h"
#import "UAXBet.h"

@interface UAXAddBetViewController ()
@property (weak, nonatomic) NSManagedObjectContext* context;
@property (weak, nonatomic) IBOutlet UITextField *name;
@end

@implementation UAXAddBetViewController

- (instancetype)initWithContext:(NSManagedObjectContext*)context {
    self = [super init];
    
    if (self) {
        self.context = context;
        self.title = @"Nueva entrada";
    }
    
    return self;
}
- (IBAction)addNewBet:(id)sender {
    UIButton *button = (UIButton*)sender;
    
    UAXBet *bet = [NSEntityDescription insertNewObjectForEntityForName:@"Bet" inManagedObjectContext:self.context];
    bet.name = self.name.text;
    bet.result = [button titleForState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
