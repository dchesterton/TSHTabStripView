//
// TSHTabView.m
//
// Copyright (c) 2013 Chesterton Software Development Ltd. All rights reserved.
// http://www.chestertondevelopment.com
//

#import "TSHTabView.h"

@implementation TSHTabView

#pragma mark - Init

- (id)init
{
    self = [super init];
    if (self) {
        // set appearance defaults
        _selectedTitleColor = [UIColor blackColor];
        _titleColor = [UIColor lightGrayColor];
        _font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f];
        _highlightedBackgroundColor = [UIColor colorWithWhite:0.98f alpha:1.0f];
    }
    return self;
}

#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.highlighted = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.highlighted = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.highlighted = NO;
}

#pragma mark - UIView

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateBackgroundColor];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateBackgroundColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    UIColor *titleColor = (self.selected)? self.selectedTitleColor: self.titleColor;
    [self setTitleColor:titleColor forState: UIControlStateNormal];
    [self setTitle:self.tab.title forState:UIControlStateNormal];

    self.titleLabel.font = self.font;

    [self updateBackgroundColor];
}

#pragma mark - Background Color

- (void)updateBackgroundColor
{
    if (self.selected == NO && self.highlighted) {
        self.backgroundColor = (self.highlighted)? self.highlightedBackgroundColor: [UIColor clearColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
