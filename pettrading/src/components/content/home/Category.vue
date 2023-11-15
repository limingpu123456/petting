<template>
  <div class="category container">
    <div class="title">
      <div class="classify">
        {{ bkind.bkindname }}
      </div>
      <div @click="tomoresell">更多>></div>
    </div>
    <carditem :lists="lists" v-if="lists.length > 0"></carditem>
    <div v-if="lists.length == 0">
      <div class="nolists">该种类暂无预售宠物</div>
      <div class="wantbuy"><a @click="towantbuy(bkind.bkid)">前往求购</a></div>
    </div>
  </div>
</template>

<script>
import Carditem from "components/common/carditem/Carditem.vue";

import { requestquerypetpage } from "network/requestpet.js";

export default {
  name: "Category",
  props: ["bkind"],
  data() {
    return {
      lists: []
    };
  },
  components: {
    Carditem
  },
  methods: {
    tomoresell() {
      this.$router.push({
        path: "/presell",
        query: {
          bkid: this.bkind.bkid
        }
      });
    },
    towantbuy(bkid) {
      if (this.$store.state.uid == null) {
        this.$store.state.show = true;
        this.$store.state.logshow = true;
      } else {
        this.$router.push({
          name: "wantbuy",
          params: {
            bkid: bkid
          }
        });
      }
    }
  },
  created() {
    requestquerypetpage({
      page: 1,
      count: 5,
      pk: 0,
      bkid: this.bkind.bkid
    })
      .then(res => {
        console.log(res);
        this.lists = res;
      })
      .catch(err => {
        console.log(err);
      });
  }
};
</script>

<style scoped>
@import "~assets/css/mediacss.css";

.category {
  margin-top: 3em;
}

.title {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  padding: 0 1em;
  height: 3em;
  line-height: 3em;
  cursor: pointer;
  margin-top: 1em;
}

.classify {
  font-size: 2.1em;
}

.nolists {
  width: 100%;
  font-size: 3em;
  line-height: 3em;
  color: rgba(143, 138, 138, 0.5);
  text-align: center;
}

.wantbuy {
  width: 100%;
  text-align: center;
  font-size: 1.5em;
  text-decoration: antiquewhite;
}

.wantbuy a {
  color: rgb(124, 169, 243);
  cursor: pointer;
  text-decoration: underline;
}

.wantbuy a:hover {
  color: rgb(255, 93, 35);
}
</style>
