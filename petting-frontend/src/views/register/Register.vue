<!---->
<template>
  <div class='register'>
    <el-steps :active="active" align-center :process-status="process" finish-status="success">
      <el-step title="注册账号"></el-step>
      <el-step title="实名验证"></el-step>
      <el-step title="完成注册"></el-step>
    </el-steps>
    <div v-if="active === 0">
      <register-user 
      @next="next" 
      :form.sync="form"
      ></register-user>
    </div>
    <div v-if="active === 1">
      <register-user-mes 
      :form.sync="form" 
      @next="next" 
      @previous="previous"
      @register="register"
      ></register-user-mes>
    </div>
    <div v-if="active === 2">
      <registersuccess></registersuccess>
    </div>
  </div>
</template>

<script>
  import RegisterUser from "views/register/RegisterUser.vue"
  import RegisterUserMes from "views/register/RegisterUserMes.vue"
  import Registersuccess from "views/register/Registersuccess.vue"
  import {requestregister} from "network/LRF.js";

  export default {
    name: 'Register',
    components: {
      RegisterUser,
      RegisterUserMes,
      Registersuccess
    },
    data () {
      return {
        active: 0,
        process: 'finish',
        form: {
          username: '',
          password: '',
          secondpassword: '',
          telphone: '',
          realname: '',
          idcard: ''
        }
      }
    },
    methods: {
      next(flag) {
        if(flag === 0){
          this.process = 'error'
        }else {
          if(this.active === 0){
            this.process = 'finish'
          }else {
            this.process = "success"
          }
          this.active++;
        }    
      },
      previous() {
        this.process = 'finish';
        this.active--;
      },
      register() {
        this.form.username = "用户"+this.form.telphone
        requestregister({
          username: this.form.username,
          password: this.form.password,
          telphone: this.form.telphone,
          realname: this.form.realname,
          idcard: this.form.idcard
        }).then(res => {
          this.$message({
            showClose: true,
            message: res.msg,
            type: 'success',
            center: true
          })
        }).catch(err => {
          console.log(err)
        })
      }
    },
  }
</script>
<style scoped>
.register {
  width: 25em;
  /* width: 30em; */
  /* text-align: center; */
  margin: auto;
  padding-bottom: 20em;
}


</style>