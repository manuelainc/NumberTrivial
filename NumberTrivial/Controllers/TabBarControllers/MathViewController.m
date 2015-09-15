//
//  MathViewController.m
//  NumberTrivial
//
//  Created by Sherpa on 13/9/15.
//  Copyright (c) 2015 manuelainc. All rights reserved.
//

#import "MathViewController.h"
#import "NumbersApiCommunicator.h"

@interface MathViewController ()
@property (strong, nonatomic) IBOutlet UIButton *randomButton;
@property ( strong, nonatomic) NumbersApiCommunicator *api;

@property (strong, nonatomic) IBOutlet UITextField *numberField;
@property (strong, nonatomic) IBOutlet UILabel *doneLabel;
@property (strong, nonatomic) IBOutlet UITextView *resultTextView;

@end

@implementation MathViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _api = [[NumbersApiCommunicator alloc] init];
    
    _doneLabel.hidden = YES;
    _resultTextView.hidden = NO;
    [_resultTextView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];

    
  }

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
    [_resultTextView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];

    if ([[UIScreen mainScreen] bounds].size.height < 568){
        [_resultTextView setFont:[UIFont fontWithName:_resultTextView.font.fontName size:20]];
    }else{
        [_resultTextView setFont:[UIFont fontWithName:_resultTextView.font.fontName size:30]];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    _doneLabel.hidden = YES;
    _resultTextView.hidden = NO;
    _numberField.placeholder = @"Number";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
    [self.view endEditing:YES];
    _numberField.placeholder = @"Number";
    
    if (![_numberField.text isEqualToString:@""]) {
        NSString *numbString = [NSString stringWithFormat:@"%@", _numberField.text];
        
        NSDictionary *dict = [_api getDictionaryWithParameter:numbString
                                                 withCategory:@"math"
                                                     isRandom:NO];
        _resultTextView.text = [dict valueForKey:@"text"];
        _numberField.text = [NSString stringWithFormat:@"%@", [dict valueForKey:@"number"]];
        _doneLabel.hidden = YES;
        _resultTextView.hidden = NO;
        [_numberField setFont:[UIFont fontWithName:_numberField.font.fontName size:40]];

    }
    
    
    //cambiar vista para mostrar
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _numberField.placeholder = @"";
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [_numberField setFont:[UIFont fontWithName:_numberField.font.fontName size:80]];
        [_numberField sizeToFit];
    }
    [_numberField setFont:[UIFont fontWithName:_numberField.font.fontName size:40]];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (![string isEqualToString:@""]) {
        _doneLabel.hidden = NO;
        _resultTextView.hidden = YES;
        _doneLabel.adjustsFontSizeToFitWidth = YES;
        
    }else{
        _doneLabel.hidden = YES;
        _resultTextView.hidden = NO;
    }
    return YES;
}

- (IBAction)pushRandomButton:(id)sender {
    

    NSDictionary *jsonDictionary = [_api getDictionaryWithParameter:@"" withCategory:@"math" isRandom:YES];
    _resultTextView.text = [jsonDictionary valueForKey:@"text"];
    _numberField.text = [NSString stringWithFormat:@"%@", [jsonDictionary valueForKey:@"number"]];
 
    NSLog(@"random\n%@",jsonDictionary);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UITextView *txtview = object;
    CGFloat topoffset = ([txtview bounds].size.height - [txtview contentSize].height * [txtview zoomScale])/2.0;
    topoffset = ( topoffset < 0.0 ? 0.0 : topoffset );
    txtview.contentOffset = (CGPoint){.x = 0, .y = -topoffset};
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
