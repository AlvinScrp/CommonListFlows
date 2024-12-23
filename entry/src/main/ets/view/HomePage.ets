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
  @State isRefreshing: boolean = false; // Is refreshing in progress.
  @State productArray: Resource[] =
    [$r('app.string.scenic_area_1'), $r('app.string.scenic_area_2'), $r('app.string.scenic_area_3'),
      $r('app.string.scenic_area_4'), $r('app.string.scenic_area_5')];
  private borderRadiusVal = 6;
  private swiperContent: SwiperType[] = [
    { pic: 'app.media.pic1', title: 'picture1' },
    { pic: 'app.media.pic2', title: 'picture2' },
    { pic: 'app.media.pic3', title: 'picture3' },
    { pic: 'app.media.pic4', title: 'picture4' }
  ];
  private productTitle: Resource[] = [$r('app.string.popular_scenic_spots'), $r('app.string.recommended_scenic_spots'),
    $r('app.string.small_scale_scenic_spots')];
  private gridTitle: Resource[] =
    [$r('app.string.admission_fee'), $r('app.string.city_recommendation'), $r('app.string.natural_scenery'),
      $r('app.string.animals_and_plants'), $r('app.string.theme_park'), $r('app.string.places_of_historic'),
      $r('app.string.special_local_product'), $r('app.string.other_services')];

  // search box.
  @Builder
  searchBuilder() {
    Row() {
      Text($r('app.string.beijing'))
        .width(50)
        .height(40)
        .fontSize(14)
      TextInput()
        .width('100%')
        .height(40)
        .layoutWeight(1)
      Blank()
        .width(15)
      Text($r('app.string.more'))
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

  // Swiper content.
  @Builder
  bannerBuilder() {
    Swiper() {
      ForEach(this.swiperContent, (item: SwiperType) => {
        Stack({ alignContent: Alignment.BottomStart }) {
          Image($r(item.pic))
          Text(item.title)
            .width('100%')
            .height(30)
            .fontSize(12)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)
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

  // Grid content.
  @Builder
  gridBuilder() {
    Grid() {
      ForEach(this.gridTitle, (item: Resource) => {
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
      }, (item: Resource) => JSON.stringify(item))
    }
    .width('100%')
    .rowsGap(10)
    .columnsGap(10)
    .margin({ top: 12, bottom: 12 })
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .borderRadius(this.borderRadiusVal)
  }

  // Customize display area.
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

  // Product list title.
  @Builder
  productHeader(title: Resource) {
    Column() {
      Text(title)
        .width('100%')
        .height(50)
        .backgroundColor('#EEEEEE')
        .padding({ left: 12 })
    }
  }

  // Product list content details
  @Builder
  productDetailBuilder(title: Resource) {
    Column() {
      Image($r('app.media.pic1'))
        .padding({ top: 12, bottom: 12 })
        .borderRadius(this.borderRadiusVal)
      Column() {
        Text(title)
          .fontWeight(FontWeight.Bold)
        Text() {
          Span($r('app.string.group_discount'))
            .fontSize(14)
            .fontColor(Color.Gray)
          Span($r('app.string.fee1'))
            .fontSize(16)
            .fontColor(Color.Red)
        }
        .margin({ top: 12, bottom: 12 })

        Text() {
          Span($r('app.string.group_discount'))
          Span($r('app.string.fee2'))
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

  // Product list.
  @Builder
  productListBuilder() {
    ForEach(this.productTitle, (item: Resource) => {
      ListItemGroup({ header: this.productHeader(item) }) {
        ForEach(this.productArray, (productItem: Resource) => {
          ListItem() {
            this.productDetailBuilder(productItem);
          }
        }, (productItem: Resource) => JSON.stringify(productItem))
      }
      .divider({
        strokeWidth: 1,
        color: '#EEEEEE'
      })
      .borderRadius(this.borderRadiusVal)
    }, (item: Resource) => JSON.stringify(item))
  }

  // Customize swipe up loading for more.
  @Builder
  loadingDataBuilder() {
    Row() {
      if (!this.noMoreData) {
        LoadingProgress()
          .height('50%')
      }
      Text(this.noMoreData ? $r('app.string.no_more_data') : $r('app.string.loading_more'))
    }
    .justifyContent(FlexAlign.Center)
  }

  build() {
    NavDestination() {
      Column() {
        // Top search box.
        this.searchBuilder();
        // Pull down refresh component.
        Refresh({ refreshing: $$this.isRefreshing }) {
          // List as a long list layout.
          List({ space: 10 }) {
            // Swiper
            ListItem() {
              this.bannerBuilder();
            }

            // Grid
            ListItem() {
              this.gridBuilder();
            }

            // Customize display area.
            ListItem() {
              this.displayBuilder();
            }

            // Product classification list.
            this.productListBuilder();

            // Customize bottom loading for more.
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
          .sticky(StickyStyle.Header) // Sticky title.
          .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true }) // Set and enable edge sliding effect.
          .layoutWeight(2) // Set layout weights for components.
          // List component hits bottom to simulate network requests.
          .onReachEnd(() => {
            if (this.productArray.length >= 20) {
              this.noMoreData = true;
              return;
            }
            setTimeout(() => {
              this.productArray.push($r('app.string.scenic_area', (this.productArray.length + 1)));
            }, 2000)
          })
        }
        // Pull down refresh, simulate network request.
        .onRefreshing(() => {
          setTimeout(() => {
            this.productArray =
              [$r('app.string.scenic_area_1'), $r('app.string.scenic_area_2'), $r('app.string.scenic_area_3'),
                $r('app.string.scenic_area_4'), $r('app.string.scenic_area_5')];
            this.noMoreData = false;
            this.isRefreshing = !this.isRefreshing;
          }, 2000)
        })
      }
      .width('95%')
    }
    .hideTitleBar(true)
    .backgroundColor('#F1F3F5')
    .onWillHide(() => {
      this.productArray =
        [$r('app.string.scenic_area_1'), $r('app.string.scenic_area_2'), $r('app.string.scenic_area_3'),
          $r('app.string.scenic_area_4'), $r('app.string.scenic_area_5')];
    })
  }
}