//
//  FireEditCtr.m
//  FireCenter
//
//  Created by gaochao on 16/10/7.
//  Copyright © 2016年 gaochao. All rights reserved.


#import "FireEditCtr.h"

#import "SourceItem.h"

@interface FireEditCtr ()  <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField * nameField;

@property (nonatomic) SourceItem * item;

@end

@implementation FireEditCtr

-(instancetype)initWithSourceItem:(SourceItem *) item {
    self = [super init];
    
    self.item = item;
    
    self.navigationItem.title = @"edit page";
    
    return self;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.nameField.text = [self.item getDesc];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.item setDescription:self.nameField.text];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameField.delegate = self;
    self.nameField.returnKeyType = UIReturnKeyDone;
    [self.nameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.nameField resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
    return true;
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
