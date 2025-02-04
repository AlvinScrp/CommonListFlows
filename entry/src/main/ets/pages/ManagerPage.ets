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

import { CustomListItem } from './CustomListItem';
import { JSON } from '@kit.ArkTS';
import { rvp } from '../entryability/responsive';

@Builder
export function ManagerPageBuilder() {
  NavDestination() {
    ManagerPage()
  }
  .hideTitleBar(true)
  .backgroundColor('#F1F3F5')

}

@Preview
@Component
struct ManagerPage {
  @State currentTabIndex: number = 0;
  @State currentIndex: number = 0;
  private borderRadiusVal = 16;
  private listScroller: Scroller = new Scroller();
  private scrollController: Scroller = new Scroller();
  private contentTabController: TabsController = new TabsController();
  private tabArray: Resource[] =
    [$r('app.string.follow'), $r('app.string.hot_search'), $r('app.string.recommend'), $r('app.string.more')];
  private scrollHeight: number = 0
  private tabStickyHeight: number = 0
  private sizeStickyHeight: number = 0
  @State private list1Height: number = 1920
  @State private list2Height: number = 1920
  @State isRefreshing: boolean = false
  @State maxRefreshingHeight: number = 100.0
  @State ratio: number = 1
  @State imageScale: number = 1.0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      this.headerBg()
      Refresh({ refreshing: $$this.isRefreshing, promptText: 'sdsdsdsd' }) {
        // Home page content.
        Scroll(this.scrollController) {
          Column() {
            Text('nihao').width('100%').height(60).margin({ top: 100 }).backgroundColor(Color.Yellow)
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
            .backgroundColor(Color.White)
            .onAreaChange((_, newValue) => {
              this.tabStickyHeight = newValue.height as number
              this.calculateListHeight()
            })

            List({ space: 10, scroller: this.listScroller, }) {
              CustomListItem({
                imgUrl: $r('app.media.pic1'),
                title: '1育人之本，在于培根铸魂。思想政治理论课正是落实立德树人根本任务'
              })
              ListItemGroup({ header: this.listSizeHead() }) {
                ListItem() {
                  Row() {
                    this.categoryListBuild()
                    this.goodsBuild()
                  }
                }
              }
            }
            .width('100%')
            .height('100%')
            .scrollBar(BarState.Off)
            .edgeEffect(EdgeEffect.None)
            .nestedScroll({
              scrollForward: NestedScrollMode.PARENT_FIRST,
              scrollBackward: NestedScrollMode.SELF_FIRST
            })
            .height(this.list1Height)
            .sticky(StickyStyle.Header)
          }
        }
        .width('100%')
        .height('100%')
        .margin({ top: 60 })
        // .backgroundColor('#F1F3F5')
        .scrollBar(BarState.Off)
        .onDidScroll((x: number, yOffset: number, scrollState: ScrollState) => {
          console.log("===>onDidScroll Scroll yOffset scrollState", Math.round(yOffset), scrollState)
        })
        .onAreaChange((oldValue, newValue) => {
          console.log("===> onAreaChange Scroll", 'new', newValue.height as number)
          this.scrollHeight = newValue.height as number
          this.calculateListHeight()
        })
      }
      .onStateChange((refreshStatus: RefreshStatus) => {
        console.info('Refresh onStatueChange state is ' + refreshStatus)
      })
      .onRefreshing(() => {
        setTimeout(() => {
          this.isRefreshing = false
        }, 1000)
        console.log('onRefreshing test')
      })
      .backgroundColor(Color.Transparent)
      .refreshOffset(0)
      .pullToRefresh(true)
      .onOffsetChange((offset: number, v: void) => {
        this.imageScale = 1 +  Math.pow((offset / this.maxRefreshingHeight), 3)
        console.log('===>  onRefreshing onOffsetChange', offset)
        this.ratio = 1 - Math.pow((offset / this.maxRefreshingHeight), 3)
      })
      .pullDownRatio(this.ratio)

