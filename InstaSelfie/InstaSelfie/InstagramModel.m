//
//  InstagramModel.m
//  InstaSelfie
//
//  Created by robint on 10/21/14.
//  Copyright (c) 2014 robint. All rights reserved.
//

#import "InstagramModel.h"
#import "AFNetworking.h"

@implementation InstagramModel

// Server Request to fetch all the selfies from Instagram API
- (void)serverRequest
{
    // Implementing server Request in async background queue
    dispatch_queue_t serverRequestForRecentSelfie = dispatch_queue_create("serverRequestForRecentSelfie",NULL);
    dispatch_async(serverRequestForRecentSelfie, ^(void) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"lat": @"40.7127", @"lng":@"74.0059", @"code":@"ad67957b3b36434c9cface4aad2a2d08", @"client_id":@"bbc8b4a8ca474e2781bc3019799efa4a", @"count":@"1000", @"distance":@"10000"};
        
        [manager GET:@"https://api.instagram.com/v1/tags/selfie/media/recent" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            [self parse:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    });
}

// parse the response from Instagram API
-(void)parse:(NSDictionary *)selfie
{
        self.arrayOfDataFromServer = [[NSMutableArray alloc]init];
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSMutableArray *tempArrayToStoreServerData = [[NSMutableArray alloc] init];
        NSInteger length = [[selfie objectForKey:@"data"] count];
    dispatch_queue_t backgroundQueueForImagefromURL = dispatch_queue_create("backgroundQueueForImagefromURL", NULL);
    dispatch_async(backgroundQueueForImagefromURL, ^(void){
        for(int i = 0;i<length;++i)
        {
            NSDictionary *profile = [selfie objectForKey:@"data"][i];
            NSURL *url = [NSURL URLWithString:[[[profile objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            [dataArray addObject:data];
        }
        for(int i = 0; i<[dataArray count]-2;++i)
        {
            Photos *photosInstance = [[Photos alloc] init];
            photosInstance.photoA = dataArray[i];
            photosInstance.photoB = dataArray[++i];
            photosInstance.photoC = dataArray[++i];
            [tempArrayToStoreServerData addObject:photosInstance];
        }
        [self.arrayOfDataFromServer addObjectsFromArray:tempArrayToStoreServerData];
        [self.delegate dataFromModel:self.arrayOfDataFromServer];
    });
}

@end
