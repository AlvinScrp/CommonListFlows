import { display } from "@kit.ArkUI";

// 设计稿宽度
const DRAFT_WIDTH = 375

let screenWidthVp: number = -1;

// 将元素按照原来比例进行转化
export function rvp(val: number) {
  if (screenWidthVp === -1) {
    screenWidthVp = getScreenWidthVp()
  }
  return val / DRAFT_WIDTH * screenWidthVp
}


export function getScreenWidthVp(): number {
  return px2vp(getScreenWidthPx())
}

export function getScreenWidthPx(): number {
  let screenWidth: number = AppStorage.get('screenWidth') || 0
  try {
    if (screenWidth <= 0) {
      screenWidth = display.getDefaultDisplaySync().width
      AppStorage.setOrCreate('screenWidth', screenWidth)
      console.log("windowTopHeight " + screenWidth)
    }
  } catch (e) {

  }
  return screenWidth
}
