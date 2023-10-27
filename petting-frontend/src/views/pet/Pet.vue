<!--宠物管理-->
<template>
  <div class='pet'>
    <div class="meun">
      <div class="container">
        <el-menu :default-active="activeIndex" mode="horizontal" background-color="#f2f2f2"
        @select="handleSelect">
          <el-menu-item class="el-menu-item" index="-1">全部</el-menu-item>
          <el-menu-item class="el-menu-item" index="0">出售中</el-menu-item>
          <el-menu-item class="el-menu-item" index="1">已出售</el-menu-item>
          <el-menu-item class="el-menu-item" index="2">已完成</el-menu-item>
          <el-menu-item class="el-menu-item" index="3">求购中</el-menu-item>
        </el-menu>
      </div>
    </div>
    <div class="petlist container">
      <div v-for="(item,index) in petlists" :key="index">
        <div @click="todetail(item)">
          <petcard :item="item" :statu="item.pk"></petcard>
        </div>
      </div>
      <div class="nolists" v-if="petlists.length == 0">
        暂无数据
      </div>
    </div>
  </div>
</template>

<script>

  import Petcard from "views/pet/Petcard.vue"

  import {requestqueryAllPet} from "network/requestpet.js"

  export default {
    name: 'Pet',
    components: {
      Petcard
    },
    data () {
      return {
        activeIndex: '-1',
        allpetlists: [],
        petlists: [],
        form: {
          prtname: ""
        }
      }
    },
    methods: {
      handleSelect(key, keyPath) {
        if(key == -1) {
          this.petlists = this.allpetlists
        }else {
          this.petlists = this.allpetlists.filter(n => {
            return n.pk == key
          })
        }
      },
      todetail(item) {
        this.$router.push({
          path: '/detail',
          query: {
            pid: item.pid
          }
        })
      }
    },
    created() {
      requestqueryAllPet({
        uid: this.$store.state.uid
      }).then(res => {
        this.petlists = res
        this.allpetlists = res
      }).catch(err => {
        console.log(err)
      })
    },
  }
</script>
<style scoped>
@import "~assets/css/mediacss.css";

.pet {
  margin-top: -3em;
}

.el-menu-item:hover {
  background: #f2f2f2 !important;
}

.petlist {
  display: flex;
  flex-wrap: wrap;
  margin-top: 1em;
}

.nolists {
  width: 100%;
  font-size: 4em;
  line-height: 10em;
  color: rgba(143, 138, 138, 0.5);
  text-align: center;
}
</style>