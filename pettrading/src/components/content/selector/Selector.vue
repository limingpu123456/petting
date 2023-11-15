<!---->
<template>
  <div class="selector" :class="{ reduceindex: $store.state.show }">
    <div class="form">
      <div class="title">排序方式</div>
      <el-select v-model="form.sort" filterable placeholder="请选择排序方式">
        <el-option
          v-for="item in sort"
          :key="item.value"
          :label="item.value"
          :value="item.sort"
        >
        </el-option>
      </el-select>
      <div class="title">宠物名称</div>
      <el-input
        clearable
        v-model="form.petname"
        placeholder="请输入宠物名称"
        @keyup.enter.native="query"
      ></el-input>
      <div class="title">宠物类型</div>
      <el-select
        v-model="form.bkid"
        clearable
        filterable
        placeholder="请选择宠物类型"
        @change="bkindchange"
      >
        <el-option
          v-for="item in bkind"
          :key="item.bkid"
          :label="item.bkindname"
          :value="item.bkid"
        >
        </el-option>
      </el-select>
      <div class="title">宠物品种</div>
      <el-select
        v-model="form.skid"
        clearable
        filterable
        placeholder="请选择宠物品种"
      >
        <el-option
          v-for="item in fskind"
          :key="item.skid"
          :label="item.skindname"
          :value="item.skid"
        >
        </el-option>
      </el-select>
      <div class="title">宠物年龄</div>
      <el-select
        v-model="form.age"
        clearable
        filterable
        placeholder="请选择宠物年龄"
      >
        <el-option
          v-for="item in age"
          :key="item.age"
          :label="item.age"
          :value="item.age"
        >
        </el-option>
      </el-select>
      <div class="title">宠物价格</div>
      <el-slider :max="maxprice" v-model="form.maxprice"></el-slider>
      <div class="but">
        <el-tooltip
          class="item"
          effect="dark"
          content="根据上述条件查询"
          placement="bottom"
        >
          <el-button type="primary" @click="query">查询</el-button>
        </el-tooltip>
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script>
import { requestqueryBKindandSKind } from "network/requestbkind.js";
import { requestqueryallskind } from "network/requestskind.js";
import { requestqueryMaxPrice, requestqueryage } from "network/requestpet.js";

export default {
  name: "Selector",
  data() {
    return {
      sort: [
        {
          value: "默认排序",
          sort: null,
        },
        {
          value: "价格最低",
          sort: "price",
        },
        {
          value: "价格最高",
          sort: "price desc",
        },
      ],
      bkind: [],
      skind: [],
      fskind: [],
      age: [],
      maxprice: 5000,
      form: {
        sort: null,
        bkid: null,
        skid: null,
        age: null,
        maxprice: null,
        petname: null,
      },
    };
  },
  created() {
    //查询所有宠物类型及对应品种
    requestqueryBKindandSKind()
      .then((res) => {
        this.bkind = res;
      })
      .catch((err) => {
        console.log(err);
      });
    if (this.$route.query.petname) {
      this.form.petname = this.$route.query.petname;
    }
    //查询所有宠物品种
    requestqueryallskind()
      .then((res) => {
        this.skind = res;
        if (this.$route.query.bkid) {
          this.form.bkid = this.$route.query.bkid;
          this.fskind = this.skind.filter((n) => {
            return n.bkid === this.form.bkid;
          });
        } else {
          this.fskind = this.skind.filter((n) => {
            return n.skindname != "其他";
          });
        }
      })
      .catch((err) => {
        console.log(err);
      });
    //查询宠物最高价
    requestqueryMaxPrice()
      .then((res) => {
        this.maxprice = res;
        this.form.maxprice = res;
      })
      .catch((err) => {
        console.log(err);
      });
    //查询宠物所有年龄
    requestqueryage()
      .then((res) => {
        if (this.$route.path.indexOf("/presell") != -1) {
          this.age = res.filter((n) => {
            return n.age != -1;
          });
        } else {
          res.forEach((value) => {
            if (value.age == -1) {
              value.age = "不限";
            }
          });
          this.age = res;
        }
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    //选中类型时，筛选出对应品种
    bkindchange() {
      if (this.form.bkid === "") {
        this.fskind = this.skind.filter((n) => {
          return n.skindname != "其他";
        });
      } else {
        this.fskind = this.skind.filter((n) => {
          return n.bkid === this.form.bkid;
        });
        let bsk = this.fskind.filter((n) => {
          return n.skid === this.form.skid;
        });
        if (bsk.length === 0) {
          this.form.skid = "";
        }
      }
    },
    query() {
      this.$emit("query", this.form);
    },
  },
};
</script>
<style scoped>
.selector {
  width: 25em;
  margin-top: 1em;
  background: rgb(255, 255, 255);
}

.reduceindex {
  z-index: -1;
}

.form {
  margin: auto;
  width: 15em;
  padding: 0.5em;
}

.title {
  font-size: 1.5em;
  margin: 0.5em 0;
}

.but {
  display: flex;
  margin-top: 1em;
}
</style>
