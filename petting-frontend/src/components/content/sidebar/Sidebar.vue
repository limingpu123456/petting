<!---->
<template>
  <div class='sidebar'>
    <el-tooltip class="item" effect="dark" content="发布想要出售宠物" placement="left">
      <button class="but" @click="tosell">出售</button>
    </el-tooltip>
    <el-tooltip class="item" effect="dark"  placement="left">
      <div slot="content">没找到想要的宠物？<br/>发布宠物请求试试</div>
      <button class="but" @click="tobuy">求购</button>
    </el-tooltip>
  </div>
</template>

<script>
  export default {
    name: 'Sidebar',
    data () {
      return {
      }
    },
    methods: {
      tobuy() {
        if(this.$store.state.uid === null) {
          this.$store.state.show = true;
          this.$store.state.logshow = true;
        }else {
          this.$router.push('/wantbuy');
        }
      },
      tosell() {
        if(this.$store.state.uid === null) {
          this.$store.state.show = true;
          this.$store.state.logshow = true;
        }else {
          this.$router.push('/wantsell');
        }
      }
    },
  }
</script>
<style scoped>

.sidebar {
  display: flex;
  flex-direction: column;
  position: fixed;
  top: 48%;
  right: 2.5em;
  z-index: 2;
}

.but {
  width: 3.3em;
  height: 3.3em;
  border-radius: 50%;
  margin: 0.5em;
  background: rgba(74, 138, 244, 0.7);
}

.but:hover {
  background: rgba(74, 138, 244, 0.5);
}
</style>