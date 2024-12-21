interface LinkDataModel {
  titleId: number,
  titleName: string,
  goodsId: number,
  goodsName: string,
  imgUrl: Resource,
  price: number,
}

export interface GoodsDataModel {
  titleId: number,
  goodsId: number,
  goodsName: string,
  imgUrl: Resource,
  price: number,
}

export interface NavTitleModel {
  titleId: number,
  titleName: string,
  goodsList: GoodsDataModel[]
}

class GoodsViewModel {
  getLinkData(): NavTitleModel[] {
    let linkDataList: NavTitleModel[] = [];
    let titleId: number = 0;
    linkData.forEach((item: LinkDataModel) => {
      if (titleId !== item.titleId) {
        linkDataList.push({ titleId: item.titleId, titleName: item.titleName, goodsList: [] });
        // console.log('111111', JSON.stringify({ titleId: item.titleId, titleName: item.titleName, goodsList: [] }));
      }
      linkDataList[linkDataList.length -1].goodsList.push({
        titleId,
        goodsId: item.goodsId,
        goodsName: item.goodsName,
        imgUrl: item.imgUrl,
        price: item.price
      })
      titleId = item.titleId;
    })
    return linkDataList;
  }
}

let goodsViewModel = new GoodsViewModel();

export default goodsViewModel as GoodsViewModel;

