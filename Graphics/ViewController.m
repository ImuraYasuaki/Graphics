//
//  ViewController.m
//  Graphics
//
//  Created by myuon on 2015/01/04.
//  Copyright (c) 2015年 yasu. All rights reserved.
//

#import "ViewController.h"
#import "GYFunctionsView.h"
#import "GYViewCommand.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *commands;
- (void)performCommandAtIndex:(NSInteger)index;
@end

@interface ViewController (ViewInstantiate)
- (UIView *)firstView;
@end

@interface ViewController (TableView) <UITableViewDataSource, UITableViewDelegate>
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setCommands:@[
                        [GYViewCommand commandWithTarget:self.firstView showSelector:@selector(show) hideSelector:@selector(hide)],
                        ]];
    [self.tableView reloadData];
}

- (void)performCommandAtIndex:(NSInteger)index {
    GYViewCommand *command = [self.commands objectAtIndex:index];
    [command perform];
}

@end

@implementation ViewController (TableView)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.commands count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    GYViewCommand *command = [self.commands objectAtIndex:indexPath.row];
    [cell.textLabel setText:command.name];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self performCommandAtIndex:indexPath.row];
}

@end

@implementation ViewController (ViewInstantiate)

- (UIView *)firstView {
    NSArray *titles = @[
                        // Right - Top, Center, Bottom
                        [NSString stringWithFormat:@"Right-Top: %zd", GYFunctionsViewPositionRight|GYFunctionsViewPositionTop],
                        [NSString stringWithFormat:@"Right-Center: %zd", GYFunctionsViewPositionRight|GYFunctionsViewPositionCenter],
                        [NSString stringWithFormat:@"Right-Bottom: %zd", GYFunctionsViewPositionRight|GYFunctionsViewPositionBottom],

                        // Right - Top, Center, Bottom
                        [NSString stringWithFormat:@"Left-Top: %zd", GYFunctionsViewPositionLeft|GYFunctionsViewPositionTop],
                        [NSString stringWithFormat:@"Left-Center: %zd", GYFunctionsViewPositionLeft|GYFunctionsViewPositionCenter],
                        [NSString stringWithFormat:@"Left-Bottom: %zd", GYFunctionsViewPositionLeft|GYFunctionsViewPositionBottom],
                        ];
    return [GYFunctionsView functionsViewFrom:GYFunctionsViewPositionRight titles:titles selected:^(GYFunctionsView *functionsView, UIButton *sender, NSUInteger index) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        [self performCommandAtIndex:selectedIndexPath.row];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(functionsView.animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *title = [sender titleForState:UIControlStateNormal];
            NSRange range = [title rangeOfString:@": "];
            if (range.location == NSNotFound) {
                return;
            }
            NSInteger position = [[title substringFromIndex:range.location + range.length] integerValue];
            [functionsView setPosition:(GYFunctionsViewPosition)position];
        });
    }];
}

@end
