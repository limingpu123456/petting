<!---->
<template>
  <div class='headtab'>
    <div class="headmain container">
      <div class="logo" @click="tohome()">Pet Shop</div>
      <div class="list" v-for="(item,index) in lists" :key="index" :class="{active: $route.path === lists[index].path}" @click="torouter(index)">
        {{item.title}}
      </div>
      <div class="right">
        <div v-if="$store.state.uid === null">
          <span class="loginbut" @click="showlogin">登录</span>
          <span @click="showregister">注册</span>
        </div>
        <div v-if="$store.state.uid != null" class="last">
          <div class="notice" @click="changeshowchat">
            <el-badge :value="noread" :hidden="noread === 0">
              <div class="notimg">
                <img src="~assets/img/notice/notice.png" alt="">
              </div>
            </el-badge>
          </div>
          <div @mouseover="showdropdown = true" @mouseleave="showdropdown = false">
            <div class="wid">
              <div class="avatar" @click="$router.push('/usercenters')">
                <img :src="$store.state.avatar" alt="">
              </div>
              </div>
              <transition name="showdrop">
                <div v-if="showdropdown">
                  <div class="triangle"></div>
                  <div class="useraction">
                    <div class="blank"></div>
                    <div @click="$router.push('/usercenters')">个人中心</div>
                    <!-- <div @click="$router.push('/user/changemessage')">修改资料</div>
                    <div @click="$router.push('/user/userplace')">地址管理</div>
                    <div @click="$router.push('/user/safety')">安全中心</div> -->
                    <div @click="$router.push('/usercenters/petorder')">我的订单</div>
                    <div @click="$router.push('/usercenters/pet')">我的宠物</div>
                    <div @click="tologout">注销</div>
                  </div>
                </div>
              </transition>
          </div>
        </div>
      </div>
    </div>
    <!-- <keep-alive> -->
      <chat :chatuser="chatuser" :messagelist="messagelist" :active.sync="active" :activeuser.sync="activeuser" @send="send" 
      @clearnoread="clearnoread" v-if="$store.state.showchat == true"></chat>
    <!-- </keep-alive> -->
  </div>
</template>

