<!---->
<template>
  <div class='tail'>
    <div class="mainbar container">
      <div>联系电话：1xxxxxxxxxx</div>
      <div>联系邮箱： xxxxxxxxxx.qq.com</div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Tail',
    data () {
      return {}
    }
  }
</script>
<style scoped>
@import "~assets/css/mediacss.css";

.tail {
  width: 100%;
  min-height: 5em;
  margin-top: 10em;
  background: rgb(39, 39, 39);
  color: rgb(156, 156, 156);
}

.mainbar {
  display: flex;
  justify-content: space-around;
}
</style>