//
//  ViewController.m


#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{

    pdfView.delegate=self;
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(IBAction)createPDF:(id)sender
{
    
    NSString *html = @"<b>Hello <i>World!</i></b>";
    UIMarkupTextPrintFormatter *fmt = [[UIMarkupTextPrintFormatter alloc] 
                                       initWithMarkupText:html];
    UIPrintPageRenderer *render = [[UIPrintPageRenderer alloc] init];
    [render addPrintFormatter:fmt startingAtPageAtIndex:0];
    CGRect page;
    page.origin.x=0;
    page.origin.y=0;
    page.size.width=792;
    page.size.height=612;
    
    
    CGRect printable=CGRectInset( page, 0, 0 );
    [render setValue:[NSValue valueWithCGRect:page] forKey:@"paperRect"];
    [render setValue:[NSValue valueWithCGRect:printable] forKey:@"printableRect"];
    
    NSLog(@"number of pages %d",[render numberOfPages]);
    
    NSMutableData * pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData( pdfData, CGRectZero, nil );
    
    for (NSInteger i=0; i < [render numberOfPages]; i++)
    {
        UIGraphicsBeginPDFPage();
        CGRect bounds = UIGraphicsGetPDFContextBounds();
        [render drawPageAtIndex:i inRect:bounds];
        
    }
    
    UIGraphicsEndPDFContext();
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * pdfFile = [[documentsDirectory stringByAppendingPathComponent:@"test.pdf"] retain];
    [pdfData writeToFile:pdfFile atomically:YES];
    NSURL * url=[NSURL fileURLWithPath:pdfFile];
    NSURLRequest * request=[[NSURLRequest alloc] initWithURL:url];
    [pdfView loadRequest:request];

}
#pragma mark UIWebViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView *)thisWebView
{
	
}

- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
{
    
	
	
}
-(void) webView:(UIWebView *)thisWebView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error %@ ",error.description);
}
@end
