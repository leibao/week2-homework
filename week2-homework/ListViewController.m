//
//  ListViewController.m
//  week2-homework
//
//  Created by Lei Bao on 6/13/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = self.imageView.frame.size;
}

@end
