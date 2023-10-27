<!---->
<template>
  <div class='addressitem'>
    <div v-for="(item,index) in address" :key="index">
      <div class="addresscard" @click="choose(item)">
        <div>收货人：{{item.username}}</div>
        <div>联系电话：{{item.phone}}</div>
        <div class="address">地址：{{item.address}}</div>
      </div>
    </div>
    <div v-if="address.length === 0" class="noaddress">
      您还没有存入任何地址
    </div>
  </div>
</template>

<script>
  import {requestqueryAddressbyuid} from 'network/requestaddress.js'

  export default {
    name: 'AddressItem',
    data () {
      return {
        address: []
      }
    },
    methods: {
      choose(item) {
        this.$emit('choose',item)
      }
    },
    created() {
      requestqueryAddressbyuid({
        uid: this.$store.state.uid
      }).then(res => {
        if(res.length != 0) {
          this.address = res
        }
      }).catch(err => {
        console.log(err)
      })
    }
  }
</script>
<style scoped>

.addresscard {
  width: 100%;
  display: flex;
  flex-wrap: wrap;
  margin: 1.5em auto;
  border-radius: 0.5em;
  color: rgb(120, 120, 159);
  border: 0.6px solid rgb(204, 203, 203);
  background: rgb(255, 255, 255);
  cursor: pointer;
  transition: transform 0.5s, box-shadow 0.5s;
  -moz-transition: transform 0.5s, box-shadow 0.5s;
  -webkit-transition: transform 0.5s, box-shadow 0.5s;
  -o-transition: transform 0.5s, box-shadow 0.5s;
}

.addresscard:hover {
  transform: translateY(-0.5em);
  box-shadow: 5px 15px 15px rgb(206, 205, 205), -5px -0.5px 15px rgb(206, 205, 205);
}

.addresscard div {
  width: 50%;
  height: 3.4em;
  line-height: 3.4em;
  padding-left: 1.5em;
}

.addresscard .address {
  width: 100%;
}

.noaddress {
  text-align: center;
  margin-top: 1.5em;
  margin-bottom: 10em;
  color: rgb(192, 190, 190);
  font-size: 2.5em;
}
</style>