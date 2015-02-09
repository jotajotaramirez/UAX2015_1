//
//  UAXBetsListViewController.m
//  Porra
//
//  Created by Juan Jose Ramirez Escribano on 15/1/15.
//  Copyright (c) 2015 UAX. All rights reserved.
//

#import "UAXBetsListViewController.h"
#import "UAXBet.h"
#import "UAXAddBetViewController.h"

#define kCellIdentifier @"kCellIdentifier"

@interface UAXBetsListViewController ()
@property (weak, nonatomic) NSManagedObjectContext* context;
@property (strong, nonatomic) NSArray *bets;
@end

@implementation UAXBetsListViewController

- (instancetype)initWithContext:(NSManagedObjectContext*)context {
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.context = context;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Apuestas";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBet)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bet" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    self.bets = [self.context executeFetchRequest:fetchRequest error:&error];
    
    [self.tableView reloadData];
}

- (void)addBet {
    UAXAddBetViewController *vc = [[UAXAddBetViewController alloc] initWithContext:self.context];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bets.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    UAXBet *bet = [self.bets objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", bet.name, bet.result];
    
    return cell;
}


@end
