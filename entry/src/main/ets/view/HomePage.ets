interface SwiperType {
  pic: string,
  title: string
}

@Builder
export function HomePageBuilder() {
  HomePage()
}

@Component
struct HomePage {
  @State noMoreData: boolean = false;
  @State isRefreshing: boolean = false; // 是否正在刷新
  @State productArray: string[] = ['景区1', '景区2', '景区3', '景区4', '景区5'];
  private borderRadiusVal = 6;
  private swiperContent: SwiperType[] = [
    { pic: 'app.media.pic1', title: 'picture1' },
    { pic: 'app.media.pic2', title: 'picture2' },
    { pic: 'app.media.pic3', title: 'picture3' },
    { pic: 'app.media.pic4', title: 'picture4' }
  ];
  private productTitle: string[] = ['热门景区', '景区推荐', '小众景区'];
  private gridTitle: string[] =
    ['门票', '城市推荐', '自然风光', '动植物园', '主题乐园', '名胜古迹', '特产', '其它服务'];

  // 搜索框
  @Builder
  searchBuilder() {
    Row() {
      Text('北京')
        .width(50)
        .height(40)
        .fontSize(14)
      TextInput()
        .width('100%')
        .height(40)
        .layoutWeight(1)
      Blank()
        .width(15)
      Text('更多')
        .width(40)
        .height(40)
        .fontSize(14)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.Transparent)
    .padding({ left: 15, right: 15 })
  }

  // 轮播图
  @Builder
  bannerBuilder() {
    Swiper() {
      ForEach(this.swiperContent, (item: SwiperType) => {
        Stack({ alignContent: Alignment.BottomStart }) {
          Image($r(item.pic))
          // .objectFit(ImageFit.Cover)
          Text(item.title)
            .width('100%')
            .height(30)
            .fontSize(12)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)
          // .backgroundColor(0x1F000000)
        }
      }, (item: SwiperType) => JSON.stringify(item))
    }
    .width('100%')
    .height(200)
    .loop(true)
    .autoPlay(true)
    .duration(1000)
    .interval(2000)
    .curve(Curve.Linear)
    .displayArrow(false)
    .indicator(false)
    .itemSpace(10)
    .borderRadius(this.borderRadiusVal)
  }

  // 网格内容
  @Builder
  gridBuilder() {
    Grid() {
      ForEach(this.gridTitle, (item: string) => {
        GridItem() {
          Column() {
            Image($r('app.media.pic1'))
              .objectFit(ImageFit.Fill)
              .borderRadius(this.borderRadiusVal)
            Text(item)
              .fontSize(14)
              .padding({ top: 4 })
          }
        }
      }, (item: string) => item)
    }
    .width('100%')
    .rowsGap(10)
    .columnsGap(10)
    .margin({ top: 12, bottom: 12 })
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .borderRadius(this.borderRadiusVal)
  }

  // 自定义展示区域
  @Builder
  displayBuilder() {
    Row() {
      Image($r('app.media.pic1'))
        .width('49%')
        .height('100%')
        .borderRadius(this.borderRadiusVal)
      Image($r('app.media.pic1'))
        .width('49%')
        .height('100%')
        .borderRadius(this.borderRadiusVal)
    }
    .width('100%')
    .height(120)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  // 商品列表标题
  @Builder
  productHeader(title: string) {
    Column() {
      Text(title)
        .width('100%')
        .height(50)
        .backgroundColor('#eeeeee')
        .padding({ left: 12 })
    }
  }

  // 商品列表内容详情
  @Builder
  productDetailBuilder(title: string) {
    Column() {
      Image($r('app.media.pic1'))
        .padding({ top: 12, bottom: 12 })
        .borderRadius(this.borderRadiusVal)
      Column() {
        Text(title)
          .fontWeight(FontWeight.Bold)
        Text() {
          Span('多人组团特惠：')
            .fontSize(14)
            .fontColor(Color.Gray)
          Span('999￥')
            .fontSize(16)
            .fontColor(Color.Red)
        }
        .margin({ top: 12, bottom: 12 })

        Text() {
          Span('单人票价：')
          Span('1999￥')
        }
        .fontSize(14)
        .fontColor(Color.Gray)
        .margin({ bottom: 12 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
  }

  // 商品列表
  @Builder
  productListBuilder() {
    ForEach(this.productTitle, (item: string, index: number) => {
      ListItemGroup({ header: this.productHeader(item) }) {
        ForEach(this.productArray, (productItem: string) => {
          ListItem() {
            this.productDetailBuilder(productItem);
          }
        }, (productItem: string) => productItem)
        // if (index === 2) {
        //   ForEach(this.productArray, (productItem: string) => {
        //     ListItem() {
        //       this.productHeader(productItem);
        //     }
        //   }, (productItem: string) => productItem)
        // } else {
        //   ForEach(this.productArray, (productItem: string) => {
        //     ListItem() {
        //       this.productHeader(productItem);
        //     }
        //   }, (productItem: string) => productItem)
        // }
      }
      .divider({
        strokeWidth: 1,
        color: '#EEEEEE'
      })
      .borderRadius(this.borderRadiusVal)
    }, (item: string) => item)
  }

  // 自定义上滑加载更多
  @Builder
  loadingDataBuilder() {
    Row() {
      if (!this.noMoreData) {
        LoadingProgress()
          .height('50%')
      }
      Text(this.noMoreData ? '已经到底啦' : '正在加载更多...')
    }
    .justifyContent(FlexAlign.Center)
  }

  build() {
    NavDestination() {
      Column() {
        // 顶部搜索框
        this.searchBuilder();
        // 下拉刷新组件
        Refresh({ refreshing: $$this.isRefreshing }) {
          // List作为长列表布局
          List({ space: 10 }) {
            // Swiper轮播图模块
            ListItem() {
              this.bannerBuilder();
            }

            // Grid网格模块
            ListItem() {
              this.gridBuilder();
            }

            // 自定义展示区域
            ListItem() {
              this.displayBuilder();
            }

            // 商品分类列表
            this.productListBuilder();

            // 自定义触底加载更多
            ListItem() {
              this.loadingDataBuilder();
            }
            .width('100%')
            .height(50)
            .borderRadius('50%')
            .backgroundColor('#EEEEEE')
          }
          .width('100%')
          .height('calc(100% - 60vp)')
          .sticky(StickyStyle.Header) // 粘性标题
          .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true }) // 设置并开启边缘滑动效果
          .layoutWeight(2) // 设置组件的布局权重
          // List组件触底模拟网络请求
          .onReachEnd(() => {
            if (this.productArray.length >= 20) {
              this.noMoreData = true;
              return;
            }
            setTimeout(() => {
              this.productArray.push('景区' + (this.productArray.length + 1));
            }, 2000)
          })
        }
        // 下拉刷新，模拟网络请求
        .onRefreshing(() => {
          setTimeout(() => {
            this.productArray = ['景区1', '景区2', '景区3', '景区4', '景区5'];
            this.noMoreData = false;
            this.isRefreshing = !this.isRefreshing;
          }, 2000)
        })
      }
      .width('95%')
    }
    .hideTitleBar(true)
    .onWillHide(() => {
      this.productArray = ['景区1', '景区2', '景区3', '景区4', '景区5'];
    })
  }
}