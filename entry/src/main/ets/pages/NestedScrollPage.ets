import goodsViewModel, { GoodsDataModel, NavTitleModel } from "../model/LinkDataModel";

enum ScrollPosition {
  start,
  center,
  end
}

class ItemClass {
  content: string = '';
  color: Color = Color.White;
}

@Builder
export function NestedScrollPageBuilder() {
  NestedScrollPage()
}

@Component
struct NestedScrollPage {
  @State listPosition: number = ScrollPosition.start; // 0代表滚动到List顶部，1代表中间值，2代表滚动到List底部。
  @State scrollPosition: number = ScrollPosition.start; // 0代表滚动到页面顶部，1代表中间值，2代表滚动到页面底部。
  @State showTitle: boolean = false;
  @State currentYOffset: number = 0;
  private arr: ItemClass[] = [];
  private colorArr: Color[] = [Color.White, Color.Blue, Color.Brown, Color.Green, Color.Gray];
  private scrollerForScroll: Scroller = new Scroller();
  private scrollerForList: Scroller = new Scroller();
  private scrollerForTitle: Scroller = new Scroller();
  @State currentIndex: number = 0;

  aboutToAppear() {
    for (let i = 0; i < 6; i++) {
      let data: ItemClass = {
        content: i.toString(),
        color: this.colorArr[i % 5]
      }
      this.arr.push(data);
    }
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Top }) {
        Scroll(this.scrollerForScroll) {
          Column() {
            Image($r('app.media.app_icon'))
              .width("100%")
              .height("40%")

            //tab
            Row() {
              List({ space: 2, initialIndex: 0, scroller: this.scrollerForTitle }) {
                ForEach(this.arr, (item: ItemClass, index) => {
                  ListItem() {
                    Column() {
                      Text(item.content);
                      Divider()
                        .color(Color.Black)
                        .strokeWidth(5)
                        .visibility(index == this.currentIndex ? Visibility.Visible : Visibility.Hidden)
                    }
                    .justifyContent(FlexAlign.Center)
                    .width('25%')
                    .height(50)
                    .onClick(() => {
                      this.scrollerForList.scrollToIndex(index)
                      this.scrollerForScroll.scrollEdge(Edge.Bottom)
                    })
                  }
                })
              }
              .listDirection(Axis.Horizontal)
              .scrollBar(BarState.Off)
            }
            .backgroundColor('#ffe2d0d0')

            List({ space: 10, scroller: this.scrollerForList }) {
              ForEach(this.arr, (item: ItemClass, index) => {
                ListItem() {
                  Column() {
                    Text(item.content)
                    //添加其他内容
                  }
                  .width('100%')
                  .height(500)
                  .backgroundColor(item.color)
                }.width("100%").height(500)
                .onVisibleAreaChange([0.8], (isVisible) => {
                  if (isVisible) {
                    this.currentIndex = index;
                    this.scrollerForTitle.scrollToIndex(this.currentIndex);
                  }
                })
              }, (item: ItemClass) => item.content)
            }
            .padding({ left: 10, right: 10 })
            .width("100%")
            .edgeEffect(EdgeEffect.None)
            .scrollBar(BarState.Off)
            .onReachStart(() => {
              this.listPosition = ScrollPosition.start
            })
            .onReachEnd(() => {
              this.listPosition = ScrollPosition.end
            })
            .onScrollFrameBegin((offset: number, state: ScrollState) => {
              // 滑动到列表中间时
              if (!((this.listPosition == ScrollPosition.start && offset < 0)
                || (this.listPosition == ScrollPosition.end && offset > 0))) {
                this.listPosition = ScrollPosition.center
              }

              // 如果页面已滚动到底部，列表不在顶部或列表有正向偏移量
              if (this.scrollPosition == ScrollPosition.end
                && (this.listPosition != ScrollPosition.start || offset > 0)) {
                return { offsetRemain: offset };
              } else {
                this.scrollerForScroll.scrollBy(0, offset)
                return { offsetRemain: 0 };
              }
            })
            .width("100%")
            .height("calc(100% - 50vp)")
            .backgroundColor('#F1F3F5')
          }
        }
        .scrollBar(BarState.Off)
        .width("100%")
        .height("100%")
        .onDidScroll((xOffset: number, yOffset: number, scrollState: ScrollState) => {
          this.currentYOffset = this.scrollerForScroll.currentOffset().yOffset;

          // 非（页面在顶部或页面在底部），则页面在中间
          if (!((this.scrollPosition == ScrollPosition.start && yOffset < 0)
            || (this.scrollPosition == ScrollPosition.end && yOffset > 0))) {
            this.scrollPosition = ScrollPosition.center
          }
        })
        .onScrollEdge((side: Edge) => {
          if (side == Edge.Top) {
            // 页面在顶部
            this.scrollPosition = ScrollPosition.start
          } else if (side == Edge.Bottom) {
            // 页面在底部
            this.scrollPosition = ScrollPosition.end
          }
        })
        .onScrollFrameBegin(offset => {
          if (this.scrollPosition == ScrollPosition.end) {
            return { offsetRemain: 0 };
          } else {
            return { offsetRemain: offset };
          }
        })
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor(0xFFDCDCDC)
  }
}