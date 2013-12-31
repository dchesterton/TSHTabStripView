//
// TSHTab.m
//
// Copyright (c) 2013 Chesterton Software Development Ltd. All rights reserved.
// http://www.chestertondevelopment.com
//

#import "TSHTab.h"

@implementation TSHTab

#pragma mark - Init

- (id)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
    }
    return self;
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"TATab <\"%@\">", self.title];
}

@end
