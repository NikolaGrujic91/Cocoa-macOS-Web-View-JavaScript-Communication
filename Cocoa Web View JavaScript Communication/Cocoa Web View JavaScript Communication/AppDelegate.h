//
//  AppDelegate.h
//  Cocoa Web View JavaScript Communication
//
//  Created by Nikola Grujic on 12/02/2020.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, WKScriptMessageHandler>
{
    WKWebView *webView;
}

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSView *view;

-(IBAction)webViewToJavaScript:(id)sender;

-(void)initializeWebView;
-(void)loadPage;

@end