      this.toolbar()

    }
    .width('100%')
    .height('100%')
    .onAreaChange((oldValue, newValue) => {
      console.log('===> sss', newValue.height as number)
    })

  }

  @Builder
  goodsBuild() {
    List() {
      ListItemGroup({ header: this.listFilterHead() }) {
        this.listItems()
      }
    }
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
    .height(this.list2Height)
    .width('80%')
    .sticky(StickyStyle.Header)
  }

  @Builder
  headerBg() {
      Image($r('app.media.pic1'))
        .scale({ x: this.imageScale, y: this.imageScale, centerY: 0})
        .width(rvp(375))
        .height(rvp(234))
      // .width(`${100*this.imageScale}%`)
      // .height(`${100*this.imageScale}%`)
  }

  @Builder
  toolbar() {
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
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .margin({ left: 16, right: 16 })
      Text($r('app.string.more'))
        .fontSize(14)
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.Center)

  }

  @Builder
  categoryListBuild() {
    Scroll() {
      Column() {
        ForEach([0, 1, 2, 3, 5, 6, 7, 8], (item: number) => {
          Text(`${item}sssdsdsdsdsd`).height(100).width('100%')
        })
        Text('space').width('100%').height(400)
      }
    }
    .scrollable(ScrollDirection.Vertical)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
    .width('20%')
    .height(this.list2Height)
    .backgroundColor(0xFFF1F3F5)

  }

  @Builder
  listItems() {
    CustomListItem({
      imgUrl: $r('app.media.pic2'),
      title: '2育人之本，在于培根铸魂。思想政治理论课正是落实立德树人根本任务'
    })
    CustomListItem({
      imgUrl: $r('app.media.pic4'),
      title: '3育人之本，在于培根铸魂。思想政治理论课正是落实立德树人根本任务'
    })
    CustomListItem({
      imgUrl: $r('app.media.pic1'),
      title: '4育人之本，在于培根铸魂。思想政治理论课正是落实立德树人根本任务'
    })
    CustomListItem({
      imgUrl: $r('app.media.pic2'),
      title: '5育人之本，在于培根铸魂。思想政治理论课正是落实立德树人根本任务'
    })
    CustomListItem({
      imgUrl: $r('app.media.pic3'),
      title: '6育人之本，在于培根铸魂。思想政治理论课正是落实立德树人根本任务'
    })
    CustomListItem({
      imgUrl: $r('app.media.pic4'),
      title: '7育人之本，在于培根铸魂。思想政治理论课正是落实立德树人根本任务'
    }).width('100%').height('auto')
    CustomListItem({
      imgUrl: $r('app.media.pic4'),
      title: '8育人之本，在于培根铸魂。思想政治理论课正是落实立德树人根本任务'
    }).width('100%').height('auto')
  }

  @Builder
  listSizeHead() {
    Scroll() {
      Row({ space: 12 }) {
        Text('xxl-179')
        Text('axl-179')
        Text('bxl-179')
        Text('cxl-179')
        Text('dxl-179')
        Text('exl-179')
        Text('fxl-179')
      }.padding(12).backgroundColor(Color.Pink)
    }.scrollable(ScrollDirection.Horizontal)
    .onAreaChange((oldValue, newValue) => {
      this.sizeStickyHeight = newValue.height as number
      this.calculateListHeight()
    })

  }

  @Builder
  listFilterHead() {
    Scroll() {
      Row({ space: 12 }) {
        Text('综合')
        Text('价格')
        Text('销量')
      }.padding(12).backgroundColor(Color.Green).width('100%')
    }.scrollable(ScrollDirection.Horizontal)
  }

  calculateListHeight() {

    if (this.scrollHeight > 0 && this.tabStickyHeight > 0) {
      console.log('===> calculateList1Height', this.scrollHeight, this.tabStickyHeight)
      this.list1Height = this.scrollHeight - this.tabStickyHeight
    } else {
      this.list1Height = 1920
    }
    if (this.scrollHeight > 0 && this.tabStickyHeight > 0 && this.sizeStickyHeight > 0) {
      console.log('===> calculateList2Height', this.scrollHeight, this.tabStickyHeight)
      this.list2Height = this.scrollHeight - this.tabStickyHeight - this.sizeStickyHeight
    } else {
      this.list2Height = 1920
    }
  }
}