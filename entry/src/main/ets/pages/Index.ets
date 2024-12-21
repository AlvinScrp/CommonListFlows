@Entry
@Component
struct Index {
  @Provide('pageInfo') pageInfo: NavPathStack = new NavPathStack();

  @Builder
  NavTitleBuilder() {
    Text($r('app.string.common_list'))
      .fontSize(30)
      .fontWeight(700)
      .padding({ left: 16 })
  }

  build() {
    Navigation(this.pageInfo) {
      Column() {
        Button($r('app.string.multiple_types_list'))
          .width('100%')
          .onClick(() => {
            // 跳转应用首页（多类型列表场景）
            this.pageInfo.pushPathByName('HomePage', null);
          })
        Button($r('app.string.top_tab_list'))
          .width('100%')
          .margin({ top: 12, bottom: 12 })
          .onClick(() => {
            // 跳转理财应用页面（Tab吸顶场景）
            this.pageInfo.pushPathByName('ManagerPage', null);
          })
        Button($r('app.string.group_ceiling'))
          .width('100%')
          .onClick(() => {
            // 跳转城市列表页面（分组吸顶场景）
            this.pageInfo.pushPathByName('CityList', null);
          })
          .margin({ bottom: 12 })
        Button($r('app.string.secondary_linkage'))
          .width('100%')
          .onClick(() => {
            // 跳转商品分类页面（二级联动场景）
            this.pageInfo.pushPathByName('CategoryPage', null);
          })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.End)
    }
    .title(this.NavTitleBuilder())
    .width('100%')
    .height('100%')
  }
}