<!---->
<template>
  <div class="swipper">
    <div class="window">
      <div class="search">
        <div class="inp">
          <el-tooltip class="item" effect="dark" :content="content" placement="top-start">
            <div :class="{left: true, leftturn: turnback}" @click="turn">
              <img class="leftimg" src="~assets/img/search/turn.png" alt="">
            </div>
          </el-tooltip>
          <input @keyup.enter="request" v-model="petname" :placeholder="placeholder" :class="{elinp: true,elinpturn: turnback}" type="text">
          <div :class="{right: true, rightturn: turnback}" @click="request">
            <img class="rightimg" src="~assets/img/search/search.png" alt="">
          </div>
        </div>
      </div>
      <transition-group name="slider">
        <span
          v-for="(item, index) in sliders"
          :key="index"
          :style="getbackground(index)"
          v-show="index === show"
          @mouseover="stopslider"
          @mouseleave="runslider"
        >
        </span>
      </transition-group>
    </div>
  </div>
</template>

<script>
export default {
  name: "Swipper",
  data() {
    return {
      petname: "",
      content: '切换到查询求购',
      turnback: false,
      placeholder: '请输入要购买的宠物名称',
      pk: 0,
      sliders: [
        {
          img: require("assets/img/swipper/1.webp")
        },
        {
          img: require("assets/img/swipper/2.webp")
        }
      ],
      show: 0,
      timer: null
    };
  },
  methods: {
    request(){
      if(this.petname === ""){
        return
      }
      if(this.pk === 0) {
        this.$router.push({
          path: '/presell',
          query: {
            petname: this.petname
          }
        })
      };
      if(this.pk === 1) {
        this.$router.push({
          path: '/buying',
          query: {
            petname: this.petname
          }
        })
      }
    },
    getbackground(index) {
      return {
        backgroundImage: "url(" + this.sliders[index].img + ")",
        backgroundSize: "cover",
        backgroundRepeat: "no-repeat",
        backgroundPosition: "center"
      };
    },
    stopslider() {
      // clearInterval(this.timer);
      // this.timer = null;
    },
    runslider() {
      if(this.timer === null){
        this.timer = setInterval(() => {
          if (this.show === this.sliders.length - 1) {
            this.show = 0;
          } else {
            this.show++;
          }
          // console.log(this.show);
        }, 5000);
      }
    },
    //切换查询模式
    turn() {
      this.turnback = !this.turnback;
      if(this.turnback === true){
        this.content = '切换到查询出售';
        this.placeholder = '请输入想查询的求购区的宠物名称';
        this.pk = 1;
      }else {
        this.content = '切换到查询求购';
        this.placeholder = '请输入要购买的宠物名称';
        this.pk = 0;
      }
    }
  },
  mounted() {
    this.runslider();
  }
};
</script>
<style scoped>

.window {
  position: relative;
  width: 100%;
  min-height: 468px;
  overflow: hidden;
}

.search {
  position: absolute;
  width: 100%;
  height: 100%;
  z-index: 2;
}

.inp {
  display: flex;
  width: 30%;
  min-width: 25em;
  height: 3.6em;
  padding: -5px;
  margin: auto;
  margin-top: calc(64px + 5em);
  text-align: center;
  /* background: pink; */
}

.left {
  width: 4em;
  height: 3.6em;
  border-radius: 1.8em 0 0 1.8em;
  background: rgb(64, 158, 255);
  transition: background 1s;
  -moz-transition: background 1s;	/* Firefox 4 */
  -webkit-transition: background 1s;	/* Safari 和 Chrome */
  -o-transition: background 1s;	/* Opera */
  cursor: pointer;
}

.leftturn {
  background: rgb(255, 144, 1);
}

.leftimg {
  width: 60%;
  margin-left: 0.6em;
  margin-top: 0.7em;
}

.right {
  width: 4em;
  height: 3.6em;
  border-radius: 0 1.8em 1.8em 0;
  background: rgb(64, 158, 255);
  transition: background 1s;
  -moz-transition: background 1s;	/* Firefox 4 */
  -webkit-transition: background 1s;	/* Safari 和 Chrome */
  -o-transition: background 1s;	/* Opera */
  cursor: pointer;
}

.rightturn {
  background: rgb(255, 144, 1);
}

.rightimg {
  width: 60%;
  margin-right: 0.6em;
  margin-top: 0.7em;
}

.elinp {
  width: calc(100% - 3em);
  /* height: 2.5em; */
  padding-left: 1em;
  font-size: 1.5em;
  border: 2px solid rgb(64, 158, 255);
  transition: border 1s;
  -moz-transition: border 1s;	/* Firefox 4 */
  -webkit-transition: border 1s;	/* Safari 和 Chrome */
  -o-transition: border 1s;	/* Opera */
}

.elinpturn {
  border: 2px solid rgb(255, 144, 1);
}

/* .window > ul > li {
  position: absolute;
  width: 100%;
  height: 100%;
  cursor: default;
} */
.window span {
  position: absolute;
  width: 100%;
  height: 100%;
  cursor: default;
}

.slider-enter-active, .slider-leave-active {
  transition: opacity 2s;
}

.slider-enter, .slider-leave-to {
  opacity: 0;
}

.slider-enter-to, .slider-leave {
  opacity: 1;
}

@media (min-width: 576px) {
  .window {
    min-height: 500px;
  }
}

@media (min-width: 992px) {
  .window {
    min-height: 630px;
  }
}

@media (min-width: 1200px) {
  .window {
    min-height: 740px;
  }
}
</style>