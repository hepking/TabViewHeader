//
//  MainTabViewController.m
//  TabViewHeader
//

#define HeadImgHeight 180
#define Width [UIScreen mainScreen].bounds.size.width

#import "MainTabViewController.h"

@interface MainTabViewController ()

@property (strong, nonatomic) UIImageView *HeadImgView; //!< 头部图像
@property (strong, nonatomic) UIView *headerView;
@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.HeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, HeadImgHeight)];
    self.HeadImgView.image = [UIImage imageNamed:@"eee"];
    
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, HeadImgHeight + 60)];
    [self.headerView addSubview:self.HeadImgView];
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, HeadImgHeight, Width, 50)];
    tmpView.backgroundColor = [UIColor redColor];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width/2, 50)];
    label1.text = @"喜欢";
    label1.textAlignment = NSTextAlignmentCenter;
    [tmpView addSubview:label1];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(Width/2, 0, Width/2, 50)];
    label2.text = @"分享";
    label2.textAlignment = NSTextAlignmentCenter;
    [tmpView addSubview:label2];
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, HeadImgHeight + 50, Width, 10)];
    spaceView.backgroundColor = [UIColor greenColor];
    [self.headerView addSubview:spaceView];
    [self.headerView addSubview:tmpView];
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeadImgHeight + 60;
}

/**
 *  重写这个代理方法就行了，利用contentOffset这个属性改变frame
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat sectionHeaderHeight = HeadImgHeight;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
    if (offsetY < 0) {
        self.HeadImgView.frame = CGRectMake(offsetY/2, offsetY, Width - offsetY, HeadImgHeight - offsetY);  // 修改头部的frame值就行了
    }

}

#pragma mark
#pragma mark - TableViewCell 代理方法
// 每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 18;
}

// cell定制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%d行",(int)indexPath.row];
    return cell;
}

// 选中每一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
