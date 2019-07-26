//
//  AppDelegate.m
//  MacNavigationBar
//
//  Created by leon on 2019/7/26.
//  Copyright © 2019 Leonidas. All rights reserved.
//

#import "AppDelegate.h"
#import "NavigationBar.h"

@interface AppDelegate () <NavigationBarDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) NavigationBar *bar;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    [self.window.contentView addSubview:self.bar.view];
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
        btn.layer.backgroundColor = [[NSColor orangeColor] colorWithAlphaComponent:0.9].CGColor;
        NSImage *image = [NSImage imageNamed:@"AppIcon"];
        [image setSize:NSMakeSize(40, 40)];
        btn.image = image;
        
        NavigationBarItem *item = [NavigationBarItem new];
        item.view = btn;
        item.y = NSHeight(self.window.frame) / 4 * (4-i-1) ;
        [mItems addObject:item];
    }
    
    _bar.items = mItems;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (NavigationBar *)bar {
    if (!_bar ) {
        _bar = [NavigationBar new];
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

@end
