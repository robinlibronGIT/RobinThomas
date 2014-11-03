//
//  ESelfies.h
//  InstaSelfie
//
//  Created by robint on 10/21/14.
//  Copyright (c) 2014 robint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstagramModel.h"
#import "InstagramModel.h"

@interface InstagramTableViewController : UITableViewController<UIScrollViewDelegate,ModelDelegate>

@property (strong, nonatomic)InstagramModel *instagramModelInstance;
@property (strong, nonatomic)NSMutableArray *arrayOfData;

@end
