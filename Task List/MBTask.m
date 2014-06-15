//
//  MBTask.m
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import "MBTask.h"

@implementation MBTask


- (id)initWithData:(NSDictionary *)data
{
    //use NSObject init
    self = [super init];
    
    if(self)
    {
        self.title = data[TITLE];
        self.description = data[DESCRIPTION];
        self.date = data[DATE];
        self.isCompleted = [data[COMPLETION] boolValue];
    }
    
    return self;
}

-(id)init{
    self = [self initWithData:nil];
    
    return self;
}


@end