//   [
//   new LinkDataModel(1, '精选服饰', 1, '精选服饰1', $r('app.media.pic1'), 100),
//   new LinkDataModel(1, '精选服饰', 1, '精选服饰1', $r('app.media.pic1'), 100),
// ]
const linkData: LinkDataModel[] = [
  {
    titleId: 1,
    titleName: '精选服饰',
    goodsId: 1,
    goodsName: '精选服饰1',
    imgUrl: $r('app.media.pic1'),
    price: 100
  },
  {
    titleId: 1,
    titleName: '精选服饰',
    goodsId: 2,
    goodsName: '精选服饰2',
    imgUrl: $r('app.media.pic1'),
    price: 110
  },
  {
    titleId: 1,
    titleName: '精选服饰',
    goodsId: 3,
    goodsName: '精选服饰3',
    imgUrl: $r('app.media.pic1'),
    price: 120
  },
  {
    titleId: 1,
    titleName: '精选服饰',
    goodsId: 4,
    goodsName: '精选服饰4',
    imgUrl: $r('app.media.pic1'),
    price: 130
  },
  {
    titleId: 1,
    titleName: '精选服饰',
    goodsId: 5,
    goodsName: '精选服饰5',
    imgUrl: $r('app.media.pic1'),
    price: 140
  },
  {
    titleId: 1,
    titleName: '精选服饰',
    goodsId: 6,
    goodsName: '精选服饰6',
    imgUrl: $r('app.media.pic1'),
    price: 150
  },
  {
    titleId: 1,
    titleName: '精选服饰',
    goodsId: 7,
    goodsName: '精选服饰7',
    imgUrl: $r('app.media.pic1'),
    price: 160
  },
  {
    titleId: 1,
    titleName: '精选服饰',
    goodsId: 8,
    goodsName: '精选服饰8',
    imgUrl: $r('app.media.pic1'),
    price: 170
  },
  {
    titleId: 2,
    titleName: '精选饰品',
    goodsId: 9,
    goodsName: '精选饰品1',
    imgUrl: $r('app.media.pic1'),
    price: 20
  },
  {
    titleId: 2,
    titleName: '精选饰品',
    goodsId: 10,
    goodsName: '精选饰品2',
    imgUrl: $r('app.media.pic1'),
    price: 30
  },
  {
    titleId: 2,
    titleName: '精选饰品',
    goodsId: 11,
    goodsName: '精选饰品3',
    imgUrl: $r('app.media.pic1'),
    price: 40
  },
  {
    titleId: 2,
    titleName: '精选饰品',
    goodsId: 12,
    goodsName: '精选饰品4',
    imgUrl: $r('app.media.pic1'),
    price: 50
  },
  {
    titleId: 2,
    titleName: '精选饰品',
    goodsId: 13,
    goodsName: '精选饰品5',
    imgUrl: $r('app.media.pic1'),
    price: 60
  },
  {
    titleId: 2,
    titleName: '精选饰品',
    goodsId: 14,
    goodsName: '精选饰品6',
    imgUrl: $r('app.media.pic1'),
    price: 70
  },
  {
    titleId: 2,
    titleName: '精选饰品',
    goodsId: 15,
    goodsName: '精选饰品7',
    imgUrl: $r('app.media.pic1'),
    price: 80
  },
  {
    titleId: 2,
    titleName: '精选饰品',
    goodsId: 16,
    goodsName: '精选饰品8',
    imgUrl: $r('app.media.pic1'),
    price: 90
  },
  {
    titleId: 3,
    titleName: '羽绒服',
    goodsId: 17,
    goodsName: '羽绒服1',
    imgUrl: $r('app.media.pic1'),
    price: 399
  },
  {
    titleId: 3,
    titleName: '羽绒服',
    goodsId: 18,
    goodsName: '羽绒服2',
    imgUrl: $r('app.media.pic1'),
    price: 499
  },
  {
    titleId: 3,
    titleName: '羽绒服',
    goodsId: 19,
    goodsName: '羽绒服3',
    imgUrl: $r('app.media.pic1'),
    price: 550
  },
  {
    titleId: 3,
    titleName: '羽绒服',
    goodsId: 20,
    goodsName: '羽绒服4',
    imgUrl: $r('app.media.pic1'),
    price: 599
  },
  {
    titleId: 3,
    titleName: '羽绒服',
    goodsId: 21,
    goodsName: '羽绒服5',
    imgUrl: $r('app.media.pic1'),
    price: 650
  },
  {
    titleId: 3,
    titleName: '羽绒服',
    goodsId: 22,
    goodsName: '羽绒服6',
    imgUrl: $r('app.media.pic1'),
    price: 699
  },
  {
    titleId: 4,
    titleName: '休闲鞋',
    goodsId: 23,
    goodsName: '休闲鞋1',
    imgUrl: $r('app.media.pic1'),
    price: 750
  },
  {
    titleId: 4,
    titleName: '休闲鞋',
    goodsId: 24,
    goodsName: '休闲鞋2',
    imgUrl: $r('app.media.pic1'),
    price: 799
  },
  {
    titleId: 4,
    titleName: '休闲鞋',
    goodsId: 25,
    goodsName: '休闲鞋3',
    imgUrl: $r('app.media.pic1'),
    price: 850
  },
  {
    titleId: 4,
    titleName: '休闲鞋',
    goodsId: 26,
    goodsName: '休闲鞋4',
    imgUrl: $r('app.media.pic1'),
    price: 899
  },
  {
    titleId: 4,
    titleName: '休闲鞋',
    goodsId: 27,
    goodsName: '休闲鞋5',
    imgUrl: $r('app.media.pic1'),
    price: 950
  },
  {
    titleId: 4,
    titleName: '休闲鞋',
    goodsId: 28,
    goodsName: '休闲鞋6',
    imgUrl: $r('app.media.pic1'),
    price: 999
  },
  {
    titleId: 5,
    titleName: '上衣',
    goodsId: 29,
    goodsName: '上衣1',
    imgUrl: $r('app.media.pic1'),
    price: 199
  },
  {
    titleId: 5,
    titleName: '上衣',
    goodsId: 30,
    goodsName: '上衣2',
    imgUrl: $r('app.media.pic1'),
    price: 219
  },
  {
    titleId: 5,
    titleName: '上衣',
    goodsId: 31,
    goodsName: '上衣3',
    imgUrl: $r('app.media.pic1'),
    price: 239
  },
  {
    titleId: 5,
    titleName: '上衣',
    goodsId: 32,
    goodsName: '上衣4',
    imgUrl: $r('app.media.pic1'),
    price: 259
  },
  {
    titleId: 5,
    titleName: '上衣',
    goodsId: 33,
    goodsName: '上衣5',
    imgUrl: $r('app.media.pic1'),
    price: 279
  },
  {
    titleId: 5,
    titleName: '上衣',
    goodsId: 34,
    goodsName: '上衣6',
    imgUrl: $r('app.media.pic1'),
    price: 299
  },
  {
    titleId: 5,
    titleName: '上衣',
    goodsId: 35,
    goodsName: '上衣7',
    imgUrl: $r('app.media.pic1'),
    price: 399
  },
  {
    titleId: 6,
    titleName: '裤子',
    goodsId: 36,
    goodsName: '裤子1',
    imgUrl: $r('app.media.pic1'),
    price: 99
  },
  {
    titleId: 6,
    titleName: '裤子',
    goodsId: 37,
    goodsName: '裤子2',
    imgUrl: $r('app.media.pic1'),
    price: 109
  },
  {
    titleId: 6,
    titleName: '裤子',
    goodsId: 38,
    goodsName: '裤子3',
    imgUrl: $r('app.media.pic1'),
    price: 119
  },
  {
    titleId: 6,
    titleName: '裤子',
    goodsId: 39,
    goodsName: '裤子4',
    imgUrl: $r('app.media.pic1'),
    price: 129
  },
  {
    titleId: 6,
    titleName: '裤子',
    goodsId: 40,
    goodsName: '裤子5',
    imgUrl: $r('app.media.pic1'),
    price: 139
  },
  {
    titleId: 6,
    titleName: '裤子',
    goodsId: 41,
    goodsName: '裤子6',
    imgUrl: $r('app.media.pic1'),
    price: 149
  },
  {
    titleId: 6,
    titleName: '裤子',
    goodsId: 42,
    goodsName: '裤子7',
    imgUrl: $r('app.media.pic1'),
    price: 159
  },
  {
    titleId: 7,
    titleName: '运动搭配',
    goodsId: 43,
    goodsName: '运动搭配1',
    imgUrl: $r('app.media.pic1'),
    price: 20
  },
  {
    titleId: 7,
    titleName: '运动搭配',
    goodsId: 44,
    goodsName: '运动搭配2',
    imgUrl: $r('app.media.pic1'),
    price: 30
  },
  {
    titleId: 7,
    titleName: '运动搭配',
    goodsId: 45,
    goodsName: '运动搭配3',
    imgUrl: $r('app.media.pic1'),
    price: 40
  },
  {
    titleId: 7,
    titleName: '运动搭配',
    goodsId: 46,
    goodsName: '运动搭配4',
    imgUrl: $r('app.media.pic1'),
    price: 50
  },
  {
    titleId: 7,
    titleName: '运动搭配',
    goodsId: 47,
    goodsName: '运动搭配5',
    imgUrl: $r('app.media.pic1'),
    price: 60
  },
  {
    titleId: 8,
    titleName: '明星同款',
    goodsId: 48,
    goodsName: '明星同款1',
    imgUrl: $r('app.media.pic1'),
    price: 1000
  },
  {
    titleId: 8,
    titleName: '明星同款',
    goodsId: 49,
    goodsName: '明星同款2',
    imgUrl: $r('app.media.pic1'),
    price: 1100
  },
  {
    titleId: 8,
    titleName: '明星同款',
    goodsId: 50,
    goodsName: '明星同款3',
    imgUrl: $r('app.media.pic1'),
    price: 1200
  },
  {
    titleId: 8,
    titleName: '明星同款',
    goodsId: 51,
    goodsName: '明星同款4',
    imgUrl: $r('app.media.pic1'),
    price: 1300
  },
  {
    titleId: 8,
    titleName: '明星同款',
    goodsId: 52,
    goodsName: '明星同款5',
    imgUrl: $r('app.media.pic1'),
    price: 1400
  },
  {
    titleId: 8,
    titleName: '明星同款',
    goodsId: 53,
    goodsName: '明星同款6',
    imgUrl: $r('app.media.pic1'),
    price: 1500
  },
  {
    titleId: 8,
    titleName: '明星同款',
    goodsId: 54,
    goodsName: '明星同款7',
    imgUrl: $r('app.media.pic1'),
    price: 1600
  },
  {
    titleId: 8,
    titleName: '明星同款',
    goodsId: 55,
    goodsName: '明星同款8',
    imgUrl: $r('app.media.pic1'),
    price: 1700
  },
]

