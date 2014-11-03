//
//  InstagramModel.h
//  InstaSelfie
//
//  Created by robint on 10/21/14.
//  Copyright (c) 2014 robint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photos.h"

//Protocol Declararion to Communicate between model and Controller
@protocol ModelDelegate

- (void)dataFromModel:(NSArray *)dataArray;

@end

@interface InstagramModel : NSObject

@property (strong, nonatomic)id delegate;
@property (strong, nonatomic)NSMutableArray *arrayOfDataFromServer;

- (void)serverRequest;
- (void)parse:(NSDictionary *)selfie;

@end