<script>
  import {requestupdatecontact,requestaddContact} from "network/requestContact.js"
  import {requestquerycontactuser} from "network/requestuser.js"
  import {requestqueryusernotice} from "network/requestnotice.js"
  import {createwebsocketnotice} from "network/websocketnotice.js"

  import bus from 'store/bus.js'

  import Drawer from "components/content/drawer/Drawer.vue"
  import Chat from "views/chat/Chat.vue"

  export default {
    name: 'HeadTab',
    components: {
      Drawer,
      Chat
    },
    data () {
      return {
        activeuser: {},
        websocket: null,
        noread: 0,
        active: null,
        activeuser: {},
        chatuser: [],
        messagelist: [],
        lists: [{
            title: "首页",
            path: "/home"
          },
          {
            title: "买卖专区",
            path: "/presell"
          },
          {
            title: "求购专区",
            path: "/buying"
          },{
            title: "关于",
            path: "/about"
          }
        ],
        showdropdown: false,
        lockReconnect: false, //是否真正建立连接
        timeout: 25*1000,//30秒一次心跳
        timeoutObj: null,//心跳心跳倒计时
        serverTimeoutObj: null,//心跳倒计时
        timeoutnum: null,//断开 重连倒计时
      }
    },
    mounted() {
      bus.$on('detail-chat',data => {
        let activeindex = null
        this.chatuser.forEach((value,index,array) => {
          if(array[index].uid == data.uid) {
            activeindex = index
          }
        })
        if(activeindex == null) {
          this.chatuser.push(data)
          this.active = this.chatuser.length - 1
          this.activeuser = data
        }else {
          this.active = activeindex
          this.activeuser = this.chatuser[activeindex]
          if(this.activeuser.noread != 0) {
            requestupdatecontact({
              noread: 0,
              cid: this.activeuser.cid
            }).then(res => {
              this.clearnoread(activeindex)
            }).catch(err => {
              console.log(err)
            })
          }
        }
      })
      bus.$on('purchase',data => {
        this.sendpet(data)
      })
      bus.$on('logout',data => {
        this.destroywebsocket();
      })
    },
    updated() {
      if(this.$store.state.uid != null) {
        if(this.websocket == null) {
          this.createwebsocket()
          // 查找最近联系人
          requestquerycontactuser({
            uid: this.$store.state.uid
          }).then(res => {
            this.chatuser = res
          }).catch(err => {
            console.log(err)
          })
          //查找所有聊天记录
          requestqueryusernotice({
            uid: this.$store.state.uid
          }).then(res => {
            this.messagelist = res
          }).catch(err => {
            console.log(err)
          })
        }
      }
    },
    methods: {
      //建立websocket连接
      createwebsocket() {
        this.websocket = createwebsocketnotice(this.$store.state.uid)
        var that = this;
        this.websocket.onopen = function() {
          that.websocket.send("heartCheck");
          //开始心跳
          that.start();
        };
        //接收到消息的回调方法
        this.websocket.onmessage = function(event) {
          if(event.data != "heartCheck") {
            let object = JSON.parse(event.data)
            // console.log(object);
            if(object.type == -1) {
              that.noread = object.noread
            } else {
              that.messagelist.push(object)
              if(that.$store.state.uid != object.fromuid) {
                if(that.$store.state.showchat == true) {
                  if(that.activeuser.uid == object.fromuid) {
                    requestupdatecontact({
                      cid: that.activeuser.cid,
                      noread: 0
                    }).then(res => {
                    }).catch(err => {
                      console.log(err)
                    })
                  } else {
                    // 查找最近联系人
                    requestquerycontactuser({
                      uid: that.$store.state.uid
                    }).then(res => {
                      that.chatuser = res
                      if(that.active != null) {
                        that.activeuser = that.chatuser[that.active]
                      }
                      that.noread++
                    }).catch(err => {
                      console.log(err)
                    })
                  }
                }else {
                  // 查找最近联系人
                  requestquerycontactuser({
                    uid: that.$store.state.uid
                  }).then(res => {
                    that.chatuser = res
                    if(that.active != null) {
                      that.activeuser = that.chatuser[that.active]
                    }
                    // console.log(that.activeuser)
                    // console.log(res)

                    // console.log(that.chatuser)
                    that.noread++
                  }).catch(err => {
                    console.log(err)
                  })
                }
              }
              // console.log(that.messagelist)
            }
          }
          that.reset()
        };
        this.websocket.onclose = function(e) {
          // console.log('websocket 断开: ' + e.code + ' ' + e.reason + ' ' + e.wasClean)
          // console.log(e)
          // that.reconnect();
        }
        this.websocket.onerror = function () {
          console.log("出现错误")
          that.reconnect()
        }
      },
      //重新连接
      reconnect(){
        var that = this;
        if(that.lockReconnect){
          return;
        }
        that.lockReconnect = true;
        //没连接上会一直重连，设置延迟避免请求过多
        that.timeoutnum && clearTimeout(that.timeoutnum);
        that.timeoutnum = setTimeout(function () {
          //新连接
          that.createwebsocket();
          that.lockReconnect = false;
        },2000)
      },
      //重置心跳
      reset(){
        var that = this;
        //清除时间
        clearTimeout(that.timeoutObj);
        clearTimeout(that.serverTimeoutObj);
        //重启心跳
        that.start();
      },
      //开始心跳
      start() {
        var self = this;
        self.timeoutObj && clearTimeout(self.timeoutObj);
        self.serverTimeoutObj && clearTimeout(self.serverTimeoutObj);
        self.timeoutObj = setTimeout(function () {
          //这里发送一个心跳，后端收到后，返回一个心跳信息
          if(self.websocket.readyState == 1) {
            //如果连接正常
            self.websocket.send("heartCheck");
          }else {
            //否则重连
            self.reconnect();
          }
          self.serverTimeoutObj = setTimeout(function() {
            //如果超过一定时间还没重置，说明后端主动断开了,超时关闭
            self.websocket.close();
          },self.timeout);
        },self.timeout)
      },
      destroywebsocket(){
        if(this.websocket){
          this.lockReconnect = false
          this.timeoutnum && clearTimeout(this.timeoutnum);
          this.timeoutObj && clearTimeout(this.timeoutObj);
          this.serverTimeoutObj && clearTimeout(this.serverTimeoutObj);
          this.websocket.close()
          this.websocket = null
        }
      },
      tohome() {
        this.$router.push('/home');
      },
      torouter(index) {
        this.$router.push(this.lists[index].path);
      },
      showlogin() {
        if(this.$route.path != '/login' && this.$route.path != '/register'){
          this.$store.state.show = true;
          this.$store.state.logshow = true;
        }else {
          this.$router.push('/login');
        }
      },
      showregister() {
        if(this.$route.path != '/login' && this.$route.path != '/register'){
          this.$store.state.show = true;
          this.$store.state.regshow = true;
        }else {
          this.$router.push('/register');
        }
      },
      //注销
      tologout() {
        this.$confirm('确定要退出登录？', '注销', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning',
          center: true
        }).then(() => {
          if(this.$route.path.indexOf("/home") == -1 || this.$route.path.indexOf("/presell") == -1 || this.$route.path.indexOf("/buying") == -1){
            this.$router.push('/home');
          }
          this.$store.commit('setuid',null);
          window.sessionStorage.removeItem("uid");
          this.$store.commit('setavatar',null);
          window.sessionStorage.removeItem("avatar");
          this.destroywebsocket();
        }).catch(() => {
        });
      },
      sendpet(form) {
        var msg = {type: form.type ,fromavatar: this.$store.state.avatar.substring(5) ,msg: form.msg, touid: form.touid , pid: form.pid}
        this.websocket.send(JSON.stringify(msg))
        console.log("发送成功")
      },
      send(form) {
        var msg = {type: form.type ,fromavatar: this.$store.state.avatar.substring(5) ,msg: form.message, touid: form.touid}
        this.websocket.send(JSON.stringify(msg))
      },
      clearnoread(index) {
        this.noread = this.noread - this.chatuser[index].noread
        this.chatuser[index].noread = 0
        this.activeuser.noread = 0
      },
      changeshowchat() {
        if(this.$store.state.showchat == false && this.active != null) {
          if(this.activeuser.noread != 0) {
            this.clearnoread(this.active)
            requestupdatecontact({
              cid: this.activeuser.cid,
              noread: 0
            }).then(res => {
            }).catch(err => {
              console.log(err)
            })
          }
        }
        this.$store.state.showchat = !this.$store.state.showchat
      }
    },
    destroyed() {
      if(this.websocket){
        this.websocket.close()
        this.websocket = null
      }
    },
  }
