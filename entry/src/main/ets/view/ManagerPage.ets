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
  @State searchVal: string = '';
  @State currentTabIndex: number = 0;
  private currentIndex: number = 0;
  private listScroller: Scroller = new Scroller();
  private scrollController: Scroller = new Scroller();
  private tabsController: TabsController = new TabsController();
  private contentTabController: TabsController = new TabsController();
  private searchController: SearchController = new SearchController();
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
        .margin({ left: 15 })
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .height(56)
    .padding({ left: 12, right: 12 })
  }

  // Custom Tab in Content.
  @Builder
  myTabBuilder(title: string, index: number) {
    Row({ space: 16 }) {
      Text(title)
        .width(500)
        .padding({ bottom: 10 })
        .fontColor(this.currentTabIndex === index ? '#0a59f7' : Color.Black)
        .decoration(this.currentTabIndex === index ? { type: TextDecorationType.Underline, color: '#0a59f7' } :
          { type: TextDecorationType.None })
    }
    .width(60)
    .height(40)
    .padding({ left: 12 })
    .onClick(() => {
      // Click to switch tabs content.
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
              // Home page content.
              Scroll(this.scrollController) {
                Column() {
                  // More investment content.
                  Column() {
                    Text($r('app.string.more_investment'))
                      .width('100%')
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .padding(12)
                      .textAlign(TextAlign.Start)
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
                    // Customize Tabbar.
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

              // Top input box.
              Row() {
                Image($r('app.media.app_icon'))
                  .width(30)
                  .height(30)
                  .margin({ right: 10 })
                Search({
                  value: this.searchVal,
                  placeholder: $r('app.string.want_search'),
                  controller: this.searchController
                })
                  .searchButton(getContext(this).resourceManager.getStringSync($r('app.string.search').id),
                    { fontSize: 14 })
                  .width('75%')
                  .height(40)
                  .textFont({ size: 14 })
                  .placeholderFont({ size: 14 })
                  .backgroundColor('#F5F5F5')
                  .placeholderColor(Color.Gray)
                Text($r('app.string.more'))
                  .padding({ left: 10 })
                  .fontSize(14)
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
          .tabBar($r('app.string.home_page'))

          TabContent() {
            Text($r('app.string.manage_money_matters_page'))
          }
          .tabBar($r('app.string.manage_money_matters'))

          TabContent() {
            Text($r('app.string.transaction_page'))
          }
          .tabBar($r('app.string.transaction'))

          TabContent() {
            Text($r('app.string.message_page'))
          }
          .tabBar($r('app.string.message'))

          TabContent() {
            Text($r('app.string.my_page'))
          }
          .tabBar($r('app.string.my'))
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
    .backgroundColor('#F1F3F5')
  }
}