//
//  AppDelegate.m
//  Cocoa Web View JavaScript Communication
//
//  Created by Nikola Grujic on 12/02/2020.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)awakeFromNib
{
    [self initializeWebView];
    [self loadPage];
}

-(void)initializeWebView
{
    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    [webViewConfiguration.userContentController addScriptMessageHandler:self name:@"interOp"];

    CGRect frame  = CGRectMake(0, 0, 440, 339);
    webView = [[WKWebView alloc] initWithFrame:frame configuration:webViewConfiguration];
    
    [_view addSubview:webView];
}

-(void)loadPage
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSDictionary *receivedData = (NSDictionary*)message.body;
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Message from JavaScript"];
    [alert setInformativeText:receivedData];
    [alert addButtonWithTitle:@"OK"];
    [alert setAlertStyle:NSAlertStyleInformational];
    
    [alert beginSheetModalForWindow:_window completionHandler:nil];
}

#pragma mark - Action methods

-(IBAction)webViewToJavaScript:(id)sender
{
    NSString *data = @"\"Hello from WKWebView!\"";
    NSString *callJavaScript = [NSString stringWithFormat:@"callJavaScriptFromNative(%@)", data];
    [webView evaluateJavaScript:callJavaScript completionHandler:^(NSString *result, NSError *error)
    {
        if (error != nil)
        {
            NSLog(@"Error %@",error);
        }

        if (result != nil)
        {
            NSLog(@"Result %@",result);
        }
    }];
}

@end
