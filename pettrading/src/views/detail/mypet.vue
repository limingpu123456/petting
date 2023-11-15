<!---->
<template>
  <div class="mypet">
    <div class="title">请选择符合条件的宠物</div>
    <div class="petlist">
      <div v-for="(item, index) in petlists" :key="index">
        <el-popconfirm
          placement="top-start"
          title="将该宠物信息发送给该用户？"
          @confirm="select(index, item)"
        >
          <div slot="reference">
            <petcard :item="item" :statu="item.pk"></petcard>
          </div>
        </el-popconfirm>
      </div>
    </div>
  </div>
</template>

<script>
import { requestqueryAllPet } from "network/requestpet.js";

import bus from "store/bus.js";

import Petcard from "views/pet/Petcard.vue";

export default {
  name: "mypet",
  props: ["touid"],
  components: {
    Petcard,
  },
  data() {
    return {
      petlists: [],
    };
  },
  created() {
    requestqueryAllPet({
      uid: this.$store.state.uid,
      pk: 0,
    })
      .then((res) => {
        this.petlists = res;
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    select(index, item) {
      this.$notify({
        title: "发送成功",
        message: "该宠物已推荐给对方",
        type: "success",
        offset: 100,
      });
      let message = {};
      message.type = 7;
      message.msg = "我这有你想要的宠物，点击前往查看";
      message.touid = this.touid;
      message.pid = item.pid;
      bus.$emit("purchase", message);
    },
  },
};
</script>
<style scoped>
.title {
  display: flex;
  justify-content: center;
  font-size: 2.5em;
  font-style: oblique;
  color: rgb(128, 173, 247);
  padding-top: 0.5em;
}

.petlist {
  display: flex;
  flex-wrap: wrap;
}
</style>