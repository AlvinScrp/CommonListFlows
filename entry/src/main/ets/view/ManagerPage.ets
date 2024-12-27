/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { CustomListItem } from "./CustomListItem";

@Builder
export function ManagerPageBuilder() {
  ManagerPage()
}

@Preview
@Component
struct ManagerPage {
  @State currentTabIndex: number = 0;
  @State currentIndex: number = 0;
  private borderRadiusVal = 16;
  private listScroller: Scroller = new Scroller();
  private scrollController: Scroller = new Scroller();
  private tabsController: TabsController = new TabsController();
  private contentTabController: TabsController = new TabsController();
  private tabArray: Resource[] =
    [$r('app.string.follow'), $r('app.string.hot_search'), $r('app.string.recommend'), $r('app.string.more')];

  // More investment content.
  @Builder
  moreContentBuilder(value: Resource) {
    Row() {
      Image($r('app.media.app_icon'))
        .width(28)
        .height(28)
        .opacity(0.6)
      Text(value)
        .fontSize(16)
        .padding({ left: 16 })
    }
    .width('100%')
    .padding(16)
  }

  // TabBar Builder
  @Builder
  tabBuilder(img: Resource, title: Resource, index: number) {
    Column() {
      Image(img)
        .width(20)
        .height(20)
        .fillColor(this.currentIndex === index ? '#0a59f7' : '#66000000')
      Text(title)
        .margin({ top: '4vp' })
        .fontSize(10)
        .fontWeight(500)
        .fontColor(this.currentIndex === index ? '#0a59f7' : '#66000000')
    }
    .justifyContent(FlexAlign.Center)
    .height('56vp')
    .width('100%')
    .onClick(() => {
      this.currentIndex = index;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  build() {
    NavDestination() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
        TabContent() {
          Stack({ alignContent: Alignment.Top }) {
            // Home page content.
            Scroll(this.scrollController) {
              Column() {
                // More investment content.
                Column() {
                  Text($r('app.string.more_investment'))
                    .width('100%')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .textAlign(TextAlign.Start)
                    .margin({ bottom: 12 })
                  List() {
                    ListItem() {
                      this.moreContentBuilder($r('app.string.futures_trading'))
                    }

                    ListItem() {
                      this.moreContentBuilder($r('app.string.foundation'))
                    }

                    ListItem() {
                      this.moreContentBuilder($r('app.string.insurance'))
                    }
                  }
                  .width('100%')
                  .borderRadius(this.borderRadiusVal)
                  .backgroundColor(Color.White)
                  .divider({
                    strokeWidth: 1,
                    color: '#D9D9D9',
                    startMargin: 60,
                    endMargin: 16
                  })
                }

                Column() {
                  // Customize tabBar.
                  Row({ space: 16 }) {
                    ForEach(this.tabArray, (item: string, index: number) => {
                      Text(item)
                        .fontColor(this.currentTabIndex === index ? '#0a59f7' : Color.Black)
                        .onClick(() => {
                          // Click to switch tabs content.
                          this.contentTabController.changeIndex(index);
                          this.currentTabIndex = index;
                        })
                    }, (item: string) => item)
                  }
                  .width('100%')
                  .height(40)
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
                      // Customize the tabbar to achieve ceiling suction by combining the nestdScroll attribute with Calc to calculate height.
                      .nestedScroll({
                        scrollForward: NestedScrollMode.PARENT_FIRST,
                        scrollBackward: NestedScrollMode.SELF_FIRST
                      })
                    }
                    .tabBar($r('app.string.follow'))

                    TabContent() {
                      Text($r('app.string.recommend_content'))
                    }
                    .tabBar($r('app.string.recommend'))

                    TabContent() {
                      Text($r('app.string.hot_search_content'))
                    }
                    .tabBar($r('app.string.hot_search'))

                    TabContent() {
                      Text($r('app.string.more_content'))
                    }
                    .tabBar($r('app.string.more'))
                  }
                  .barHeight(0)
                  .height('calc(100% - 92vp)')
                  .onChange((index: number) => {
                    this.currentTabIndex = index;
                  })
                }
                .margin({ top: 12 })
                .backgroundColor('#F1F3F5')
              }
            }
            .width('100%')
            .height('100%')
            .margin({ top: 65 })
            .scrollBar(BarState.Off)

            // Top input box.
            Row() {
              Image($r('app.media.app_icon'))
                .width(30)
                .height(30)
              Search({
                placeholder: $r('app.string.want_search'),
              })
                .searchButton(getContext(this).resourceManager.getStringSync($r('app.string.search').id),
                  { fontSize: 14 })
                .width('100%')
                .height(40)
                .textFont({ size: 14 })
                .placeholderFont({ size: 14 })
                .backgroundColor('#E6E8E9')
                .layoutWeight(1)
                .margin({ left: 16, right: 16 })
              Text($r('app.string.more'))
                .fontSize(14)
            }
            .width('100%')
            .height(60)
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height('100%')
          .padding({ left: 16, right: 16 })
        }
        .tabBar(this.tabBuilder($r('app.media.home'), $r('app.string.home_page'), 0))

        TabContent() {
          Text($r('app.string.manage_money_matters_page'))
        }
        .tabBar(this.tabBuilder($r('app.media.manage_money'), $r('app.string.manage_money_matters'), 1))

        TabContent() {
          Text($r('app.string.transaction_page'))
        }
        .tabBar(this.tabBuilder($r('app.media.transaction'), $r('app.string.transaction'), 2))

        TabContent() {
          Text($r('app.string.message_page'))
        }
        .tabBar(this.tabBuilder($r('app.media.message'), $r('app.string.message'), 3))

        TabContent() {
          Text($r('app.string.my_page'))
        }
        .tabBar(this.tabBuilder($r('app.media.mine'), $r('app.string.my'), 4))
      }
      .barHeight(56)
      .vertical(false)
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .hideTitleBar(true)
    .backgroundColor('#F1F3F5')
  }
}