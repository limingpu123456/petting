<!---->
<template>
  <div class="detail">
    <breadcrumb>
      <!-- <span slot="second">买卖专区</span> >  -->
      宠物详情
    </breadcrumb>
    <div v-if="nopet == true">
      <div class="notexixtpet">该宠物不存在</div>
    </div>
    <div v-if="nopet == false">
      <div class="maindetail container" v-if="photo.length > 0">
        <div class="photo">
          <div class="img" :style="background(active)"></div>
          <div class="allimg">
            <div
              v-for="(item, index) in photo"
              :key="index"
              class="list"
              @mousemove="changeactive(index)"
              :class="{ listactive: active === index }"
            >
              <img :src="'/api/' + photo[index].url" alt="" />
            </div>
          </div>
        </div>
        <div class="message">
          <div class="mbar">
            <div class="title">宠物名称：</div>
            <div class="val">{{ pet.petname }}</div>
          </div>
          <div class="mbar">
            <div class="title" v-if="pet.pk != 3">价格：</div>
            <div class="title" v-if="pet.pk == 3">最高价格：</div>
            <div class="val" v-if="pet.price != -1">{{ pet.price }}</div>
            <div class="val" v-if="pet.price == -1">不限</div>
          </div>
          <div class="mbar">
            <div class="title">类型：</div>
            <div class="val">{{ bkind.bkindname }}</div>
          </div>
          <div class="mbar">
            <div class="title">品种：</div>
            <div class="val">{{ skind.skindname }}</div>
          </div>
          <div class="mbar">
            <div class="title">性别：</div>
            <div class="val">{{ pet.sex }}</div>
          </div>
          <div class="mbar">
            <div class="title">年龄：</div>
            <div class="val" v-if="pet.age != -1">{{ pet.age }}个月</div>
            <div class="val" v-if="pet.age == -1">不限</div>
          </div>
          <!-- <div class="mbar">
            <div class="title">数量：</div>
            <div class="val">{{pet.count}}</div>
          </div> -->
          <div class="mbar">
            <div class="title">发布人：</div>
            <div class="val">
              <div>{{ user.username }}</div>
            </div>
          </div>
          <div class="mbar">
            <div class="title">发布说明：</div>
            <div class="desc">{{ pet.description }}</div>
          </div>
          <div class="mbar">
            <div class="title">发布时间：</div>
            <div class="val">{{ pet.date }}</div>
          </div>
          <div class="but">
            <div
              class="chat"
              v-if="showchatimg"
              @click="tochat"
              @mouseover="overimg = true"
              @mouseleave="overimg = false"
            >
              <!-- 禁止图片 -->
              <div
                class="banimg"
                v-if="$store.state.uid == user.uid && overimg == true"
              >
                <img src="~assets/img/chat/ban.png" alt="" />
              </div>
              <!-- 绿色聊天图片 -->
              <div
                class="banimg"
                v-if="$store.state.uid != user.uid && overimg == true"
              >
                <img src="~assets/img/chat/chathover.png" alt="" />
              </div>
              <!-- 蓝色聊天图片 -->
              <div class="chatimg">
                <img src="~assets/img/chat/chat.png" alt="" />
              </div>
            </div>
            <div v-if="user.uid != $store.state.uid && pet.pk == 0">
              <el-button type="primary" @click="topurchase">立即购买</el-button>
            </div>
            <div v-if="user.uid != $store.state.uid && pet.pk == 3">
              <el-button type="primary" @click="selectmypet"
                >我这里有</el-button
              >
            </div>
            <div
              v-if="
                user.uid == $store.state.uid && (pet.pk == 0 || pet.pk == 3)
              "
            >
              <el-button type="primary" @click="updatepet"
                >修改宠物信息</el-button
              >
            </div>
            <div v-if="user.uid == $store.state.uid && pet.pk != 1">
              <el-popover placement="top" width="160" v-model="visible">
                <p>删除后将无法恢复，确定删除吗？</p>
                <div style="text-align: right; margin: 0">
                  <el-button size="mini" type="text" @click="visible = false"
                    >取消</el-button
                  >
                  <el-button type="primary" size="mini" @click="deletepet"
                    >确定</el-button
                  >
                </div>
                <el-button type="danger" slot="reference">删除该宠物</el-button>
              </el-popover>
            </div>
            <div>
              <div
                v-if="
                  petorder.uid != $store.state.uid &&
                  user.uid != $store.state.uid &&
                  pet.pk != 0 &&
                  pet.pk != 3
                "
              >
                <div class="done">已出售</div>
              </div>
              <div v-if="user.uid == $store.state.uid && pet.pk == 0">
                <div class="doing">出售中</div>
              </div>
              <div
                v-if="
                  (petorder.uid == $store.state.uid ||
                    user.uid == $store.state.uid) &&
                  pet.pk == 1
                "
              >
                <div class="done">已出售</div>
              </div>
              <div
                v-if="
                  (petorder.uid == $store.state.uid ||
                    user.uid == $store.state.uid) &&
                  pet.pk == 2
                "
              >
                <div class="success">已完成</div>
              </div>
              <div
                v-if="
                  (petorder.uid == $store.state.uid ||
                    user.uid == $store.state.uid) &&
                  pet.pk == 3
                "
              >
                <div class="wantbuy">求购中</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- 订单信息 -->
      <div
        class="container"
        v-if="
          (petorder.uid == $store.state.uid || user.uid == $store.state.uid) &&
          pet.pk != 0 &&
          pet.pk != 3 &&
          petorder.postatu != 2
        "
      >
        <mypetdetail @agreecancelpetorder="agreecancelpetorder"></mypetdetail>
      </div>
    </div>
    <div v-if="showmypet">
      <div class="mypet container">
        <mypet :touid="user.uid"></mypet>
      </div>
    </div>
    <sidebar></sidebar>
  </div>
