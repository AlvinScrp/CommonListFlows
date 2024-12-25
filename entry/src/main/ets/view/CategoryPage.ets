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

  // Right side list header.
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

  // List sliding event.
  listChange(index: number, isGoods: boolean) {
    if (this.currentTitleId !== index) {
      this.currentTitleId = index;
      if (isGoods) {
        // IsGoods is true, controlling the data in the right-hand list to slide to the specified index.
        this.goodsListScroller.scrollToIndex(index);
      } else {
        // IsGoods is set to false, controlling the left list data to slide to the specified index.
        this.navTitleScroller.scrollToIndex(index);
      }
    }
  }

  build() {
    NavDestination() {
      Row() {
        if (this.requestSuccess) {
          // Left List Data Display.
          List({ scroller: this.navTitleScroller }) {
            ForEach(this.categoryList, (item: NavTitleModel, index: number) => {
              ListItem() {
                Text(item.titleName)
                  .width('100%')
                  .height(56)
                  .fontSize(this.currentTitleId === index ? 18 : 14)
                  .textAlign(TextAlign.Center)
                  .fontColor(this.currentTitleId === index ? '#0A59F7' : Color.Black)
                  .opacity(this.currentTitleId === index ? 1 : 0.6)
                  .backgroundColor(this.currentTitleId === index ? '#F1F3F5' : '#E6E9EB')
                  .fontWeight(this.currentTitleId === index ? FontWeight.Bold : FontWeight.Normal)
                  .onClick(() => {
                    // Pass in the current list item index and true.
                    this.listChange(index, true);
                  })
              }
            }, (item: NavTitleModel) => item.titleName)
          }
          .width(100)
          .height('100%')
          .backgroundColor('#E6E9EB')
          .scrollBar(BarState.Off)

          // Display of List Content on the Right.
          List({ scroller: this.goodsListScroller }) {
            ForEach(this.categoryList, (item: NavTitleModel) => {
              ListItemGroup({ space: 12, header: this.goodsHeaderBuilder(item.titleName) }) {
                ForEach(item.goodsList, (goodsItem: GoodsDataModel) => {
                  ListItem() {
                    Row() {
                      Image(goodsItem.imgUrl)
                        .height('100%')
                        .aspectRatio(1) // Set the aspect ratio of the component to 1.
                      Column() {
                        Text(goodsItem.goodsName)
                          .width('100%')
                          .fontSize(14)
                          .maxLines(2)
                          .textOverflow({ overflow: TextOverflow.Clip })
                          .lineHeight(20)
                        Text('￥' + goodsItem.price)
                          .fontSize(18)
                          .fontColor(Color.Red)
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
                    .backgroundColor(Color.White)
                    .borderRadius(18)
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
            // Pass in the current list item index and false.
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
    .backgroundColor('#F1F3F5')
  }
}