//
//  CenterController.m
//  FireCenter
//
//  Created by gaochao on 16/10/4.
//  Copyright © 2016年 gaochao. All rights reserved.
//

#import "CenterController.h"
#import "SourceItem.h"
#import "CenterDataSource.h"
#import "FireEditCtr.h"

@interface CenterController ()

@property (nonatomic,strong) IBOutlet UIView * headerView;

@end

@implementation CenterController

-(IBAction)addItem:(id)sender {
    NSLog(@"%@", @"add");
    
    SourceItem * item = [[CenterDataSource shareStore] createItem:@"-new"];
    
    NSInteger idx = [[[CenterDataSource shareStore] allItems] indexOfObject:item];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

-(IBAction)toogleEdit:(id)sender {
    NSLog(@"%@", @"edit");
    if (self.isEditing) {
//        UIButton * btn = sender;
        
//        [btn setTitle:@"edit" forState:UIControlStateNormal];
        [self setEditing:false animated:true];
    } else {
//        UIButton * btn = sender;
        
//        [btn setTitle:@"ok" forState:UIControlStateNormal];
        [self setEditing:true animated:true];
    }
}

- (void)viewDidLoad {
//    self.view = self.tableView;
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"home page";
        
    UIBarButtonItem * addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    
    self.navigationItem.rightBarButtonItem = addItem;
    
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    for (int i=0; i<2; i++) {
        CenterDataSource *source = [CenterDataSource shareStore];
        
        [source createItem:[[NSString alloc] initWithFormat:@"%d",i]];
    }
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"sourceItem"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SourceItem * item = [[CenterDataSource shareStore] allItems][indexPath.row];
    
    
    FireEditCtr * fireItemEditCtr = [[FireEditCtr alloc] initWithSourceItem:item];
    
    [self.navigationController pushViewController:fireItemEditCtr animated:true];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
//    if (section == 0) {
        return [[[CenterDataSource shareStore] allItems] count] + 1;
//    } else {
//        return ([[[CenterDataSource shareStore] allItems] count] / 2) + 1;
//    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = indexPath.row;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        SourceItem * item = [[CenterDataSource shareStore] allItems][idx];
        
        [[CenterDataSource shareStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//这个方法用来告诉表格 这一行是否可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row + 1 > [[[CenterDataSource shareStore] allItems] count]) {
        return NO;
    } else {
        return YES;
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row + 1 > [[[CenterDataSource shareStore] allItems] count]) {
        return NO;
    } else {
        return YES;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sourceItem" forIndexPath:indexPath];
    
    NSArray * arr = [[CenterDataSource shareStore] allItems];
    
    int idx = indexPath.row;
    
    if (idx + 1 <= [arr count]) {
        SourceItem *sourceItem = arr[idx];
        
        cell.textLabel.text = [sourceItem getDesc];
        [cell.textLabel setTextColor:[UIColor redColor]];
    } else {
        cell.userInteractionEnabled = NO;
        cell.textLabel.text = @"no more items";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[CenterDataSource shareStore] moveItem:sourceIndexPath.row to:sourceIndexPath.row];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.row + 1 > [[[CenterDataSource shareStore] allItems] count]) {
       return sourceIndexPath;
    } else {
        return proposedDestinationIndexPath;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
