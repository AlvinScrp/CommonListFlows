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
  @State scenicSpotArray: Resource[] =
    [$r('app.string.scenic_area_1'), $r('app.string.scenic_area_2'), $r('app.string.scenic_area_3'),
      $r('app.string.scenic_area_4'), $r('app.string.scenic_area_5')];
  private borderRadiusVal = 16;
  private swiperContent: SwiperType[] = [
    { pic: 'app.media.pic1', title: 'picture1' },
    { pic: 'app.media.pic2', title: 'picture2' },
    { pic: 'app.media.pic3', title: 'picture3' },
    { pic: 'app.media.pic4', title: 'picture4' }
  ];
  private scenicSpotTitle: Resource[] =
    [$r('app.string.popular_scenic_spots'), $r('app.string.recommended_scenic_spots'),
      $r('app.string.small_scale_scenic_spots')];
  private gridTitle: Resource[] =
    [$r('app.string.admission_fee'), $r('app.string.city_recommendation'), $r('app.string.natural_scenery'),
      $r('app.string.animals_and_plants'), $r('app.string.theme_park'), $r('app.string.places_of_historic'),
      $r('app.string.special_local_product'), $r('app.string.hotel'), $r('app.string.ride_hailing'),
      $r('app.string.other_services')];

  // Scenic spot list title.
  @Builder
  scenicSpotHeader(title: Resource) {
    Column() {
      Text(title)
        .width('100%')
        .height(50)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .backgroundColor('#F1F3F5')
    }
  }

  // Scenic spot list content details
  @Builder
  scenicSpotDetailBuilder(title: Resource) {
    Column() {
      Image($r('app.media.pic1'))
        .width('100%')
        .height(186)
        .padding({ bottom: 12 })
        .borderRadius(this.borderRadiusVal)
      Column() {
        Text(title)
          .fontWeight(FontWeight.Bold)
        Text() {
          Span($r('app.string.group_discount'))
            .fontSize(14)
            .opacity(0.9)
          Span($r('app.string.fee1'))
            .fontSize(16)
            .fontColor(Color.Red)
        }
        .margin({ top: 4, bottom: 4 })

        Text() {
          Span($r('app.string.group_discount'))
          Span($r('app.string.fee2'))
        }
        .fontSize(14)
        .opacity(0.9)
        .margin({ bottom: 24 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
  }

  build() {
    NavDestination() {
      Column() {
        // Top search box.
        Row() {
          Text($r('app.string.beijing'))
            .fontSize(14)
          TextInput({ placeholder: $r('app.string.want_search') })
            .width('100%')
            .height(40)
            .layoutWeight(1)
            .placeholderFont({ size: 14 })
            .margin({ left: 16, right: 16 })
          Text($r('app.string.more'))
            .fontSize(14)
        }
        .width('100%')
        .height(60)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Pull down refresh component.
        Refresh({ refreshing: $$this.isRefreshing }) {
          // List as a long list layout.
          List({ space: 12 }) {
            // Swiper
            ListItem() {
              Swiper() {
                ForEach(this.swiperContent, (item: SwiperType) => {
                  Stack({ alignContent: Alignment.BottomStart }) {
                    Image($r(item.pic))
                  }
                }, (item: SwiperType) => JSON.stringify(item))
              }
              .width('100%')
              .height(184)
              .autoPlay(true)
              .duration(1000)
              .curve(Curve.Linear)
              .indicator(
                new DotIndicator()
                  .selectedColor(Color.White)
              )
              .itemSpace(10)
              .borderRadius(this.borderRadiusVal)
            }

            // Grid
            ListItem() {
              Grid() {
                ForEach(this.gridTitle, (item: Resource) => {
                  GridItem() {
                    Column() {
                      Image($r('app.media.pic1'))
                        .width(44)
                        .height(44)
                        .objectFit(ImageFit.Fill)
                        .borderRadius(22)
                      Text(item)
                        .fontSize(12)
                        .padding({ top: 4 })
                    }
                  }
                }, (item: Resource) => JSON.stringify(item))
              }
              .width('100%')
              .rowsGap(16)
              .columnsGap(19)
              .padding(16)
              .borderRadius(this.borderRadiusVal)
              .backgroundColor(Color.White)
              .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
            }

            // Customize display area.
            ListItem() {
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

            // Scenic spot classification list.
            ForEach(this.scenicSpotTitle, (item: Resource) => {
              ListItemGroup({ header: this.scenicSpotHeader(item) }) {
                ForEach(this.scenicSpotArray, (scenicSpotItem: Resource) => {
                  ListItem() {
                    this.scenicSpotDetailBuilder(scenicSpotItem);
                  }
                }, (scenicSpotItem: Resource) => JSON.stringify(scenicSpotItem))
              }
              .borderRadius(this.borderRadiusVal)
            }, (item: Resource) => JSON.stringify(item))

            // Customize bottom loading for more.
            ListItem() {
              Row() {
                if (!this.noMoreData) {
                  LoadingProgress()
                    .width(24)
                    .height(24)
                }
                Text(this.noMoreData ? $r('app.string.no_more_data') : $r('app.string.loading_more'))
              }
              .justifyContent(FlexAlign.Center)
            }
            .width('100%')
            .margin({ bottom: 65 })
          }
          .width('100%')
          .height('100%')
          .scrollBar(BarState.Off)
          .sticky(StickyStyle.Header) // Sticky title.
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
          .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true }) // Set and enable edge sliding effect.
          .layoutWeight(2) // Set layout weights for components.
          // List component hits bottom to simulate network requests.
          .onReachEnd(() => {
            if (this.scenicSpotArray.length >= 20) {
              this.noMoreData = true;
              return;
            }
            setTimeout(() => {
              this.scenicSpotArray.push($r('app.string.scenic_area', (this.scenicSpotArray.length + 1)));
            }, 500)
          })
        }
        // Pull down refresh, simulate network request.
        .onRefreshing(() => {
          this.isRefreshing = true;
          setTimeout(() => {
            this.scenicSpotArray =
              [$r('app.string.scenic_area_1'), $r('app.string.scenic_area_2'), $r('app.string.scenic_area_3'),
                $r('app.string.scenic_area_4'), $r('app.string.scenic_area_5')];
            this.noMoreData = false;
            this.isRefreshing = false;
          }, 2000)
        })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16 })
    }
    .hideTitleBar(true)
    .backgroundColor('#F1F3F5')
    .onWillHide(() => {
      this.scenicSpotArray =
        [$r('app.string.scenic_area_1'), $r('app.string.scenic_area_2'), $r('app.string.scenic_area_3'),
          $r('app.string.scenic_area_4'), $r('app.string.scenic_area_5')];
    })
  }
}