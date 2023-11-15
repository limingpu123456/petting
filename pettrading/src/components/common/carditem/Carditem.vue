<!---->
<template>
  <div class='carditem'>
    <card v-for="(item,index) in lists" :key="index" :item="item"></card>
  </div>
</template>

<script>
  import Card from "components/common/carditem/Card.vue"

  export default {
    name: 'Carditem',
    props: ['lists'],
    components: {
      Card
    },
    data () {
      return {
      }
    }
  }
</script>
<style scoped>
.carditem {
    width: 100%;
    display: flex;
    /* justify-content: space-around; */
    flex-wrap: wrap;
}
</style>