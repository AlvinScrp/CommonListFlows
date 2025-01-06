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
import { buffer } from "@kit.ArkTS";

interface City {
  code: string,
  city: string
}

interface CityData {
  current: string[],
  hot: string[],
  cityList: Map<string, City[]>
}

@Builder
export function CityListBuilder() {
  CityList()
}

@Component
struct CityList {
  @State selectNavIndex: number = -1;
  @State isClickScroll: boolean = false;
  private currentCity: string = '';
  private hotCities: string[] = [];
  private groupCities: Map<string, City[]> = new Map();
  private cityScroller: ListScroller = new ListScroller();
  private navListScroller: ListScroller = new ListScroller();
  private groupWorldList: string[] =
    ['A', 'B', 'C', 'D', 'F', 'J', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'];

  aboutToAppear() {
    let cityData: Uint8Array = getContext(this).resourceManager.getRawFileContentSync('cityList.json');
    let cityStr = buffer.from(cityData.buffer).toString();
    let data: CityData = JSON.parse(cityStr);
    this.currentCity = data.current[0];
    this.hotCities = data.hot;
    this.groupCities = data.cityList;
  }

  // Group List Header.
  @Builder
  itemHead(text: ResourceStr) {
    Text(text)
      .width('100%')
      .height(45)
      .fontSize(16)
      .padding({ left: 16 })
      .backgroundColor('#F1F3F5')
  }

  // List data content.
  @Builder
  textContent(content: string) {
    Text(content)
      .width('100%')
      .height(45)
      .fontSize(16)
      .padding({ left: 16, top: 12, bottom: 12 })
      .textAlign(TextAlign.Start)
      .backgroundColor(Color.White)
  }

  // Retrieve city data corresponding to letters.
  getCitiesWithGroupName(name: string): City[] {
    return this.groupCities[name];
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.End }) {
        // City List Data.
        List({ scroller: this.cityScroller }) {
          // Current city.
          ListItemGroup({ header: this.itemHead($r('app.string.current_city')) }) {
            ListItem() {
              this.textContent(this.currentCity);
            }
          }

          // Popular cities.
          ListItemGroup({ header: this.itemHead($r('app.string.popular_cities')) }) {
            ForEach(this.hotCities, (item: string) => {
              ListItem() {
                this.textContent(item);
              }
            }, (item: string) => item)
          }
          .divider({
            strokeWidth: 1,
            color: '#EDEDED',
            startMargin: 10,
            endMargin: 45
          })

          // City data.
          ForEach(this.groupWorldList, (item: string) => {
            // Traverse the first letter of the city and use it as the header of the city grouping data.
            ListItemGroup({ header: this.itemHead(item) }) {
              // Retrieve and display corresponding city data based on letters.
              ForEach(this.getCitiesWithGroupName(item), (cityItem: City) => {
                ListItem() {
                  this.textContent(cityItem.city);
                }
              }, (cityItem: City) => cityItem.city)
            }
          })
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
        .sticky(StickyStyle.Header) // Set the header of ListItemGroup to be the top, and the foot not to be the bottom.
        .onTouch(() => {
          // Touch scrolling of city list, isClickScroll is false to prevent conflicts with navigation list scrolling during the scrolling process.
          this.isClickScroll = false;
        })
        .onScrollIndex((index: number) => {
          // By linking the selectNavIndex state variable with index, control the selection status of the navigation list.
          this.selectNavIndex = index - 2;
        })

        // Side letter navigation data.
        Column() {
          List({ scroller: this.navListScroller }) {
            ForEach(this.groupWorldList, (item: string, index: number) => {
              ListItem() {
                Text(item)
                  .width(30)
                  .height(30)
                  .fontSize(16)
                  .padding({ left: 10 })
                  .textAlign(TextAlign.Start)
                  .borderRadius(index === this.selectNavIndex ? '50%' : 0)
                  // Set the background color when selecting the side navigation.
                  .fontColor(index === this.selectNavIndex ? '#FFFFFF' : Color.Black)
                  .backgroundColor(index === this.selectNavIndex ? '#bEDAF2' : Color.Transparent)
                  .onClick(() => {
                    this.selectNavIndex = index;
                    // Select the navigation list and set isClickScroll to true to prevent changes in the navigation list status during the scrolling process with the city list.
                    this.isClickScroll = true;
                    // By using the scrollIndex method of cityScanner, control the sliding city list to specify the Index,
                    // as there are "current city" and "popular city" in the city list, so the index needs to be incremented by 2.
                    this.cityScroller.scrollToIndex(index + 2, false, ScrollAlign.START);
                  })
              }
            }, (item: string) => item)
          }
        }
        .width('10%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .hideTitleBar(true)
    .backgroundColor('#F1F3F5')
  }
}