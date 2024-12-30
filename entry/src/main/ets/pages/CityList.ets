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
    let jsonString: string =
      '{"current": ["北京"],"hot": ["广州","上海","武汉","南京","成都"],"cityList": {"A": [{"code": 1,"city": "阿拉善盟"},{"code": 2,"city": "鞍山"},{"code": 3,"city": "安庆"},{"code": 4,"city": "安阳"},{"code": 5,"city": "安顺"},{"code": 6,"city": "阿里地区"},{"code": 7,"city": "安康"},{"code": 8,"city": "阿勒泰地区"},{"code": 9,"city": "澳门半岛"}],"B": [{"code": 10,"city": "北京"},{"code": 11,"city": "保定"},{"code": 12,"city": "包头"},{"code": 13,"city": "本溪"},{"code": 14,"city": "白山"},{"code": 15,"city": "白城"},{"code": 16,"city": "蚌埠"},{"code": 17,"city": "滨州"},{"code": 18,"city": "北海"},{"code": 19,"city": "白色"},{"code": 20,"city": "巴中"},{"code": 21,"city": "宝鸡"},{"code": 22,"city": "白银"}],"C": [{"code": 23,"city": "承德"},{"code": 24,"city": "沧州"},{"code": 25,"city": "长治"},{"code": 26,"city": "赤峰"},{"code": 27,"city": "朝阳"},{"code": 28,"city": "长春"},{"code": 29,"city": "常州"},{"code": 30,"city": "滁州"}],"D": [{"code": 31, "city": "大同"},{"code": 32, "city": "大连"},{"code": 33, "city": "丹东"},{"code": 34, "city": "大庆"},{"code": 35, "city": "大兴安岭地区"},{"code": 36, "city": "东营"},{"code": 37, "city": "德州"},{"code": 38, "city": "东莞"},{"code": 39, "city": "德阳"},{"code": 40, "city": "达州"}],"E": [{"code": 51, "city": "鄂尔多斯"},{"code": 52, "city": "鄂州"},{"code": 53, "city": "恩施土家族苗族自治州"}],"F": [{"code": 61, "city": "抚顺"},{"code": 62, "city": "阜新"},{"code": 63, "city": "阜阳"},{"code": 64, "city": "福州"},{"code": 65, "city": "抚州"},{"code": 66, "city": "佛山"},{"code": 67, "city": "防城港"}],"G":[{"code": 71, "city": "赣州"},{"code": 72, "city": "广州"},{"code": 73, "city": "桂林"},{"code": 74, "city": "贵港"},{"code": 75, "city": "广元"},{"code": 76, "city": "广安"},{"code": 77, "city": "甘孜藏族自治州"},{"code": 78, "city": "贵阳"},{"code": 79, "city": "甘南藏族自治州"},{"code": 80, "city": "果洛藏族自治州"}],"H": [{"code": 81, "city": "邯郸"},{"code": 82, "city": "衡水"},{"code": 83, "city": "呼和浩特"},{"code": 84, "city": "呼伦贝尔"},{"code": 85, "city": "葫芦岛"},{"code": 86, "city": "哈尔滨"},{"code": 87, "city": "鹤岗"},{"code": 88, "city": "黑河"},{"code": 89, "city": "淮安"},{"code": 90, "city": "杭州"}],"J": [{"code": 91, "city": "晋城"},{"code": 92, "city": "晋中"},{"code": 93, "city": "锦州"},{"code": 94, "city": "吉林"},{"code": 95, "city": "鸡西"},{"code": 96, "city": "佳木斯"},{"code": 97, "city": "嘉兴"},{"code": 98, "city": "金华"},{"code": 99, "city": "景德镇"},{"code": 100, "city": "九江"}],"K": [{"code": 101, "city": "开封"},{"code": 102, "city": "昆明"},{"code": 103, "city": "克拉玛依"},{"code": 104, "city": "克孜勒苏柯尔克孜自治州"},{"code": 105, "city": "喀什地区"}],"L": [{"code": 111, "city": "廊坊"},{"code": 112, "city": "漯河"},{"code": 113, "city": "临汾"},{"code": 114, "city": "吕梁"},{"code": 115, "city": "辽阳"},{"code": 116, "city": "辽远"},{"code": 117, "city": "连云港"},{"code": 118, "city": "丽水"},{"code": 119, "city": "六安"},{"code": 120, "city": "龙岩"}],"M": [{"code": 121, "city": "牡丹江"},{"code": 122, "city": "马鞍山"},{"code": 123, "city": "茂名"},{"code": 124, "city": "梅州"},{"code": 125, "city": "绵阳"},{"code": 126, "city": "眉山"}],"N": [{"code": 131, "city": "南京"},{"code": 132, "city": "南充"},{"code": 133, "city": "宁波"},{"code": 134, "city": "南宁"},{"code": 135, "city": "南平"},{"code": 136, "city": "南昌"},{"code": 137, "city": "宁德"},{"code": 138, "city": "南阳"},{"code": 139, "city": "内江"},{"code": 140, "city": "那曲地区"}],"P": [{"code": 141, "city": "盘锦"},{"code": 142, "city": "莆田"},{"code": 143, "city": "濮阳"},{"code": 144, "city": "萍乡"},{"code": 145, "city": "平顶山"},{"code": 146, "city": "攀枝花"},{"code": 147, "city": "普洱"},{"code": 148, "city": "平凉"}],"Q": [{"code": 151, "city": "秦皇岛"},{"code": 152, "city": "齐齐哈尔"},{"code": 153, "city": "七台河"},{"code": 154, "city": "泉州"},{"code": 155, "city": "青岛"},{"code": 156, "city": "清远"},{"code": 157, "city": "钦州"},{"code": 158, "city": "黔西南布依族苗族自治州"},{"code": 159,"city": "黔东南布依族苗族自治州"},{"code": 160, "city": "黔南布依族苗族自治州"}],"R": [{"code": 161, "city": "日照"},{"code": 162, "city": "日喀则地区"}],"S": [{"code": 171, "city": "石家庄"},{"code": 172, "city": "朔州"},{"code": 173, "city": "沈阳"},{"code": 174, "city": "四平"},{"code": 175, "city": "松原"},{"code": 176, "city": "绥化"},{"code": 177, "city": "上海"},{"code": 178, "city": "随州"},{"code": 179, "city": "苏州"},{"code": 180, "city": "宿迁"}],"T": [{"code": 181,"city": "天津"},{"code": 182, "city": "唐山"},{"code": 183, "city": "太原"},{"code": 184, "city": "通辽"},{"code": 185, "city": "铁岭"},{"code": 186, "city": "通化"},{"code": 187, "city": "台州"},{"code": 188, "city": "泰州"},{"code": 189, "city": "铜陵"},{"code": 190, "city": "泰安"}],"W": [{"code": 191, "city": "乌海"},{"code": 192, "city": "乌兰察布"},{"code": 193, "city": "无锡"},{"code": 194, "city": "温州"},{"code": 195, "city": "芜湖"},{"code": 196, "city": "潍坊"},{"code": 197, "city": "威海"},{"code": 198, "city": "武汉"},{"code": 199, "city": "梧州"},{"code": 200, "city": "渭南"}],"X": [{"code": 201, "city": "邢台"},{"code": 202, "city": "忻州"},{"code": 203, "city": "徐州"},{"code": 204, "city": "兴安盟"},{"code": 205, "city": "锡林郭勒"},{"code": 206, "city": "宣城"},{"code": 207, "city": "厦门"},{"code": 208, "city": "新余"},{"code": 209, "city": "新乡"},{"code": 210, "city": "许昌"}],"Y": [{"code": 211, "city": "阳泉"},{"code": 212, "city": "运城"},{"code": 213, "city": "营口"},{"code": 214, "city": "延边朝鲜族自治州"},{"code": 215, "city": "宜春"},{"code": 216, "city": "伊春"},{"code": 217, "city": "盐城"},{"code": 218, "city": "扬州"},{"code": 219, "city": "鹰潭"},{"code": 220, "city": "烟台"}],"Z": [{"code": 221, "city": "张家口"},{"code": 222, "city": "镇江"},{"code": 223, "city": "舟山"},{"code": 224, "city": "漳州"},{"code": 225, "city": "淄博"},{"code": 226, "city": "枣庄"},{"code": 227, "city": "郑州"},{"code": 228, "city": "周口"},{"code": 229, "city": "株洲"},{"code": 230, "city": "张家界"}]}}'
    let data: CityData = JSON.parse(jsonString);
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
                  .fontColor(index === this.selectNavIndex ? '#FFFFFF' :
                  Color.Black)// Set the background color when selecting the side navigation.
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