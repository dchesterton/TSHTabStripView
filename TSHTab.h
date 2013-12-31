//
// TSHTab.h
//
// Copyright (c) 2013 Chesterton Software Development Ltd. All rights reserved.
// http://www.chestertondevelopment.com
//

#import <Foundation/Foundation.h>

@interface TSHTab : NSObject

// the title of the tab
@property (nonatomic, copy) NSString *title;

// initializer with title
- (id)initWithTitle:(NSString *)title;

@end