</template>

<script>
import mypetdetail from "views/detail/mypetdetail.vue";
import Breadcrumb from "components/common/breadcrumb/Breadcrumb.vue";
import Sidebar from "components/content/sidebar/Sidebar.vue";
import mypet from "views/detail/mypet.vue";
import Pet from "views/pet/Pet.vue";

import bus from "store/bus.js";

import { requestquerypetbyid, requestdeletePet } from "network/requestpet.js";
import { requestaddContact } from "network/requestContact.js";
import { requestquerypetorder } from "network/requestpetorder.js";

export default {
  name: "Detail",
  data() {
    return {
      visible: false,
      showstatu: 0,
      showchatimg: false,
      overimg: false,
      pet: {},
      bkind: {},
      skind: {},
      user: {},
      photo: [],
      active: 0,
      time: "",
      petorder: {},
      showmypet: false,
      nopet: false,
    };
  },
  components: {
    Breadcrumb,
    Sidebar,
    mypetdetail,
    mypet,
    Pet,
  },
  methods: {
    background(index) {
      return {
        backgroundImage: "url(" + "/api/" + this.photo[this.active].url + ")",
        backgroundSize: "cover",
        backgroundRepeat: "no-repeat",
        backgroundPosition: "center",
      };
    },
    changeactive(index) {
      this.active = index;
    },
    //加入购物车
    shoppingcard() {
      this.$message({
        message: "已加入购物车",
        type: "success",
      });
    },
    //购买
    topurchase() {
      if (this.$store.state.uid === null) {
        this.$store.state.show = true;
        this.$store.state.logshow = true;
      } else {
        this.$router.push({
          path: "/purchase",
          query: {
            pid: this.$route.query.pid,
            uid: this.user.uid,
            price: this.pet.price,
          },
        });
        // let purchase = this.$router.resolve({
        //   path: '/purchase',
        //   query: {
        //     pid: this.$route.query.pid
        //   }
        // });
        // window.open(purchase.href, '_blank')
      }
    },
    //联系卖家
    tochat() {
      if (this.$store.state.uid === null) {
        this.$store.state.show = true;
        this.$store.state.logshow = true;
      } else {
        if (this.user.uid != this.$store.state.uid) {
          requestaddContact({
            fromuid: this.$store.state.uid,
            touid: this.user.uid,
            noread: 0,
          })
            .then((res) => {
              let contactuser = {};
              // contactuser.cid = null
              contactuser.cid = res;
              contactuser.uid = this.user.uid;
              contactuser.username = this.user.username;
              contactuser.avatar = this.user.avatar;
              contactuser.noread = 0;
              bus.$emit("detail-chat", contactuser);
              this.$store.state.showchat = true;
            })
            .catch((err) => {
              console.log(err);
            });
        }
      }
    },
    //修改宠物信息
    updatepet() {
      let form = {};
      form.pid = this.pet.pid;
      form.name = this.pet.petname;
      form.bkid = this.pet.bkind.bkid;
      form.skid = this.pet.skind.skid;
      form.sex = this.pet.sex;
      form.age = this.pet.age;
      form.price = this.pet.price;
      form.desc = this.pet.description;
      form.photo = this.pet.photo;
      if (this.pet.pk == 0) {
        this.$router.push({
          path: "/wantsell",
          query: {
            form: JSON.stringify(form),
          },
        });
      } else {
        this.$router.push({
          path: "/wantbuy",
          query: {
            form: JSON.stringify(form),
          },
        });
      }
    },
    deletepet() {
      requestdeletePet({
        pid: this.pet.pid,
      })
        .then((res) => {
          this.$router.go(-1);
          this.$notify({
            title: "成功",
            message: res,
            type: "success",
            offset: 100,
          });
        })
        .catch((err) => {
          console.log(err);
        });
    },
    agreecancelpetorder() {
      this.pet.pk = 0;
    },
    selectmypet() {
      if (this.$store.state.uid === null) {
        this.$store.state.show = true;
        this.$store.state.logshow = true;
      } else {
        this.showmypet = true;
      }
    },
  },
  created() {
    requestquerypetbyid({
      pid: this.$route.query.pid,
    })
      .then((res) => {
        if (res == "") {
          this.nopet = true;
        } else {
          this.pet = res;
          this.bkind = res.bkind;
          this.skind = res.skind;
          this.user = res.user;
          this.photo = res.photo;
          if (this.pet.pk != 0 && this.pet.pk != 3) {
            requestquerypetorder({
              pid: this.$route.query.pid,
            })
              .then((res) => {
                this.petorder = res[0];
                if (this.petorder.uid == this.$store.state.uid) {
                  this.showchatimg = true;
                }
              })
              .catch((err) => {
                console.log(err);
              });
          } else {
            if (this.user.uid != this.$store.state.uid) {
              this.showchatimg = true;
            }
          }
        }
      })
      .catch((err) => {
        console.log(err);
      });
  },
};
</script>
<style scoped>
@import "~assets/css/mediacss.css";

