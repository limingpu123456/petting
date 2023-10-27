<!--搜索规则-->
<template>
  <div class='classify'>
    <classifyitem :kind="sort"></classifyitem>
    <classifyitem :kind="bkind"></classifyitem>
    <classifyitem :kind="skind"></classifyitem>
  </div>
</template>

<script>
  import Classifyitem from "components/common/classify/Classifyitem.vue"

  export default {
    name: 'Classify',
    props: {
      bkind: Array,
      skind: Array
    },
    data () {
      return {
        sort: [
          {
            id: 0,
            name: "默认排序"
          },{
            id: 1,
            name: "最少点击"
          },{
            id: 2,
            name: "最多点击"
          },{
            id: 2,
            name: "最久发布"
          },{
            id: 2,
            name: "最新发布"
          }
        ]
      }
    },
    components: {
      Classifyitem
    }
  }
</script>
<style scoped>
</style>