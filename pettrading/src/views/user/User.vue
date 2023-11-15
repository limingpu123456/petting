<!---->
<template>
  <div class='user'>
    <div class="usermain container">
      <div class="userbar">
        <div :class="{active: $route.path === '/usercenters/user/message'}" @click="$router.push('/usercenters')">个人信息</div>
        <div :class="{active: $route.path === '/usercenters/user/changemessage'}" @click="$router.push('/usercenters/user/changemessage')">修改资料</div>
        <div :class="{active: $route.path === '/usercenters/user/userplace'}" @click="$router.push('/usercenters/user/userplace')">地址管理</div>
        <div :class="{active: $route.path === '/usercenters/user/safety'}" @click="$router.push('/usercenters/user/safety')">安全中心</div>
        <div @click="tologout">注销</div>
      </div>
      <div class="views">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
  import bus from "store/bus.js"

  import Breadcrumb from "components/common/breadcrumb/Breadcrumb.vue"
  import UserPet from "views/user/childcomps/UserPet.vue"

  export default {
    name: 'User',
    components: {
      Breadcrumb,
      UserPet
    },
    data () {
      return {}
    },
    methods: {
      //注销
      tologout() {
        this.$confirm('确定要退出登录？', '注销', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning',
          center: true
        }).then(() => {
          this.$router.push('/home');
          this.$store.commit('setuid',null);
          window.sessionStorage.removeItem("uid");
          this.$store.commit('setavatar',null);
          window.sessionStorage.removeItem("avatar");
          bus.$emit('detail-chat',contactuser);
        }).catch(() => {
        });
      }
    }
  }
</script>
<style scoped>
@import "~assets/css/mediacss.css";

.usermain {
  display: flex;
  border-radius: 1em;
  /* margin-top: 3em; */
  overflow: hidden;
}

.userbar {
  width: 8em;
  height: 30em;
  color: rgb(240, 242, 245);
  font-size: 1.8em;
  text-align: center;
  background: rgba(84, 92, 100);
  cursor: pointer;
}

.active {
  color:rgb(255, 113, 129);
}

.userbar div{
  height: 3em;
  line-height: 3em;
}

.userbar div:hover {
  background: rgb(67, 74, 80);
}

.views{
  width: 100%;
  height: 45em;
  overflow: auto;
  background: rgb(255, 255, 255);
}
</style>