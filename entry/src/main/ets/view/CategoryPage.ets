import goodsViewModel, { GoodsDataModel, NavTitleModel } from "../viewmodel/LinkDataModel";

@Builder
export function CategoryPageBuilder() {
  CategoryPage()
}

@Component
struct CategoryPage {
  @State requestSuccess: boolean = false;
  @State isSelected: boolean = false;
  @State currentTitleId: number = 0;
  private categoryList: NavTitleModel[] = [];
  private navTitleScroller: Scroller = new Scroller();
  private goodsListScroller: Scroller = new Scroller();

  aboutToAppear() {
    // loading data
    setTimeout(() => {
      this.categoryList = goodsViewModel.getLinkData();
      this.requestSuccess = true;
    }, 1500)
  }

  // 左侧列表
  @Builder
  titleListBuilder(title: string, index: number) {
    Text(title)
      .width('100%')
      .height(56)
      .fontSize(14)
      .textAlign(TextAlign.Center)
      .fontColor(this.currentTitleId === index ? '#A2B6D6' : Color.Black)
      .backgroundColor(this.currentTitleId === index ? '#F1F3F5' : '#E6E9EB')
      .fontWeight(this.currentTitleId === index ? FontWeight.Bold : FontWeight.Normal)
      .onClick(() => {
        // 传入当前列表项index和true
        this.listChange(index, true);
      })
  }

  // 右侧列表header
  @Builder
  goodsHeaderBuilder(headerName: string) {
    Row() {
      Text(headerName)
        .fontSize(18)
        .fontColor('#182431')
        .fontWeight(500)
    }
    .width('100%')
    .height(56)
    .padding({ left: 8 })
    .backgroundColor('#F1F3F5')
  }

  // 右侧列表内容
  @Builder
  goodsListBuilder(item: GoodsDataModel) {
    Row() {
      Image(item.imgUrl)
        .height('100%')
        .aspectRatio(1) // 设置组件宽高比为1
      Column() {
        Text(item.goodsName)
          .width('100%')
          .fontSize(14)
          .fontColor('#182431')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Clip })
          .lineHeight(20)
        Text('￥' + item.price)
          .fontSize(18)
          .fontColor('#FA2A2D')
      }
      .height('100%')
      .padding(12)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .clip(true)
    .width('100%')
    .height(96)
    .backgroundColor('#FFFFFF')
    .borderRadius(18)
  }

  // 列表滑动事件
  listChange(index: number, isGoods: boolean) {
    if (this.currentTitleId !== index) {
      this.currentTitleId = index;
      if (isGoods) {
        // isGoods为true，控制右侧列表数据滑动到指定index
        this.goodsListScroller.scrollToIndex(index);
      } else {
        // isGoods为false，控制左侧列表数据滑动到指定index
        this.navTitleScroller.scrollToIndex(index);
      }
    }
  }

  build() {
    NavDestination() {
      Row() {
        if (this.requestSuccess) {
          // 左侧列表数据展示
          List({ scroller: this.navTitleScroller }) {
            ForEach(this.categoryList, (item: NavTitleModel, index: number) => {
              ListItem() {
                this.titleListBuilder(item.titleName, index)
              }
            }, (item: NavTitleModel) => item.titleName)
          }
          .width(100)
          .height('100%')
          .backgroundColor('#E6E9EB')
          .scrollBar(BarState.Off)

          // 右侧列表内容展示
          List({ scroller: this.goodsListScroller }) {
            ForEach(this.categoryList, (item: NavTitleModel) => {
              ListItemGroup({ space: 12, header: this.goodsHeaderBuilder(item.titleName) }) {
                ForEach(item.goodsList, (goodsItem: GoodsDataModel) => {
                  ListItem() {
                    this.goodsListBuilder(goodsItem);
                  }
                }, (goodsItem: GoodsDataModel) => JSON.stringify(goodsItem.goodsId))
              }
            }, (item: NavTitleModel) => JSON.stringify(item.goodsList))
          }
          .width('100%')
          .height('100%')
          .padding({ left: 8, right: 12, bottom: 12 })
          .sticky(StickyStyle.Header)
          .layoutWeight(1)
          .edgeEffect(EdgeEffect.None)
          .onScrollIndex((index: number) => {
            // 传入当前列表项index和false
            this.listChange(index, false)
          })
        } else {
          LoadingProgress()
            .size({ width: 24, height: 24 })
          Text($r('app.string.loading_data'))
        }
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignSelf(ItemAlign.Center)
      .backgroundColor('#F1F3F5')
    }
    .hideTitleBar(true)
  }
}