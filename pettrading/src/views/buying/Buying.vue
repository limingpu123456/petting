<!---->
<template>
  <div class='buying'>
    <breadcrumb>宠物求购</breadcrumb>
    <div class="container">
      <div class="mainbuy">
        <selector @query="query">
          <el-tooltip class="item" effect="dark" content="我也要求购" placement="bottom">
            <el-button type="primary" @click="towantbuy">求购</el-button>
          </el-tooltip>
        </selector>
        <div class="rightcard">
          <div v-if="lists.length === 0 && show === true" class="nolists">没有您要搜索的宠物</div>
          <carditem :lists="lists"></carditem>
        </div>
      </div>
    <!-- 分页按钮 -->
      <div class="paging">
        <el-pagination
          @current-change="newpetpage"
          background
          :hide-on-single-page="true"
          :pager-count="pagercount"
          :page-size="pagesize"
          layout="prev, pager, next, jumper"
          :total="total">
        </el-pagination>
      </div>
    </div>
    <sidebar></sidebar>
  </div>
</template>

<script>
  import Breadcrumb from "components/common/breadcrumb/Breadcrumb.vue"
  import Carditem from "components/common/carditem/Carditem.vue"
  import Sidebar from "components/content/sidebar/Sidebar.vue"
  import Selector from "components/content/selector/Selector.vue"

  import {requestquerypetpage,requestquerypetcount} from "network/requestpet.js"

  export default {
    name: 'Buying',
    data () {
      return {
        show: false,
        //求购专区标志
        pk: 3,
       //当前页的宠物数据
        lists: [],
        //页码最大按钮数量
        pagercount: 5,
        //每页显示的条目个数
        pagesize: 8,
        //总条目数
        total: 8,
        //当前页数
        // currentpage: this.$store.state.sellpage,
        currentpage: 1,
        form: {
          sort: null,
          bkid: null,
          skid: null,
          age: null,
          maxprice: null,
          petname: null
        }
      }
    },
    components: {
      Breadcrumb,
      Carditem,
      Sidebar,
      Selector
    },
    methods: {
      towantbuy() {
        if(this.$store.state.uid === null) {
          this.$store.state.show = true;
          this.$store.state.logshow = true;
        }else {
          this.$router.push('/wantbuy');
        }
      },
      newpetpage(val) {
        this.currentpage = val;
        //查询新的一页条数据
        requestquerypetpage({
          page: this.currentpage,
          count: this.pagesize,
          pk: this.pk,
          bkid: this.form.bkid,
          skid: this.form.skid,
          age: this.form.age,
          maxprice: this.form.maxprice,
          petname: this.form.petname,
          sort: this.form.sort
        }).then(res => {
          this.lists = res
        }).catch(err => {
          console.log(err)
        });
      },
      query(form) {
        this.currentpage = 1;
        this.form = form;
        if(this.form.age == "不限") {
          this.form.age = -1
        }
        //更加条件查询数据
        requestquerypetpage({
          page: this.currentpage,
          count: this.pagesize,
          pk: this.pk,
          bkid: this.form.bkid,
          skid: this.form.skid,
          age: this.form.age,
          maxprice: this.form.maxprice,
          petname: this.form.petname,
          sort: this.form.sort
        }).then(res => {
          this.lists = res
        }).catch(err => {
          console(err)
        });
        requestquerypetcount({
          pk: this.pk,
          bkid: this.form.bkid,
          skid: this.form.skid,
          age: this.form.age,
          petname: this.form.petname
        }).then(res => {
          this.total = res;
        }).catch(err => {
          console,log(err);
        })
      }
    },
    created() {
      // if(this.$store.state.sellpage === null) {
      //   this.$store.commit('setsellpage', 1)
      // }
      // console.log(this.$store.state.sellpage);
      if(this.$route.query.petname){
        this.form.petname = this.$route.query.petname;
      };
      //首次进入查询数据
      requestquerypetpage({
        // page: this.$store.state.sellpage,
        page: this.currentpage,
        count: this.pagesize,
        pk: this.pk,
        petname: this.form.petname
      }).then(res => {
        this.lists = res,
        this.show = true
      }).catch(err => {
        console.log(err)
      });
      // 查询可购买宠物的条数
      requestquerypetcount({
        pk: this.pk,
        petname: this.form.petname
      }).then(res => {
        this.total = res
      }).catch(err => {
        console.log(err)
      })
    }
  }
</script>
<style scoped>
@import "~assets/css/mediacss.css";

.nolists {
  width: 100%;
  font-size: 4em;
  line-height: 10em;
  color: rgba(143, 138, 138, 0.5);
  text-align: center;
}

.mainbuy {
  display: flex;
  justify-content: space-between;
  /* flex-wrap: wrap; */
  margin-top: calc(38px + 0.5em);
  min-height: 54em;
}

.rightcard {
  width: 100%;
}

.paging{
  display: flex;
  justify-content: center;
  margin-top: 1em;
  width: 100%;
}
</style>