//
//  LYWindow.m
//  MacNavigationBar
//
//  Created by Leonidas.Luo on 2/12/20.
//  Copyright © 2020 Leonidas. All rights reserved.
//

#import "LYWindow.h"

@implementation LYWindow

- (void)mouseDragged:(NSEvent *)event {
    [super mouseDragged:event];
    
    [self performWindowDragWithEvent:event];
    
}

@end