.mypet {
  margin-top: 1em;
  background: rgb(255, 255, 255);
  border-radius: 8px;
}

.notexixtpet {
  display: flex;
  justify-content: center;
  margin-top: 5em;
  color: rgb(192, 190, 190);
  font-size: 5em;
  font-style: oblique;
}

.chat {
  position: relative;
  cursor: pointer;
  height: 2.5em;
}

.banimg {
  position: absolute;
  height: 100%;
}

.chatimg {
  height: 100%;
}

.chat img {
  height: 100%;
}

.success {
  font-size: 1.3em;
  font-style: oblique;
  text-shadow: 1px 1px 2px rgb(33, 213, 168);
  color: rgb(33, 213, 168);
}

.doing {
  font-size: 1.3em;
  font-style: oblique;
  text-shadow: 1px 1px 2px rgb(255, 194, 8);
  color: rgb(255, 194, 8);
}

.done {
  font-size: 1.3em;
  font-style: oblique;
  text-shadow: 1px 1px 2px rgb(102, 177, 255);
  color: rgb(102, 177, 255);
}

.wantbuy {
  font-size: 1.3em;
  font-style: oblique;
  text-shadow: 1px 1px 2px pink;
  color: pink;
}

.maindetail {
  display: flex;
  margin-top: 12em;
}

.photo {
  width: 50%;
  padding-bottom: 50%;
  height: 0;
}

.img {
  width: 80%;
  padding-bottom: 60%;
  height: 0;
  margin: auto;
  border-radius: 5px;
  cursor: pointer;
}

.allimg {
  /* width: 100%; */
  display: flex;
  justify-content: space-around;
  border-radius: 3px;
  vertical-align: middle;
}

.list {
  margin-top: 2em;
  width: 15%;
  height: 7em;
  display: flex;
  align-items: center;
  cursor: pointer;
  overflow: hidden;
}

.listactive {
  border: 1px solid rgb(255, 93, 35, 0.4);
}

.photo img {
  width: 100%;
}

.message {
  width: 50%;
  font-size: 1.7em;
}

.mbar {
  width: 100%;
  display: flex;
}

.message .title {
  width: 20%;
  height: 2em;
  text-align: center;
  overflow: hidden;
}

.message .val {
  width: 70%;
  height: 2em;
  color: rgb(120, 120, 120);
  overflow: hidden;
}

.message .desc {
  width: 300px;
  height: 10em;
  word-wrap: break-word;
  color: rgb(120, 120, 120);
  overflow-y: auto;
  white-space: pre-wrap;
}

.but {
  display: flex;
  justify-content: space-around;
  align-items: center;
  margin-top: 2em;
}
</style>