</script>
<style scoped>
@import "~assets/css/mediacss.css";

.headtab{
  background: rgba(184, 183, 188);
  position: fixed;
  top: 0;
  z-index: 9;
  width: 100%;
  height: 64px;
  line-height: 64px;
  font-size: 1.6em;
}

.headmain {
  display: flex;
  justify-content: space-between;
}

.logo {
  font-size: 1.5em;
  margin-left: 1em;
  cursor: pointer;
  height: 64px;
  overflow: hidden;
}

.list {
  height: 64px;
  overflow: hidden;
  cursor: pointer;
}

.list:hover {
  color: rgb(255, 93, 35);
}

.active {
  color: rgb(255, 93, 35);
}

.right {
  cursor: pointer;
  /* width: 5em; */
  text-align: center;
  margin-right: 1em;
}

.right span:hover {
  color: rgb(255, 93, 35);
}

.loginbut {
  margin-right: 0.5em;
}

.wid {
  width: 5em;
}

.avatar {
  margin: auto;
  margin-top: 11px;
  width: 41px;
  height: 41px;
  border-radius: 50%;
  overflow: hidden;
  text-align: center;
}

.avatar img {
  width: 100%;
  height: 100%;
}

.triangle {
  width: 0;
  height: 0;
  margin: auto;
  margin-top: 0.2em;
  border-left: 5px solid rgb(184, 183, 188);
  border-right: 5px solid rgb(184, 183, 188);
  border-bottom: 6px solid rgb(215, 214, 216);
}

.useraction {
  width: 5em;
  border-radius: 5px;
  overflow: hidden;
}

.useraction .blank {
  height: 0.5em;
}

.useraction .blank:hover {
  background: rgb(203, 204, 206);
}

.useraction div{
  height: 2.4em;
  line-height: 2.4em;
  background: rgb(203, 204, 206);
}

.useraction div:hover{
  background: rgb(184, 183, 188);
  color: rgb(92, 109, 204);
}

.showdrop-enter-active,
.showdrop-leave-active {
  transition: all 1s ease;
}

.showdrop-enter,
.showdrop-leave-to {
  opacity: 0;
}

.last {
  display: flex;
}

.notice {
  width: 1.3em;
  height: 1.3em;
  margin-right: 1em;
}

.notice img {
  width: 100%;
}

.notimg {
  line-height: 1.3em;
}

</style>