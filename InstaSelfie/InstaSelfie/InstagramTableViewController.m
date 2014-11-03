//
//  ESelfies.m
//  InstaSelfie
//
//  Created by robint on 10/21/14.
//  Copyright (c) 2014 robint. All rights reserved.
//

#import "InstagramTableViewController.h"
#import "ECellTableViewCell.h"
#import "AFNetworking.h"
#import "Photos.h"

@interface InstagramTableViewController()

@end

@implementation InstagramTableViewController

- (void)viewDidLoad
{
    self.instagramModelInstance = [[InstagramModel alloc]init];
    self.instagramModelInstance.delegate = self;
    [self sendMessageToServerRequestInModel];
    self.arrayOfData = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    
    [self.tableView registerClass:[ECellTableViewCell class] forCellReuseIdentifier:@"ECell"];
    self.tableView.separatorColor = [UIColor clearColor];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
       self.navigationItem.title = @"InstaSelfie";
       self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStyleBordered target:self action:@selector(sendMessageToServerRequestInModel)];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
  //  [self serverRequest];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arrayOfData count];
}

- (ECellTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ECellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECell" forIndexPath:indexPath];
    
    
    UIImageView *medium = nil;
    UIImageView *small = nil;
    UIImageView *big = nil;
    
    if (!cell)
    {
        cell = [[ECellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ECell"];
    }
    
    
    Photos *photosInstance = self.arrayOfData[indexPath.row];
    
    big = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[photosInstance photoA]]];
    [big setFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, 200, 200)];
    [cell.contentView addSubview:big];
    
    medium = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[photosInstance photoB]]];
    [medium setFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y+205, 100, 100)];
    [cell.contentView addSubview:medium];
    
    small = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[photosInstance photoC]]];
    [small setFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y+310, 50, 50)];
    [cell.contentView addSubview:small];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 365.0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView reloadData];
}

// Procotol delegate - Implementation
- (void)dataFromModel:(NSArray *)dataArray {
    self.arrayOfData = [dataArray mutableCopy];
    [self.tableView reloadData];
    [self.tableView setNeedsDisplay];
}

- (void)sendMessageToServerRequestInModel {
    dispatch_queue_t sendMessageToServer = dispatch_queue_create("serverRequestForRecentSelfie",NULL);
    dispatch_async(sendMessageToServer, ^(void) {
    [self.instagramModelInstance serverRequest];
    });
}
@end
