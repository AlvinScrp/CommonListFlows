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
          Text($r('app.string.security'))
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