<!---->
<template>
  <div class='petorder'>
    <!-- <breadcrumb>我的订单</breadcrumb> -->
    <div class="meun">
      <div class="container">
        <el-menu :default-active="activeIndex" mode="horizontal" background-color="#f2f2f2"
        @select="handleSelect">
          <el-menu-item class="el-menu-item" index="-1">全部</el-menu-item>
          <el-menu-item class="el-menu-item" index="0">进行中</el-menu-item>
          <el-menu-item class="el-menu-item" index="1">已完成</el-menu-item>
          <el-menu-item class="el-menu-item" index="2">已取消</el-menu-item>
          <el-menu-item class="el-menu-item" index="3">修改中</el-menu-item>
          <el-menu-item class="el-menu-item" index="4">取消中</el-menu-item>
        </el-menu>
      </div>
    </div>
    <div class="order container">
      <div v-for="(item,index) in petorder" :key="index">
        <ordercard :item="item" :statu.sync="item.postatu" @deleteorder="deleteorder(item)"></ordercard>
      </div>
      <div class="nolists" v-if="petorder.length == 0">
        暂无数据
      </div>
    </div>
  </div>
</template>

<script>

  import {requestquerypetorder} from "network/requestpetorder.js"

  import Breadcrumb from "components/common/breadcrumb/Breadcrumb.vue"
  import Ordercard from "views/petorder/Ordercard.vue"
  import purchase from "views/purchase/purchase.vue"

  export default {
    name: 'PetOrder',
    components: {
      Breadcrumb,
      Ordercard,
      purchase
    },
    data () {
      return {
        activeIndex: '-1',
        petorder: [],
        allpetorder: [],
        form: {}
      }
    },
    methods: {
      handleSelect(key, keyPath) {
        if(key == -1) {
          this.petorder = this.allpetorder
        }else {
          this.petorder = this.allpetorder.filter(n => {
            return n.postatu == key
          })
        }
      },
      deleteorder(item) {
        this.allpetorder.splice(this.allpetorder.indexOf(item),1)
        if(this.index == 1 || this.index == 2) {
          this.petorder.splice(this.petorder.indexOf(item),1)
        }
      }
    },
    created() {
      requestquerypetorder({
        uid: this.$store.state.uid
      }).then(res => {
        this.allpetorder = res
        this.petorder = res
      }).catch(err => {
        console.log(err)
      })
    },
  }
</script>
<style scoped>
@import "~assets/css/mediacss.css";

.petorder {
  margin-top: -3em;
}

.el-menu-item:hover {
  background: #f2f2f2 !important;
}

.order {
  display: flex;
  /* justify-content: space-between; */
  flex-wrap: wrap;
}

.title {
  width: 100%;
  font-size: 2.2em;
}

.nolists {
  width: 100%;
  font-size: 4em;
  line-height: 10em;
  color: rgba(143, 138, 138, 0.5);
  text-align: center;
}

.changepetorder {
  position: fixed;
  top: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0,0.3);
}

.purchasebar {
  /* margin: 10em auto; */
  position: fixed;
  top: 0;
  margin-top: 10em;
  margin-left: 50%;
  transform: translate(-30em,0);
  padding-top: 1em;
  width: 60em;
  /* min-width: 60em; */
  height: 60em;
  overflow-y: auto;
  background: #f2f2f2;
}
</style>