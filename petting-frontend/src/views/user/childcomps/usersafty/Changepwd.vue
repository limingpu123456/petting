<!---->
<template>
  <div class='changepwd'>
    <div>
      <!-- 旧密码 -->
      <div class="inp">
        <img src="~assets/img/password/password.png" alt class="img-bg" />
        <input :type="types[0].type" placeholder="旧密码" 
        @blur="checkoldpassword"
        v-model="form.oldpassword" 
        :class="{ redborder: check.oldpassword.flag }"
        />
        <img v-if="form.oldpassword != ''" @click="changetype(0)" :src="types[0].img" alt class="img-bg-right" />
        <p v-show="check.oldpassword.flag">{{check.oldpassword.val}}</p>
      </div>
      <!-- 新密码 -->
      <div class="inp">
        <img src="~assets/img/password/password.png" alt class="img-bg" />
        <input :type="types[1].type" placeholder="新密码" 
        @blur="checkPassword"
        v-model="form.password" 
        :class="{ redborder: check.password.flag }"
        />
        <img v-if="form.password != ''" @click="changetype(1)" :src="types[1].img" alt class="img-bg-right" />
        <p v-show="check.password.flag">{{check.password.val}}</p>
      </div>
      <!-- 确认密码 -->
      <div class="inp">
        <img src="~assets/img/password/password.png" alt class="img-bg" />
        <input :type="types[2].type" placeholder="再次输入新密码" 
        v-model="form.secondpassword" 
        @blur="checksecondpassword"
        :class="{ redborder: check.secondpassword.flag }"
        />
        <img v-if="form.secondpassword != ''" @click="changetype(2)" :src="types[2].img" alt class="img-bg-right" />
        <p v-show="check.secondpassword.flag">{{check.secondpassword.val}}</p>
      </div>
      <div class="but">
        <el-button type="primary" @click="request">确认更改</el-button>
      </div>
    </div>
  </div>
</template>

<script>
  import {requestchangepassword} from 'network/requestuser.js'

  export default {
    name: 'Changepwd',
    data () {
      return {
        types: [{
            type: 'password',
            img: require('assets/img/password/close.png')
          },{
            type: 'password',
            img: require('assets/img/password/close.png')
          },{
            type: 'password',
            img: require('assets/img/password/close.png')
          }
        ],
        form: {
          oldpassword: '',
          password: '',
          secondpassword: ''
        },
        // 验证flag和val
        check: {
          oldpassword: {
            flag: false,
            val: ''
          },
          password: {
            flag: false,
            val: ''
          },
          secondpassword: {
            flag: false,
            val: ''
          }
        }
      }
    },
    methods: {
      //改变密码框状态
      changetype(index) {
        if (this.types[index].type === "text") {
          this.types[index].img = require('assets/img/password/close.png')
          this.types[index].type = "password"
        } else {
          this.types[index].img = require('assets/img/password/open.png')
          this.types[index].type = 'text'
        }
      },
      //验证旧密码
      checkoldpassword() {
        if(this.form.oldpassword === ''){
          this.check.oldpassword.flag = true;
          this.check.oldpassword.val = '*旧密码不能为空';
        }else {
          this.check.oldpassword.flag = false;
        }
      },
      //验证密码
      checkPassword() {
        if(this.form.password === ''){
          this.check.password.flag = true;
          this.check.password.val = '*新密码不能为空';
        }else if(this.form.secondpassword != ''){
          this.checksecondpassword();
          this.check.password.flag = false;
        }else {
          this.check.password.flag = false;
        }
      },
      // 验证确认密码
      checksecondpassword() {
        if(this.form.secondpassword === ''){
          this.check.secondpassword.flag = true;
          this.check.secondpassword.val = '*确认密码不能为空';
        }else if(this.form.secondpassword != this.form.password) {
          this.check.secondpassword.flag = true;
          this.check.secondpassword.val = '*两次密码不一致';
        }else {
          this.check.secondpassword.flag = false;
        }
      },
      request(){
        this.checkoldpassword();
        this.checkPassword();
        this.checksecondpassword();
        if(this.check.oldpassword.flag == false && this.check.password.flag == false && this.check.secondpassword.flag == false){
          requestchangepassword({
            uid: this.$store.state.uid,
            oldpassword: this.form.oldpassword,
            password: this.form.password
          }).then(res => {
            if(res.flag === 1){
              this.form.oldpassword = '';
              this.form.password = '';
              this.form.secondpassword = '';
              this.$message({
                message: res.msg,
                type: 'success',
                center: true,
                showClose: true,
              })
            }else {
              this.$message({
                message: res.msg,
                type: 'error',
                center: true,
                showClose: true,
              })
            }
          }).catch(err => {
            console.log(err);
          })
        }
      }
    },
  }
</script>
<style scoped>
.inp {
  position: relative;
  width: 270px;
  height: 36px;
  margin: 20px auto;
  /* border: 1px solid red; */
}

.img-bg {
  position: absolute;
  top: 9px;
  left: 13px;
}

.img-bg-right {
  position: absolute;
  top: 9px;
  right: 15px;
  cursor: pointer;
}

input {
  height: 36px;
  width: 270px;
  border-radius: 18px;
  border: 0.5px solid rgb(221, 221, 226);
}

.inp input {
  padding-left: 35px;
}

.inp input:focus {
  border: 0.5px solid rgb(64, 158, 255);
}

.inp p {
  text-align: left;
  padding-left: 2em;
  font-size: 12px;
  color: rgba(255, 13, 13, 0.733);
}

.redborder {
  border: 0.5px solid rgb(245, 108, 108);
}

.but {
  display: flex;
  justify-content:space-around;
}
</style>