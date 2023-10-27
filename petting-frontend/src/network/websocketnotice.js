export function createwebsocketnotice(uid) {
    let websocket = null
    //判断当前浏览器是否支持WebSocket
  if("WebSocket" in window) {
    // console.log('建立连接')
    websocket = new WebSocket(
      "ws://localhost:8081/message/" + uid
    )
  }else {
    alert("不支持建立socket连接");
  }
  return websocket
}