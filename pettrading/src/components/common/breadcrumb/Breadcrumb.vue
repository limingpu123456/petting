<!---->
<template>
  <div class='breadcrumb'>
    <div class="mainbar container">
      <div class="left">
        <span class="tohome" @click="tohome()">首页</span> >
        <span class="second">
          <slot name="second"></slot>
        </span>
        <slot></slot>
      </div>
      <!-- <div class="right">
        <input type="text">
      </div> -->
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Breadcrumb',
    data () {
      return {}
    },
    methods: {
      tohome() {
        this.$router.push('/home');
      }
    },
  }
</script>
<style scoped>
@import "~assets/css/mediacss.css";

.breadcrumb {
  width: 100%;
  background: rgb(255, 255, 255);
  /* border: 0.1px solid rgba(184, 183, 188, 0.5); */
  position: fixed;
  top: 64px;
  z-index: 8;
}

.mainbar {
  display: flex;
  justify-content: space-between;
  height: 38px;
  line-height: 38px;
  color: rgb(117, 117, 117);
  font-size: 1.3em;
}

.left {
  margin-left: 1em;
}

.tohome {
  cursor: pointer;
}

.second {
  cursor: pointer;
}

.right {
  margin-right: 1em;
}
</style>