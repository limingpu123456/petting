<!---->
<template>
  <div class='petcard' :style="border(statu)">
    <div>
        <div class="img">
        <img :src="'/api/' + item.photo[0].url" alt="">
        </div>
        <div>
        <div class="time">{{item.date}}</div>
        <div class="petstatu">
            <div class="first" v-if="statu == 0">出售中</div>
            <div class="second" v-if="statu == 1">已出售</div>
            <div class="finish" v-if="statu == 2">已完成</div>
            <div class="wantbuy" v-if="statu == 3">求购中</div>
        </div>
        <div class="petname">{{item.petname}}</div>
        <div class="price" v-if="item.price != -1">{{item.price}}</div>
        <div class="price" v-if="item.price == -1">不限</div>
        </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Petcard',
    props: ['item','statu'],
    data () {
      return {}
    },
    methods: {
      border(statu) {
        if(statu === 0) {
          return "border: 0.5px solid rgb(255, 194, 8);"
        }else if(statu === 1) {
          return "border: 0.5px solid rgb(102, 177, 255);"
        }else if(statu === 2) {
          return "border: 0.5px solid rgb(33, 213, 168);"
        }else if(statu === 3) {
          return "border: 0.5px solid pink;"
        }
      }
    }
  }
</script>
<style scoped>

.petcard {
  width: 14em;
  height: 19em;
  /* margin-right: 3em; */
  margin: 1em 1.3em;
  border-radius: 1em;
  background: rgb(255, 255, 255);
  border: 0.5px solid rgb(204, 203, 203);
  overflow: hidden;
  cursor: pointer;
  transition: transform 0.5s, box-shadow 0.5s;
  -moz-transition: transform 0.5s, box-shadow 0.5s;
  -webkit-transition: transform 0.5s, box-shadow 0.5s;
  -o-transition: transform 0.5s, box-shadow 0.5s;
}

.petcard:hover {
  transform: translateY(-0.5em);
  box-shadow: 5px 15px 15px rgb(206, 205, 205), -5px -0.5px 15px rgb(206, 205, 205);
}

.img {
  height: 10em;
  overflow: hidden;
}

.img img{
  width: 100%;
}

.petname {
  height: 1.5em;
  line-height: 1.5em;
  font-size: 1.7em;
  font-weight: 550;
  text-align: center;
  overflow: hidden;
}

.price {
  height: 1.5em;
  line-height: 1.5em;
  font-size: 1.7em;
  text-align: center;
  color: rgb(255, 144, 3);
}

.time {
  height: 2em;
  line-height: 2em;
  padding-left: 0.5em;
  color: rgb(183, 183, 183);
  font-size: 0.5em;
}

.petstatu {
  display: flex;
  justify-content: flex-end;
  font-size: 1.3em;
  padding-right: 0.5em;
}

.first {
  color: rgb(255, 194, 8);
}

.second {
  color: rgb(102, 177, 255);
}

.finish {
  color: rgb(33, 213, 168);
}

.wantbuy {
  color: pink;
}
</style>