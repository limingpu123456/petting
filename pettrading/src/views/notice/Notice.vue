<!---->
<template>
  <div class='notice'>
    <div v-for="(item,index) in messageList" :key="index">{{item.name}}</div>
    <!-- <button @click="close">被关闭联机</button> -->
    <input type="text" v-model="message">
    <input type="text" v-model="touser">
    <div>
      <el-button type="primary" @click="send">发送</el-button>
    </div>
  </div>
</template>

<script>

  import {createwebsocketnotice} from "network/websocketnotice.js"

  export default {
    name: 'Notice',
    data () {
      return {
        websocket: null, //websocket对象
        messageList: [], //消息列表
        message: '',
        touser: ''
      }
    },
    mounted(){
      // this.websocket = createwebsocketnotice(this.$store.state.uid)
      //连接发生错误的回调方法
      this.websocket.onerror = function() {}
      //连接成功建立的回调方法
      this.websocket.onopen = function(event) {}
      //接收到消息的回调方法
      var that = this;
      this.websocket.onmessage = function(event) {
        //json字符串转对象，方法1
        // var object = eval("(" + event.data + ")");
        //json字符串转对象，方法2
        let object = JSON.parse(event.data)
        console.log(object);
        that.messageList.push(object);
      };
      //连接关闭的回调方法
      this.websocket.onclose = function() {
        console.log("连接关闭")
      };
    },
    methods: {
      send() {
        var msg = {msg: this.message, toUser: this.touser}
        this.websocket.send(JSON.stringify(msg))
      }
    //   close() {
    //       this.$store.commit('setwebscoketnotice',null);
    //       window.sessionStorage.removeItem("webscoketnotice");
    //   },
    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    },
    destroyed() {
      this.websocket.close();
    },
  }
</script>
<style scoped>
</style>