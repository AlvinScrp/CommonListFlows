import { CustomListItem } from "./CustomListItem";

@Builder
export function ManagerPageBuilder() {
  ManagerPage()
}

@Preview
@Component
struct ManagerPage {
  @State searchVal: string = '';
  @State currentTabIndex: number = 0;
  private currentIndex: number = 0;
  private listScroller: Scroller = new Scroller();
  private scrollController: Scroller = new Scroller();
  private tabsController: TabsController = new TabsController();
  private contentTabController: TabsController = new TabsController();
  private searchController: SearchController = new SearchController();
  private tabArray: string[] = ['关注', '推荐', '热搜', '更多'];

  // 更多投资内容builder
  @Builder
  moreContentBuilder(value: string) {
    Row() {
      Image($r('app.media.app_icon'))
        .width(28)
        .height(28)
        .opacity(0.6)
      Text(value)
        .fontSize(16)
        .margin({ left: 15 })
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .height(56)
    .padding({ left: 12, right: 12 })
  }

  // 内容中的自定义Tab
  @Builder
  myTabBuilder(title: string, index: number) {
    Row({ space: 16 }) {
      Text(title)
        .width(500)
        .fontSize(this.currentTabIndex === index ? 20 : 18)
        .fontColor(this.currentTabIndex === index ? '#66BEFF' : Color.Black)
    }
    .width(60)
    .height(40)
    .padding({ left: 12 })
    .onClick(() => {
      // 点击切换tabs内容
      this.contentTabController.changeIndex(index);
      this.currentTabIndex = index;
    })
  }

  build() {
    NavDestination() {
      Column() {
        Tabs({ barPosition: BarPosition.End, index: this.currentIndex, controller: this.tabsController }) {
          TabContent() {
            Stack({ alignContent: Alignment.Top }) {
              // 首页页面内容
              Scroll(this.scrollController) {
                Column() {
                  // 更多投资
                  Column() {
                    Text('更多投资')
                      .width('100%')
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .padding(12)
                      .textAlign(TextAlign.Start)
                    List() {
                      ListItem() {
                        this.moreContentBuilder('期货')
                      }

                      ListItem() {
                        this.moreContentBuilder('基金')
                      }

                      ListItem() {
                        this.moreContentBuilder('保险')
                      }
                    }
                    .width('100%')
                    .borderRadius(18)
                    .backgroundColor(Color.White)
                    .divider({
                      strokeWidth: 1,
                      color: '#E5E5E5',
                      startMargin: 55,
                      endMargin: 16
                    })
                  }

                  Column() {
                    // 自定义Tabbar
                    Row() {
                      ForEach(this.tabArray, (item: string, index: number) => {
                        this.myTabBuilder(item, index);
                      }, (item: string) => item)
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.Start)

                    // Tabs
                    Tabs({ barPosition: BarPosition.Start, controller: this.contentTabController }) {
                      TabContent() {
                        List({ space: 10, scroller: this.listScroller }) {
                          CustomListItem({
                            imgUrl: $r('app.media.pic1'),
                            title: $r('app.string.manager_content')
                          })
                          CustomListItem({
                            imgUrl: $r('app.media.pic2'),
                            title: $r('app.string.manager_content')
                          })
                          CustomListItem({
                            imgUrl: $r('app.media.pic3'),
                            title: $r('app.string.manager_content')
                          })
                          CustomListItem({
                            imgUrl: $r('app.media.pic4'),
                            title: $r('app.string.manager_content')
                          })
                        }
                        .width('100%')
                        .height('100%')
                        .scrollBar(BarState.Off)
                        .edgeEffect(EdgeEffect.None)
                        // 自定义tabbar通过原生属性配合calc计算高度实现吸顶
                        .nestedScroll({
                          scrollForward: NestedScrollMode.PARENT_FIRST,
                          scrollBackward: NestedScrollMode.SELF_FIRST
                        })
                      }
                      .tabBar('关注')

                      TabContent() {
                        Text('推荐的内容')
                      }
                      .tabBar('推荐')

                      TabContent() {
                        Text('热搜的内容')
                      }
                      .tabBar('热搜')

                      TabContent() {
                        Text('更多的内容')
                      }
                      .tabBar('更多')
                    }
                    .width('100%')
                    .height('100%')
                    .barHeight(0)
                    .onChange((index: number) => {
                      this.currentTabIndex = index;
                    })
                  }
                  .margin({ top: 12 })
                  .height('calc(100% - 65vp)')
                  .backgroundColor('#F1F3F5')
                }
              }
              .width('100%')
              .height('100%')
              .margin({ top: 65 })
              .scrollBar(BarState.Off)

              // 顶部输入框
              Row() {
                Image($r('app.media.app_icon'))
                  .width(30)
                  .height(30)
                  .margin({ right: 10 })
                Search({ value: this.searchVal, placeholder: '猜你想搜...', controller: this.searchController })
                  .searchButton('搜索', { fontSize: 14 })
                  .width('75%')
                  .height(40)
                  .textFont({ size: 14 })
                  .placeholderFont({ size: 14 })
                  .backgroundColor('#F5F5F5')
                  .placeholderColor(Color.Gray)
                Image($r('app.media.app_icon'))
                  .width(30)
                  .height(30)
                  .margin({ left: 10 })
              }
              .width('100%')
              .height(65)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#E5E5E5')
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#DCDCDC')
          }
          .tabBar('首页')

          TabContent() {
            Text('理财页面')
          }
          .tabBar('理财')

          TabContent() {
            Text('交易页面')
          }
          .tabBar('交易')

          TabContent() {
            Text('消息页面')
          }
          .tabBar('消息')

          TabContent() {
            Text('我的页面')
          }
          .tabBar('我的')
        }
        .barHeight(56)
        .vertical(false)
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          this.currentIndex = index;
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
    }
    .hideTitleBar(true)
  }
}