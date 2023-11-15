<!---->
<template>
  <div class='drawer' v-if="$store.state.show">
    <!-- <el-drawer
      :visible.sync="show"
      direction="btt"
      size="70%"
      :before-close="close"
      :append-to-body="true"
      :with-header="false">
      <div class="mainbar">
        <div v-if="login">
          <login :login="login" :register="register" @toregister="toregister"></login>
        </div>
        <div v-if="register">
          <register :login="login" :register="register" @tologin="tologin"></register>
        </div>
      </div>
    </el-drawer> -->
    <div class="close" @click="close">点击此处关闭</div>
    <div class="drawerborder" v-if="$store.state.show">
      <div class="mainbar">
        <div v-if="$store.state.logshow">
        <!-- <login @toregister="toregister"></login> -->
          <!-- <div>前往登录页面</div> -->
          <login></login>
        </div>
        <div v-if="$store.state.regshow">
        <!-- <register @tologin="tologin"></register> -->
          <register></register>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import Login from "views/login/Login.vue"
  import Register from "views/register/Register.vue"

  export default {
    name: 'Drawer',
    // props: ['show','login','register'],
    components: {
      Login,
      Register
    },
    data () {
      return {
      }
    },
    methods: {
      close() {
        this.$store.state.show = false;
        this.$store.state.logshow = false;
        this.$store.state.regshow = false;
      }
      // close() {
      //   this.$emit('update:show',false);
      //   this.$emit('update:login',false);
      //   this.$emit('update:register',false);
      // },
      // toregister() {
      //   this.$store.state.logshow = false;
      //   this.$store.state.regshow = false;
      // },
      // tologin() {
      //   this.$emit('update:login',true);
      //   this.$emit('update:register',false);
      // }
    },
  }
</script>
<style scoped>
.drawer {
  position: fixed;
  top: 0px;
  width: 100%;
  height: 100%;
  background: rgba(146, 143, 143, 0.5);
  z-index: 10;
}

.close {
  position: fixed;
  top: 0px;
  width: 100%;
  height: 30vh;
  font-size: 3em;
  color: rgb(223, 219, 219);
  text-align: center;
  line-height: 40vh;
  cursor: pointer;
}

/* .mainbar {
  width: 100%;
  height: 100%;
  padding-top: 2em;
  background: rgb(242, 242, 242);
} */

.mainbar {
  position: fixed;
  bottom: 0px;
  width: 100%;
  height: 70vh;
  padding-top: 2em;
  background: rgb(242, 242, 242);
}
</style>