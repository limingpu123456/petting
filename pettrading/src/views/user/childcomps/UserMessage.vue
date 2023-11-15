<!---->
<template>
  <div class='usermessage'>
    <div class="user-img">
      <img :src="$store.state.avatar" alt="">
    </div>
    <div class="mescontent">
      <ul>
        <!-- 用户名 -->
        <li>
          <p class="type">用户名</p>
          <div class="inp">
            <img src="~assets/img/user/user.png" alt class="img-bg" />
            <input readonly="true" type="text" v-model="username" />
          </div>
        </li>
        <!-- 真实姓名 -->
        <li>
          <p class="type">真实姓名 </p>
          <div class="inp">
          <img src="~assets/img/user/user.png" alt class="img-bg" />
          <input
            readonly="true"
            type="text"
            v-model="realname"
          />
        </div>
        <!-- 身份证号 -->
        </li>
        <li>
          <p class="type">身份证号 </p>
          <div class="inp">
            <img src="~assets/img/user/idcard.png" alt class="img-bg" />
            <input
              readonly="true"
              type="text"
              v-model="idcard"
            />
          </div>
        </li>
        <!-- 性别 -->
        <li>
          <p class="type">性别 </p>
          <div class="inp">
            <img src="~assets/img/user/sex.png" alt class="img-bg" />
            <input
              readonly="true"
              type="text"
              v-model="sex"
            />
          </div>
        </li>
        <!-- 手机号 -->
        <li>
          <p class="type">手机号 </p>
          <div class="inp">
            <img src="~assets/img/user/phone.png" alt class="img-bg" />
            <input
              readonly="true"
              type="text"
              v-model="tel"
            />
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
  import {requestqueryuser} from 'network/requestuser.js'

  export default {
    name: 'UserMessage',
    data () {
      return {
        userimg: '',
        username: '',
        realname: '',
        idcard: '',
        sex: '',
        tel: '',
      }
    },
    created() {
      requestqueryuser({
        uid: this.$store.state.uid
      }).then(res => {
        this.userimg = res.avatar;
        this.username = res.username;
        this.realname = res.realname;
        this.idcard = res.idcard;
        this.sex = res.sex;
        this.tel = res.telphone;
      }).catch(err =>{
        console.log(err);
      })
    }
  }
</script>
<style scoped>

.user-img{
  margin: 0 auto;
  width: 104px;
  height: 104px;
  border-radius: 50%;
  margin-top: 20px;
  margin-bottom: 20px;
  overflow: hidden;
}

.user-img img{
  width: 100%;
  height: 100%;
}

.mescontent{
  width: 800px;
  margin: 20px auto;
}

.mescontent ul li{
  margin-top: 10px;
  float: left;
}

input,button{
  border: 0;
  outline: none;
}

.type {
  height: 36px;
  line-height: 36px;
  margin-left: 20px;
}

.inp {
  position: relative;
  margin-left: 20px;
}

.inp img {
  width: 16px;
}

.img-bg {
  position: absolute;
  top: 9px;
  left: 13px;
}

.inp input {
  height: 36px;
  width: 366px;
  border-radius: 18px;
  padding-left: 35px;
  border: 1.3px solid rgb(220, 223, 230);
}
</style>