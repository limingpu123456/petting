<!---->
<template>
  <div class='usercenters'>
    <breadcrumb>{{$route.meta.title}}</breadcrumb>
    <div class="navmeun container">
      <div :class="{active: isactive('/usercenters/user/')}" @click="toactive('/usercenters')">个人中心</div>
      <div :class="{active: this.$route.path === '/usercenters/petorder'}" @click="toactive('/usercenters/petorder')">我的订单</div>
      <div :class="{active: this.$route.path === '/usercenters/pet'}" @click="toactive('/usercenters/pet')">我的宠物</div>
    </div>
    <div>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>

  import Breadcrumb from 'components/common/breadcrumb/Breadcrumb.vue'

  export default {
    name: 'Usercenters',
    components: {
      Breadcrumb
    },
    data () {
      return {}
    },
    methods: {
      toactive(url) {
        this.$router.push(url)
      },
      isactive(url) {
        let index = this.$route.path.indexOf(url)
        if(index === -1) {
          return false
        }else {
          return true
        }
      }
    }
  }
</script>
<style scoped>
@import "~assets/css/mediacss.css";

.navmeun {
  display: flex;
  height: 2em;
  justify-content: space-around;
  margin-top: 10em;
  margin-bottom: 5em;
}

.navmeun div {
  font-size: 1.6em;
  color: rgb(173, 147, 179);
  height: 2em;
  width: 5em;
  text-align: center;
  line-height: 2em;
  border-radius: 1em;
  cursor: pointer;
}

.navmeun div:hover {
  color: rgb(48, 49, 51);
  border: 1px solid rgb(64, 158, 255);
}

.navmeun .active {
  color: rgb(48, 49, 51);
  /* border: 1px solid rgb(64, 158, 255); */
  background: rgb(64, 158, 255);
}

</style>