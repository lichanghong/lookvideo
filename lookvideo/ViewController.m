//
//  ViewController.m
//  lookvideo
//
//  Created by 李长鸿 on 2019/3/31.
//  Copyright © 2019 李长鸿. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtView = [[NSTextView alloc]initWithFrame:NSMakeRect(0, 0 ,0, 0)];
    self.txtView.backgroundColor = [NSColor brownColor];
    self.txtView.textColor = [NSColor greenColor];
    [self.view addSubview:self.txtView];
 
    NSButton *btn2 = [NSButton buttonWithTitle:@"点击解析" target:self action:@selector(handleAction2:)];
    btn2.frame = NSMakeRect(0, 200,200, 50);    [self.view addSubview:btn2];

}
    
- (void)handleAction:(id)sender
    {
        NSString *str = self.txtView.string;
        if (str) {
           NSArray *p = [str componentsSeparatedByString:@"position="];
            NSString *last = [p lastObject];
           NSString *duration = [[last componentsSeparatedByString:@"\""] firstObject];
           NSString *time = [NSString stringWithFormat:@"position=%@",duration];
            NSString *result = [str stringByReplacingOccurrencesOfString:time withString:@"position=${t}"];
            NSString *shell = [NSString stringWithFormat:@"for i in `seq 1 20`;do ran=$[$[$i*60]+2083]; t=$ran.$((RANDOM%%165588+565588));%@;done",result];
            NSLog(@"%@",shell);
            system(shell.UTF8String);
//            system("~/bin/bash")
         }
    }
    - (void)handleAction2:(id)sender
    {
       
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        NSArray *types = [pasteboard types];
        if ([[pasteboard types] containsObject:NSPasteboardTypeString]) {
            // s 就是剪切板里的字符串, 如果你拷贝的是一个或多个的文件,文件夹, 这里就是文件或文件夹的名称
            NSString *s = [pasteboard stringForType:NSPasteboardTypeString];
            // do something
             self.txtView.string = s;
            [self handleAction:nil];
        }
    }
    


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
