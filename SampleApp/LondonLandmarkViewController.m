//
//  LondonLandmarkViewController.m
//  SampleApp
//
//  Created by kasturi gopal on 16/11/17.
//  Copyright © 2017 kasturi. All rights reserved.
//

#import "LondonLandmarkViewController.h"
#import "TableViewCell.h"
#import "DetailViewController.h"

@interface LondonLandmarkViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation LondonLandmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [[NSMutableArray alloc] init];
    
    [self convertLocalFile];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(65/255.0) green:(113/255.0) blue:(158/255.0) alpha:1];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
}

-(void) convertLocalFile {
    
    
    
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"LocalFile" ofType:@"json"];
    if (!jsonFilePath) {
        // ... do something ...
    }
    
    NSError *error = nil;
    NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:jsonFilePath];
    [inputStream open];
    id jsonObject = [NSJSONSerialization JSONObjectWithStream: inputStream
                                                      options:kNilOptions
                                                        error:&error];
    dataArray = [jsonObject valueForKey:@"results"];
}


# pragma mark - TableView DataSource and Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *cellIdentifier = @"cell";
    TableViewCell *cell = (TableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"imageName"];
    cell.cellImageView.image = [UIImage imageNamed:imageName];
    cell.mainTextLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"mainText"];
    cell.mainTextLabel.textColor = [UIColor colorWithRed:(65/255.0) green:(113/255.0) blue:(158/255.0) alpha:1];
    cell.subTextLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"subText"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *myCell = [tableView cellForRowAtIndexPath:indexPath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailVC.detailImage = myCell.cellImageView.image;
    detailVC.detailText = myCell.mainTextLabel.text;
    detailVC.detailSubText = myCell.subTextLabel.text;
    detailVC.textViewText = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"fullText"];
    detailVC.latitude = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"lat"];
    detailVC.longitude = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"lng"];
    
    [self.navigationController pushViewController:detailVC animated:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
