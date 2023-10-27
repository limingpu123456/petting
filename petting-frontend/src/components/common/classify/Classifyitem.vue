<!--搜索规则的每一行-->
<template>
  <div class='classifyitem'>
    <div v-for="(item,index) in kind" :key="index">
      <div class="kindname">{{item.name}}</div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Classifyitem',
    props: {
      kind: Array
    },
    data () {
      return {}
    }
  }
</script>
<style scoped>

.classifyitem {
  display: flex;
  line-height: 2em;
  margin-left: 1em;
  margin-top: 0.5em;
}

.kindname {
  width: 4.5em;
  height: 2em;
  margin-right: 0.5em;
  background: rgb(93, 160, 255);
  text-align: center;
  border-radius: 0.5em;
  cursor: pointer;
}
</style>