<!---->
<template>
  <div class="card" @click="todetail">
    <div class="listimg">
      <img :src="'/api/' + item.photo[0].url" alt="" />
    </div>
    <div class="cardbar">
      <div class="petname">{{ item.petname }}</div>
      <div>类型：{{ item.bkind.bkindname }}</div>
      <div>品种：{{ item.skind.skindname }}</div>
      <div v-if="item.age === -1">年龄：不限</div>
      <div v-if="item.age != -1">年龄：{{ item.age }}个月</div>
      <div>发布人：{{ item.user.username }}</div>
      <div v-if="item.price === -1" class="price">不限</div>
      <div v-if="item.price != -1" class="price">{{ item.price }}</div>
      <div class="time">
        <span>{{ item.date }}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Card",
  props: {
    item: Object,
  },
  data() {
    return {};
  },
  methods: {
    todetail() {
      this.$router.push({
        path: "/detail",
        query: {
          pid: this.item.pid,
        },
      });
    },
  },
};
</script>

<style scoped>
.card {
  width: 18.8em;
  height: 26em;
  cursor: pointer;
  margin-top: 1em;
  margin-left: 1em;
  border-radius: 0.5em;
  overflow: hidden;
  background: rgb(255, 255, 255);
  /* border: 0.6px solid rgba(241, 187, 106, 0.5); */
  border: 0.6px solid rgb(204, 203, 203);
  transition: transform 0.5s, box-shadow 0.5s;
  -moz-transition: transform 0.5s, box-shadow 0.5s;
  -webkit-transition: transform 0.5s, box-shadow 0.5s;
  -o-transition: transform 0.5s, box-shadow 0.5s;
}

.card:hover {
  transform: translateY(-0.5em);
  box-shadow: 5px 15px 15px rgb(206, 205, 205),
    -5px -0.5px 15px rgb(206, 205, 205);
}

.listimg {
  height: 15em;
  overflow: hidden;
}

.listimg img {
  width: 100%;
}

.cardbar {
  display: flex;
  flex-wrap: wrap;
}

.cardbar .petname {
  width: 100%;
  text-align: center;
  font-size: 1.6em;
  height: 1.6em;
  line-height: 1.6em;
  font-weight: 600;
  padding-right: 1em;
}

.cardbar div {
  width: 50%;
  height: 2em;
  line-height: 2em;
  padding-left: 1em;
  overflow: hidden;
}

.cardbar .price {
  width: 100%;
  text-align: center;
  padding-right: 1em;
  font-size: 2.3em;
  height: 1.3em;
  line-height: 1.3em;
  /* height: 1em; */
  color: rgb(255, 144, 3);
}

.cardbar .time {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  padding-right: 1em;
  color: rgb(183, 183, 183);
}
</style>
