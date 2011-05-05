//
//  MyTableViewController.m
//  MyTable
//
//  Created by Shaokun Wu on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyTableViewController.h"

@implementation MyTableViewController

- (void)parserFinished:(NSArray *)resultArray {
    textView.text = [resultArray componentsJoinedByString:@"\n"];
    NSLog(@"%@ parsed %d elements", self.title, resultArray.count);
}

- (void)goNext {
    [self cancelParser];
    MyTableViewController *controller = [MyTableViewController new];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)startParser {
    [parser cancel];
    
    NSURL *url = [NSURL URLWithString:@"http://www.comptechdoc.org/independent/web/xml/guide/parts.xml"];
    parser = [[MyXMLParser alloc] initWithUrl:url];
    
    parser.delegate = self;
    [parser parse];
    NSLog(@"%@ start parsing...", self.title);
}

- (void)cancelParser {
    [parser cancel];
    [parser release];
    parser = nil;
    NSLog(@"%@ cancel parsing...", self.title);
}

- (void)dealloc
{
    parser.delegate = nil;
    [parser release];
    [nextButton release];
    [textView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(goNext)];
    
    self.navigationController.delegate = self;
    self.title = [NSString stringWithFormat:@"Level %d", [self.navigationController.viewControllers indexOfObject:self]];
}

- (void)viewDidUnload
{
    [nextButton release];
    nextButton = nil;
    [textView release];
    textView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickToNext:(id)sender {
    [self goNext];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self != viewController) {
        [self cancelParser];
    }

    MyTableViewController *controller = (MyTableViewController *)viewController;
    
    self.navigationController.delegate = nil;
    controller.navigationController.delegate = controller;
    
    [controller startParser];
}

@end
