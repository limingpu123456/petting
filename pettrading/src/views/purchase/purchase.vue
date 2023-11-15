<!--购买页面-->
<template>
  <div class='purchase'>
    <div class="title">
      <h1>
        <slot>提交订单</slot>
      </h1>
    </div>
    <div class="mainbar">
      <el-form :rules="rules" ref="ruleForm" label-width="80px" :model="form">
        <el-form-item label="收货地址" prop="address">
          <el-input v-model="form.address" clearable placeholder="请输入地址"></el-input>
        </el-form-item>
        <el-form-item label="联系方式" prop="phone">
          <el-input v-model="form.phone" clearable placeholder="请输入手机号码"></el-input>
        </el-form-item>
        <el-form-item label="收货人" prop="recipientname">
          <el-input v-model="form.recipientname" clearable placeholder="请输入收件人"></el-input>
        </el-form-item>
        <el-form-item>
          <div class="but">
            <el-button type="primary" @click="request('ruleForm')">提交</el-button>
            <el-tooltip effect="dark" content="该地址为新地址，添加到地址列表中" placement="bottom">
              <el-button type="primary" @click="addaddress('ruleForm')">存入到新地址</el-button>
            </el-tooltip>
          </div>
        </el-form-item>
      </el-form>
      <div class="chooseaddress">已有地址（可点击选择）</div>
      <address-item @choose="choose"></address-item>
    </div>
    <!-- <sidebar></sidebar> -->
  </div>
</template>

<script>
  import {requestaddAddress} from "network/requestaddress.js"
  import {requestaddpetorder,requestupdatepetorder} from "network/requestpetorder.js"

  import bus from 'store/bus.js'

  import AddressItem from "views/purchase/AddressItem.vue"
  // import Sidebar from "components/content/sidebar/Sidebar.vue"


  export default {
    name: 'purchase',
    inject: ['reload'],
    props: ['orderform'],
    components: {
      AddressItem,
      // Sidebar
    },
    data () {
      var checkphone = (rule, value, callback) => {
        if(!value) {
          return callback(new Error('手机号不能为空'))
        }else if(/^1\d{10}$/.test(value)) {
          callback();
        }else {
          callback(new Error('请输入11位手机号码，1xx xxxx xxxx'))
        }
      }
      return {
        form: {
          address: '',
          phone: '',
          recipientname: ''
        },
        rules: {
          address: [
            { required: true, message: '地址不能为空' , trigger: 'blur'}
          ],
          phone: [
            { required: true, validator: checkphone, trigger: 'blur'}
          ],
          recipientname: [
            { required: true, message: '收货人不能为空' , trigger: 'blur'}
          ]
        }
      }
    },
    methods: {
      //提交订单
      request(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            if(this.orderform) {
              //修改订单
              requestupdatepetorder({
                // pid: this.$route.query.pid,
                // uid: this.$store.state.uid,
                // puid: ,
                poid: this.orderform.poid,
                newaddress: this.form.address,
                newphone: this.form.phone,
                newrecipientname: this.form.recipientname,
                postatu: 3
              }).then(res => {
                this.form.postatu = 3
                this.$emit("successupdate",this.form)
                let purchasemsg = {}
                purchasemsg.type = 2
                purchasemsg.msg = '我想修改一个的订单，点击前往查看'
                purchasemsg.touid = this.orderform.touid
                purchasemsg.pid = this.orderform.pid
                bus.$emit("purchase",purchasemsg)
                this.$router.go(-1)
                this.$notify({
                  title: '修改中',
                  message: res,
                  type: 'warning',
                  offset: 100
                })
              }).catch(err => {
                console.log(err)
              })
            }else {
              //提交订单
              requestaddpetorder({
                pid: this.$route.query.pid,
                uid: this.$store.state.uid,
                puid: this.$route.query.uid,
                address: this.form.address,
                phone: this.form.phone,
                recipientname: this.form.recipientname,
                postatu: 0,
                price: this.$route.query.price
              }).then(res => {
                if(res.flag == 1) {
                  let purchasemsg = {}
                  purchasemsg.type = 1
                  purchasemsg.msg = '我购买了你的宠物，点击前往查看'
                  purchasemsg.touid = this.$route.query.uid
                  purchasemsg.pid = this.$route.query.pid
                  bus.$emit("purchase",purchasemsg)
                  this.$router.go(-1)
                  this.$notify({
                    title: '成功',
                    message: res.msg,
                    type: 'success',
                    offset: 100
                  });
                }else {
                  this.$notify({
                    title: '失败',
                    message: res.msg,
                    type: 'error'
                  });
                }
              }).catch(err => {
                console.log(err)
              })
            }
          } else {
            return false;
          }
        });
      },
      //增加新地址
      addaddress(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            requestaddAddress({
              uid: this.$store.state.uid,
              phone: this.form.phone,
              username: this.form.recipientname,
              address: this.form.address
            }).then(res => {
              this.$message({
                message: res.msg,
                type: 'success',
                center: true,
                showClose: true,
              })
              this.reload()
            }).catch(err => {
              console.log(err)
            })
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      //选择地址
      choose(item) {
        this.$refs['ruleForm'].clearValidate()
        this.form.recipientname = item.username
        this.form.phone = item.phone
        this.form.address = item.address
        if(this.orderform){
          this.$emit("totop")
        }else {
          window.scrollTo({
                    top: 0,
                    behavior: "smooth"
                })
        }
      }
    },
    created() {
      if(this.orderform) {
        this.form.address = this.orderform.address
        this.form.phone = this.orderform.phone
        this.form.recipientname = this.orderform.recipientname
      }
    },
  }
</script>
<style scoped>

.title {
  text-align: center;
  margin-bottom: 1.5em;
  text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
  font-weight: 400;
}

.mainbar {
  width: 40em;
  margin: auto;
}

.but {
  display: flex;
  justify-content: space-between;
}

.chooseaddress {
  margin-top: 2em;
  color: rgb(140, 196, 253);
  font-size: 1.5em;
}
</style>