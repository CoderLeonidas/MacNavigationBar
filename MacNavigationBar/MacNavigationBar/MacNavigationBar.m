//
//  MacNavigationBar.m
//  MacNavigationBar
//
//  Created by leon on 2019/7/26.
//  Copyright © 2019 Leonidas. All rights reserved.
//

#import "MacNavigationBar.h"

@implementation NavigationBarItem {}
@end

@implementation MacNavigationBar {
    
}

- (void)viewDidAppear {
    NSWindowStyleMask mask = NSWindowStyleMaskFullSizeContentView ;
    self.view.window.styleMask |= mask;
    self.view.window.titlebarAppearsTransparent = YES;
    self.view.window.titleVisibility = NSWindowTitleHidden;

}

- (void)initVars {
    
    NSVisualEffectView *view = [NSVisualEffectView new];
    view.material = NSVisualEffectMaterialHUDWindow;
    view.blendingMode = NSVisualEffectBlendingModeBehindWindow;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVars];
}

#pragma mark - Events




#pragma mark - Setter



- (void)setItems:(NSArray<NavigationBarItem *> *)items {
    _items = items;
    for (NavigationBarItem *item in _items) {
        NSView *view = item.view;
        [view setFrameSize:NSMakeSize(40, 40)];
        [view setFrameOrigin:NSMakePoint(0.5 * (NSWidth(self.view.frame) - NSWidth(view.frame)), item.y + 0.5 * NSHeight(view.frame))];
        [self.view addSubview:view];
        
    }
}

@end
