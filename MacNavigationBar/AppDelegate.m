//
//  AppDelegate.m
//  MacNavigationBar
//
//  Created by leon on 2019/7/26.
//  Copyright © 2019 Leonidas. All rights reserved.
//

#import "AppDelegate.h"
#import "MacNavigationBar.h"

@interface AppDelegate () <NavigationBarDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) MacNavigationBar *bar;


@end

@implementation AppDelegate

- (void)addNoti {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutItems) name:NSWindowDidResizeNotification object:self.window];
    
}

- (void)removeNoti {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self addNoti];
    
    [self.window.contentView addSubview:self.bar.view];
    self.bar.view.autoresizingMask = (NSViewMinXMargin | NSViewMinYMargin | NSViewHeightSizable | NSViewMaxYMargin);
    self.bar.view.frame = NSMakeRect(0, 0, 69, NSHeight(self.window.contentView.frame));
    NSMutableArray *mItems = [NSMutableArray new];
    for (NSInteger i = 0; i < 4; i++) {
        NSButton *btn = [NSButton new];
        btn.bordered = NO;
        btn.title = [NSString stringWithFormat:@"按钮-%ld", i];
        btn.bezelStyle = NSBezelStyleRoundRect;
        btn.tag = i;
        btn.target = self;
        btn.action = @selector(btnClicked:);
        btn.wantsLayer = YES;
        btn.layer.backgroundColor = [[self randomColor] colorWithAlphaComponent:0.9].CGColor;
        NSImage *image = [NSImage imageNamed:@"AppIcon"];
        [image setSize:NSMakeSize(40, 40)];
        btn.image = image;
        
        NavigationBarItem *item = [NavigationBarItem new];
        item.view = btn;
        [mItems addObject:item];
    }
    
    _bar.items = mItems;
    [self layoutItems];
}

- (void)layoutItems {
    NSMutableArray *mItems = [NSMutableArray new];
    for (NSInteger i = 0; i <  _bar.items.count; i++) {
        NavigationBarItem *item =  _bar.items[i];

        item.y = NSHeight(self.window.contentView.frame) / 4 * (_bar.items.count-i-1);
        [mItems addObject:item];
    }
    _bar.items = mItems;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
    [self removeNoti];
}

- (MacNavigationBar *)bar {
    if (!_bar ) {
        _bar = [MacNavigationBar new];
        _bar.delegate = self;

    }
    return _bar ;
}

- (void)btnClicked:(id)sender {
    NSButton *btn = (NSButton *)sender;
    NSLog(@"button %ld clicked!", btn.tag);
}

#pragma mark - NavigationBarDelegate
- (void)mouseDragPointDidUpdate:(NSPoint)pt {
    NSPoint origin = NSMakePoint(self.window.frame.origin.x + pt.x, self.window.frame.origin.y + pt.y);
    [self.window setFrameOrigin:origin];
}

- (NSColor *)randomColor {
    int R = (arc4random() % 256);
    int G = (arc4random() % 256);
    int B = (arc4random() % 256);
    return [NSColor colorWithRed:R/255.0 green:G/255.0  blue:B/255.0  alpha:1.0];
}

@end
