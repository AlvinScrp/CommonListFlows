@Component
export struct CustomListItem {
  @State title: string | ResourceStr = '';
  @State imgUrl: string | ResourceStr = '';

  build() {
    Flex({ direction: FlexDirection.Column }) {
      // avatar
      Row() {
        Image(this.imgUrl)
          .width(30)
          .height(30)
          .borderRadius(15)
        Column() {
          Text('证券')
            .fontSize(16)
          Text('12-21 12:00')
            .fontSize(12)
            .fontColor('#FFCAC8C8')
        }
        .margin({ left: 5 })
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }
      .margin({ top: 12, bottom: 12 })

      // news
      Column() {
        Text(this.title)
          .fontSize(16)
          .id('title')
      }
      .margin({ bottom: 12 })

      // news image
      Row() {
        Image(this.imgUrl)
          .width(110)
          .height(110)
          .borderRadius(8)
        Image(this.imgUrl)
          .width(110)
          .height(110)
          .borderRadius(8)
        Image(this.imgUrl)
          .width(110)
          .height(110)
          .borderRadius(8)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .margin({ left: 12, right: 12, bottom: 12 })
  }
}