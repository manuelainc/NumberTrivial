//
//  DateViewController.m
//  NumberTrivial
//
//  Created by Sherpa on 13/9/15.
//  Copyright (c) 2015 manuelainc. All rights reserved.
//

#import "DateViewController.h"
#import "NumbersApiCommunicator.h"

@interface DateViewController ()
@property (strong, nonatomic) IBOutlet UIButton *randomButton;
@property ( strong, nonatomic) NumbersApiCommunicator *api;

@property (strong, nonatomic) IBOutlet UITextField *monthField;
@property (strong, nonatomic) IBOutlet UITextField *dayField;
@property (strong, nonatomic) IBOutlet UILabel *doneLabel;
@property (strong, nonatomic) IBOutlet UITextView *resultTextView;
@property (strong, nonatomic) NSArray *monthNames;
@property (strong, nonatomic) NSArray *daysPerMonth;

@property (strong, nonatomic) UIPickerView *pickerView;


@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _monthNames = @[@"", @"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    
    _api = [[NumbersApiCommunicator alloc] init];
    
    _doneLabel.hidden = YES;
    _resultTextView.hidden = NO;
    
    [_resultTextView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
 
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _monthField.inputView = _pickerView;
    _pickerView.showsSelectionIndicator = YES;
    
    if ([[UIScreen mainScreen] bounds].size.height < 568){
        [_resultTextView setFont:[UIFont fontWithName:_resultTextView.font.fontName size:20]];
    }else{
        [_resultTextView setFont:[UIFont fontWithName:_resultTextView.font.fontName size:30]];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [_resultTextView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return _monthNames.count;
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return _monthNames[row];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _monthField.text = _monthNames[row];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.monthField.inputView;
    self.monthField.text = [NSString stringWithFormat:@"%@", picker.date];
}

//- (void)viewDidAppear:(BOOL)animated{
//
//
//}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    _doneLabel.hidden = YES;
    _resultTextView.hidden = NO;
    _monthField.placeholder = @"Month";
    _dayField.placeholder = @"Day";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    _monthField.placeholder = @"Month";
    _dayField.placeholder = @"Day";
    
    if (!([_monthField.text isEqualToString:@""] && [_dayField.text isEqualToString:@""])) {
        NSString *dayString = [NSString stringWithFormat:@"%@", _dayField.text];
        NSString *monthString = [NSString stringWithFormat:@"%ld", (long)[self getNumberWithMonth:_monthField.text]];
        
        
        NSString *dateString = [NSString stringWithFormat:@"%@/%@", monthString, dayString];
        
        NSDictionary *dict = [_api getDictionaryWithParameter:dateString
                                                 withCategory:@"date"
                                                     isRandom:NO];
        NSLog(@"%@",dict);

        _resultTextView.text = [dict valueForKey:@"text"];
        NSArray *myArray = [[dict valueForKey:@"text"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        
        _monthField.text = myArray[0];
        _dayField.text = myArray[1];
        _doneLabel.hidden = YES;
        _resultTextView.hidden = NO;
        
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _monthField.placeholder = @"";
    
    [_monthField setFont:[UIFont fontWithName:_monthField.font.fontName size:40]];
    [_dayField setFont:[UIFont fontWithName:_dayField.font.fontName size:40]];

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
    
    
    NSDictionary *jsonDictionary = [_api getDictionaryWithParameter:@"" withCategory:@"date" isRandom:YES];
    _resultTextView.text = [jsonDictionary valueForKey:@"text"];
    NSArray *myArray = [[jsonDictionary valueForKey:@"text"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];

    _monthField.text = myArray[0];
    _dayField.text = myArray[1];
    
    
//    _monthField.text = [jsonDictionary valueForKey:@"number"];
//    _dayField.text = [jsonDictionary valueForKey:@"text"];
    
    if ([[UIScreen mainScreen] bounds].size.height < 568){
        [_resultTextView setFont:[UIFont fontWithName:_resultTextView.font.fontName size:20]];
    }else{
        [_resultTextView setFont:[UIFont fontWithName:_resultTextView.font.fontName size:30]];
    }
    NSLog(@"random\n%@",jsonDictionary);
}

//Text view align center
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UITextView *txtview = object;
    CGFloat topoffset = ([txtview bounds].size.height - [txtview contentSize].height * [txtview zoomScale])/2.0;
    topoffset = ( topoffset < 0.0 ? 0.0 : topoffset );
    txtview.contentOffset = (CGPoint){.x = 0, .y = -topoffset};
}

-(NSInteger)getNumberWithMonth:(NSString*)monthString{
    
    if ([monthString isEqualToString:@"January"]) {
        return 1;
    }else if ([monthString isEqualToString:@"February"]){
        return 2;
    }else if ([monthString isEqualToString:@"March"]){
        return 3;
    }else if ([monthString isEqualToString:@"April"]){
        return 4;
    }else if ([monthString isEqualToString:@"May"]){
        return 5;
    }else if ([monthString isEqualToString:@"June"]){
        return 6;
    }else if ([monthString isEqualToString:@"July"]){
        return 7;
    }else if ([monthString isEqualToString:@"August"]){
        return 8;
    }else if ([monthString isEqualToString:@"September"]){
        return 9;
    }else if ([monthString isEqualToString:@"October"]){
        return 10;
    }else if ([monthString isEqualToString:@"November"]){
        return 11;
    }else if ([monthString isEqualToString:@"December"]){
        return 12;
    }
    
    return 0;
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
