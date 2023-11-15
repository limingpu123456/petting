<!---->
<template>
  <div class="home">
    <swipper></swipper>
    <category
      v-for="(item, index) in bkind"
      :key="index"
      :bkind="item"
    ></category>
    <category
      v-for="(item, index) in other"
      :key="'other' + index"
      :bkind="item"
    ></category>
    <sidebar></sidebar>
  </div>
</template>

<script>
import Swipper from "components/common/Swipper.vue";
import Category from "components/content/home/Category.vue";
import Sidebar from "components/content/sidebar/Sidebar.vue";

import { requestqueryBKind } from "network/requestbkind.js";

export default {
  name: "home",
  data() {
    return {
      bkind: [],
      other: [],
    };
  },
  components: {
    Swipper,
    Category,
    Sidebar,
  },
  created() {
    requestqueryBKind()
      .then((res) => {
        this.bkind = res.filter((n) => {
          return n.bkindname != "其他";
        });
        this.other = res.filter((n) => {
          return n.bkindname === "其他";
        });
      })
      .catch((err) => {
        console.log(err);
      });
  },
};
</script>
<style scoped>
.home {
  margin-top: -108px;
}
</style>
