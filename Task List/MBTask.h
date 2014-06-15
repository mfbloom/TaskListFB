//
//  MBTask.h
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBTask : NSObject

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *description;
@property (strong,nonatomic) NSDate *date;
@property (nonatomic) BOOL isCompleted;

- (id)initWithData:(NSDictionary *)data;



@end
