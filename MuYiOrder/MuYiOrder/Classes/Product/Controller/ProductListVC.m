//
//  ProductListVC.m
//  MuYiOrder
//
//  Created by Apple on 2017/4/25.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "ProductListVC.h"
#import "ProductDetailVC.h"
#import "ProductCVCell.h"
#import "CZDeviceTool.h"

static NSString *kProductCVCell = @"ProductCVCell";

@interface ProductListVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ProductListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"百宝箱";
    [self setupNavItem];
    [self registerCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Setup
/** 设置导航栏上按钮 */
- (void)setupNavItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_pressed"] style:UIBarButtonItemStylePlain target:self action:@selector(addNewProduct)];
}

- (void)registerCell {
    [self.collectionView registerNib:[UINib nibWithNibName:kProductCVCell bundle:nil] forCellWithReuseIdentifier:kProductCVCell];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProductCVCell forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = ([CZDeviceTool screenWidth] - 8.0 * 4) / 3;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(4.0, 4.0, 4.0, 4.0);
}

#pragma mark - Action
/** 添加新产品 */
- (void)addNewProduct {
    ProductDetailVC *vc = [[UIStoryboard storyboardWithName:@"Product" bundle:nil] instantiateViewControllerWithIdentifier:@"ProductDetailVC"];
    [self pushForTabbarVc:vc];
}

@end
