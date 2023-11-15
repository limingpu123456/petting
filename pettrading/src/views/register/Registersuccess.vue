<!---->
<template>
  <div class='registersuccess'>
    <div class="hook">
      <transition name="shiledhook">
        <div class="shield" v-if="show"></div>
      </transition>
      <img src="~assets/img/success/hook.png" alt="">
    </div>
    <div class="but">
      <el-button type="primary" @click="finish">去登录</el-button>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Registersuccess',
    data () {
      return {
        show: true
      }
    },
    mounted() {
      setTimeout(this.changeshow,1000)
    },
    methods: {
      changeshow() {
        this.show = false
      },
      finish() {
        if(this.$route.path === '/register') {
          this.$router.push('/login')
        } else {
          this.$store.state.regshow = false
          this.$store.state.logshow = true
        }
      }
    }
  }
</script>
<style scoped>

.hook {
  position: relative;
  width: 10em;
  height: 10em;
  margin: 40px auto;
}

.shield {
  position: absolute;
  right: 2em;
  top: 2.5em;
  width: 5.5em;
  height: 6em;
  /* background: rgb(197, 89, 89); */
  background: rgb(242, 242, 242);
}

.shiledhook-leave-active {
  transition: all 1s;
}

.shiledhook-leave-to {
  width: 0px;
}

.but {
  display: flex;
  justify-content: center;
}
</style>