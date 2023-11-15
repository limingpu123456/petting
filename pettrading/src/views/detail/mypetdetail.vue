<!---->
<template>
  <div class='mypetdetail'>
    <div>
      <div class="title">
        <div>订单信息：</div>
      </div>
      <div class="ordertitle" v-if="shownew">旧订单：</div>
       <el-table
        :data="tableData"
        style="width: 100%">
        <el-table-column
          prop="user.username"
          label="下单用户"
          width="110">
        </el-table-column>
        <el-table-column
          prop="recipientname"
          label="收件人"
          width="110">
        </el-table-column>
        <el-table-column
          prop="phone"
          label="手机号"
          width="120">
        </el-table-column>
        <el-table-column
          prop="address"
          label="详细地址">
        </el-table-column>
        <el-table-column
          prop="price"
          width="100"
          label="下单时价格">
        </el-table-column>
        <el-table-column
          prop="date"
          width="160"
          label="下单时间">
        </el-table-column>
        <el-table-column
          v-if="showorderchat"
          width="110"
          label="联系下单用户">
          <template>
            <div class="chat" @click="tochat">
              <img src="~assets/img/chat/petorderchat.png" alt="">
            </div>
          </template>
        </el-table-column>
      </el-table>
      <div v-if="shownew">
        <div class="ordertitle">新订单：</div>
        <el-table
          :data="tableData"
          style="width: 100%">
          <el-table-column
            prop="user.username"
            label="下单用户"
            width="110">
          </el-table-column>
          <el-table-column
            prop="newrecipientname"
            label="收件人"
            width="110">
          </el-table-column>
          <el-table-column
            prop="newphone"
            label="手机号"
            width="120">
          </el-table-column>
          <el-table-column
            prop="newaddress"
            label="详细地址">
          </el-table-column>
          <el-table-column
            prop="price"
            width="100"
            label="下单时价格">
          </el-table-column>
          <el-table-column
            prop="date"
            width="160"
            label="下单时间">
          </el-table-column>
          <el-table-column
            width="110"
            label="联系下单用户">
            <template>
              <div class="chat" @click="tochat">
                <img src="~assets/img/chat/petorderchat.png" alt="">
              </div>
            </template>
          </el-table-column>
        </el-table>
        <div class="butbar">
          <div class="changebut">
            <el-button @click="agreeupdatepetorder" type="primary" round>同意修改</el-button>
          </div>
        </div>
      </div>
      <div v-if="showcancel">
        <div class="butbar">
          <div class="changebut">
            <el-button @click="agreecancelpetorder" type="danger" round>同意取消</el-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import {requestquerypetorder} from "network/requestpetorder.js"
  import {requestaddContact} from "network/requestContact.js"
  import {requestupdatepetorder} from "network/requestpetorder.js"

  import bus from "store/bus.js"

  export default {
    name: 'mypetdetail',
    data () {
      return {
        tableData: [],
        shownew: false,
        showorderchat: false,
        showcancel: false
      }
    },
    created() {
      requestquerypetorder({
        pid: this.$route.query.pid
      }).then(res => {
        this.tableData = res.filter(n => {
          return n.postatu != 2
        })
        if(this.tableData[0].newphone != null && this.tableData[0].newphone != "" && this.tableData[0].uid != this.$store.state.uid) {
          this.shownew = true
        }
        if(this.tableData[0].uid != this.$store.state.uid) {
          this.showorderchat = true
        }
        if(this.tableData[0].postatu == 4 && this.tableData[0].uid != this.$store.state.uid) {
          this.showcancel = true
        }
      }).catch(err => {
        console.log(err)
      })
    },
    methods: {
      //联系买家
      tochat() {
        requestaddContact({
          fromuid: this.$store.state.uid,
          touid: this.tableData[0].uid,
          noread: 0
        }).then(res => {
          let contactuser = {}
          contactuser.cid = res
          contactuser.uid = this.tableData[0].user.uid
          contactuser.username = this.tableData[0].user.username
          contactuser.avatar = this.tableData[0].user.avatar
          contactuser.noread = 0
          bus.$emit('detail-chat',contactuser)
          this.$store.state.showchat = true
        }).catch(err => {
          console.log(err)
        })
      },
      //同意修改订单
      agreeupdatepetorder() {
        requestupdatepetorder({
          poid: this.tableData[0].poid,
          phone: this.tableData[0].newphone,
          address: this.tableData[0].newaddress,
          recipientname: this.tableData[0].newrecipientname,
          newphone: "",
          newaddress: "",
          newrecipientname: "",
          postatu: 0
        }).then(res => {
          this.tableData[0].phone = this.tableData[0].newphone
          this.tableData[0].address = this.tableData[0].newaddress
          this.tableData[0].recipientname = this.tableData[0].newrecipientname
          this.shownew = false
          this.$notify({
            title: '同意修改',
            message: res,
            type: 'success',
            offset: 100
          })
          let message = {}
          message.type = 5
          message.msg = '订单修改成功，点击前往查看'
          message.touid = this.tableData[0].user.uid
          message.pid = this.tableData[0].pid
          bus.$emit("purchase",message)
        }).catch(err => {
          console.log(err)
        })
      },
      //同意取消订单
      agreecancelpetorder() {
        requestupdatepetorder({
          poid: this.tableData[0].poid,
          postatu: 2,
          pid: this.tableData[0].pid,
          pk: 0
        }).then(res => {
          this.$notify({
            title: '同意取消',
            message: res,
            type: 'success',
            offset: 100
          })
          let message = {}
          message.type = 5
          message.msg = '订单取消成功，点击前往查看'
          message.touid = this.tableData[0].user.uid
          message.pid = this.tableData[0].pid
          bus.$emit("purchase",message)
          this.$emit("agreecancelpetorder")
        }).catch(err => {
          console.log(err)
        })
      }
    },
  }
</script>
<style scoped>

.title {
  color: rgb(253, 115, 56);
  font-size: 2em;
  font-style: oblique;
  margin-bottom: 0.5em;
}

.ordertitle {
  font-size: 1.8em;
  font-style: oblique;
  color: rgb(117, 117, 117);
  margin-top: 1em;
  margin-bottom: 0.5em;
}

.chat {
  margin: auto;
  width: 20px;
  cursor: pointer;
}

.chat img {
  width: 100%;
}

.butbar {
  display: flex;
  justify-content: center;
}

.changebut {
  margin-top: 0.5em;
}
</style>