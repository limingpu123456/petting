<!---->
<template>
  <div class='chat'>
    <div class="chatbar">
      <div class="chattop">
        <div>聊天室</div>
        <div>{{activeuser.username}}</div>
        <div class="close" @click="$store.state.showchat = false">退出</div>
      </div>
      <div class="userlists">
        <div :class="{activeuser: active === index}" class="chatuser" v-for="(item,index) in chatuser" :key="index" @click="toactive(index,item)">
            <el-badge :value="item.noread" :hidden="active == index || item.noread == 0">
              <div class="useravatar">
                <img :src="'/api/' + item.avatar" alt="">
              </div>
            </el-badge>
            <div class="username">{{item.username}}</div>
        </div>
      </div>
      <div class="chatmessagebar" v-if="show == false">
        <div class="tip">
          选择联系人开始聊天
        </div>
      </div>
      <div class="chatmessagebar" v-if="show == true">
        <div class="allmessage" id="allmessage">
          <div v-for="(item,index) in messagelist" :key="index">
            <div class="chatmessageleft" v-if="item.fromuid == activeuser.uid && item.touid == $store.state.uid">
                <div class="useravatar">
                  <img :src="'/api/' + item.fromavatar" alt="">
                </div>
                <div @click="todetail(item)" :class="{chatmessage: true,link: item.type != 0}" v-html="item.msg">{{item.msg}}</div>
            </div>
            <div class="chatmessageright" v-if="item.fromuid == $store.state.uid && item.touid == activeuser.uid">
              <div @click="todetail(item)" :class="{mychatmessage: true,link: item.type != 0}" v-html="item.msg">{{item.msg}}</div>
              <div class="useravatar">
                <img :src="'/api/' + item.fromavatar" alt="">
              </div>
            </div>
          </div>
        </div>
        <div class="inputbar">
          <textarea v-model="form.message"></textarea>
          <button class="but" @click="send">发送</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import {requestupdatecontact} from 'network/requestContact.js'

  export default {
    name: 'Chat',
    props: ['chatuser','messagelist','active','activeuser'],
    inject: ['reload'],
    data () {
      return {
        show: false,
        form: {
          type: 0,
          message: '',
          touid: ''
        },
      }
    },
    mounted() {
      // 聊天定位到底部
      if(this.show == false && this.active != null) {
        this.show = true
      }
    },
    updated() {
      // 聊天定位到底部
      if(this.show == true) {
        this.tobottom()
      }
    },
    methods: {
      tobottom() {
        let ele = document.getElementById('allmessage')
        ele.scrollTop = ele.scrollHeight;
      },
      send() {
        if(this.form.message == ""){
          this.$message({
            message: "信息不能为空",
            type: "error",
            center: true,
            showClose:true
          })
        }else {
          this.form.touid = this.activeuser.uid
          this.$emit("send", this.form)
          this.form.message = ""
          this.form.touid = ""
        }
      },
      toactive(index,item) {
        this.$emit("update:active",index)
        this.$emit("update:activeuser",item)
        this.show = true
        if(item.noread != 0){
          requestupdatecontact({
            cid: item.cid,
            noread: 0
          }).then(res => {
            this.$emit("clearnoread",index)
          }).catch(err => {
            console.log(err)
          })
        }
      },
      todetail(item) {
        if(item.type != 0) {
          this.$store.state.showchat = false
          if(this.$route.path != "/detail") {
            this.$router.push({
              path: '/detail',
              query: {
                pid: item.pid
              }
            })
          } else {
            if(this.$route.query.pid != item.pid) {
              this.$router.push({
                path: '/detail',
                query: {
                  pid: item.pid
                }
              })
              this.reload()
            }else {
              this.reload()
            }
          }
        }
      }
    }
  }
</script>
<style scoped>

.chatbar {
  position: fixed;
  top: 19vh;
  left: 28vw;
  display: flex;
  flex-wrap: wrap;
  width: 44vw;
  height: 62vh;
  background: rgb(255, 255, 255);
  border-radius: 1em;
  box-shadow: 0px 0px 10px rgb(60, 64, 67);
  overflow: hidden;
}

.close {
  cursor: pointer;
}

.close:hover {
  color: red;
}

.chattop {
  display: flex;
  justify-content: space-between;
  width: 100%;
  height: 3em;
  line-height: 3em;
  padding-left: 1em;
  padding-right: 1em;
  border-bottom: 1px solid rgb(205, 211, 216);
}

.userlists {
  width: 30%;
  height: calc(100% - 3em);
  overflow-y: auto;
  background: rgb(227, 224, 223);
  border-right: 1px solid rgb(205, 211, 216);
}

.chatuser {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 3.7em;
  /* line-height: 3em; */
  /* text-align: center; */
  border-bottom: 1px solid rgb(205, 211, 216);
  cursor: pointer;
}

.chatuser:hover {
  background: rgb(184, 183, 188);
}

.username {
  margin-left: 0.5em;
}

.activeuser {
  color: rgb(62, 131, 241);
  background: rgb(202, 202, 202);
}

.chatmessagebar {
  position: relative;
  width: 70%;
  height: calc(100% - 3em);
  background: rgba(245, 245, 245);
}

.tip {
  display: flex;
  justify-content: center;
  color: rgb(185, 184, 189);
}

.allmessage {
  height: calc(100% - 7em);
  overflow-y: auto;
}

.chatmessageleft {
  display: flex;
  margin-top: 0.5em;
  margin-bottom: 0.5em;
  padding-left: 0.5em;
}

.chatmessageright {
  display: flex;
  justify-content: flex-end;
  margin-top: 0.5em;
  margin-bottom: 0.5em;
  padding-right: 0.5em;
}

.useravatar {
  width: 2.5em;
  height: 2.5em;
  border-radius: 50%;
  overflow: hidden;
}

.useravatar img {
  width: 100%;
}

.chatmessage {
  max-width: 60%;
  line-height: 2.5em;
  background: rgba(255, 255, 255);
  border-radius: 10px;
  margin-left: 5px;
  margin-right: 5px;
  padding-left: 0.5em;
  padding-right: 0.5em;
  word-wrap: break-word;
  border: 1.5px solid rgb(237, 237, 237);
  white-space: pre-wrap;
}

.link {
  color: rgb(64, 158, 255);
  cursor: pointer;
}

.link:hover {
  color: rgb(255, 144, 1);
}

.mychatmessage {
  max-width: 60%;
  line-height: 2.5em;
  background: rgb(158, 234, 106);
  border-radius: 10px;
  margin-left: 5px;
  margin-right: 5px;
  padding-left: 0.5em;
  padding-right: 0.5em;
  word-wrap: break-word;
  border: 1.5px solid rgb(237, 237, 237);
  white-space: pre-wrap;
}

.inputbar {
  width: 100%;
  position: absolute;
  line-height: 1em;
  bottom: 0px;
  background: rgb(255, 255, 255);
  display: hidden;
  border: 1px solid rgb(229, 229, 229);
}

.inputbar textarea {
  width: 100%;
  height: 5em;
  padding: 0.5em;
  font-size: 1.2em;
  line-height: 2em;
  border: 0;
  outline: none;
  resize: none;
}

.but {
  width: 5em;
  height: 2em;
  border-radius: 1em;
  float: right;
  margin-right: 1em;
  margin-bottom: 0.5em;
  background: rgb(245, 245, 245);
  border: 1px solid rgb(229, 229, 229);
}

.but:hover {
  background: rgb(18, 150, 17);
  color: rgb(255, 255, 255);
}
</style>