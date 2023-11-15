<!---->
<template>
  <div class="userchangemes">
    <div class="main">
      <!-- 头像 -->
      <div class="userimgbar">
        <div class="userimg" @mouseover="show" @mouseleave="noshow">
          <label for="uimg">
            <div class="add" v-show="flag.avatar">
              <img src="~assets/img/user/add.png" alt />
            </div>
            <img class="avatar" :src="userimg" alt />
          </label>
        </div>
        <div class="upload">
          <img src="~assets/img/user/upload.png" alt />
        </div>
        <input
          id="uimg"
          type="file"
          accept="image/*"
          @change="changephoto"
          :style="{ display: 'none' }"
        />
      </div>
      <!-- 个人信息 -->
      <div class="changeform">
        <el-form ref="form" :model="form" :rules="rules" label-width="80px">
          <el-form-item label="用户名" prop="username">
            <el-input
              clearable
              v-model="form.username"
              placeholder="请输入用户名"
            ></el-input>
          </el-form-item>
          <!-- <el-form-item label="真实姓名">
            <el-input :disabled="true" v-model="form.realname"></el-input>
          </el-form-item>
          <el-form-item label="身份证号">
            <el-input :disabled="true" v-model="form.idcard"></el-input>
          </el-form-item> -->
          <el-form-item label="性别">
            <el-radio v-model="form.sex" label="保密">保密</el-radio>
            <el-radio v-model="form.sex" label="男">男</el-radio>
            <el-radio v-model="form.sex" label="女">女</el-radio>
          </el-form-item>
          <!-- <el-form-item label="手机号" prop="telphone">
            <el-input v-model="form.telphone" placeholder="请输入电话号码"></el-input>
          </el-form-item>
          <el-form-item label="收货地址">
            <el-input v-model="form.address" placeholder="请输入地址"></el-input>
          </el-form-item> -->
          <el-button type="primary" @click="request('form')">提交</el-button>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import { requestqueryuser, requestupdateuser } from "network/requestuser.js";

export default {
  name: "UserChangeMes",
  data() {
    //验证用户名
    var checkusername = (rule, value, callback) => {
      if (!value) {
        return callback(new Error("用户名不能为空"));
      } else if (/^[A-Za-z0-9_\u4e00-\u9fa5]{3,16}$/.test(value)) {
        callback();
      } else {
        return callback(new Error("用户名只能是3到16位的字母,数字和中文"));
      }
    };
    //验证手机号
    var checktelphone = (rule, value, callback) => {
      if (value === "") {
        return callback(new Error("手机号不能为空"));
      } else if (/^1\d{10}$/.test(value)) {
        callback();
      } else {
        return callback(new Error("请输入11位手机号码，1xx xxxx xxxx"));
      }
    };
    return {
      userimg: "",
      form: {
        avatar: "",
        username: "",
        realname: "",
        idcard: "",
        sex: "",
        telphone: "",
        address: "",
      },
      flag: {
        avatar: false,
      },
      rules: {
        username: [{ validator: checkusername, trigger: "blur" }],
        telphone: [{ validator: checktelphone, trigger: "blur" }],
      },
    };
  },
  created() {
    requestqueryuser({
      uid: this.$store.state.uid,
    })
      .then((res) => {
        this.userimg = this.$store.state.avatar;
        this.form.username = res.username;
        this.form.realname = res.realname;
        this.form.idcard = res.idcard;
        this.form.sex = res.sex;
        this.form.telphone = res.telphone;
        if (res.address === null) {
          this.form.address = "";
        } else {
          this.form.address = res.address;
        }
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    show() {
      this.flag.avatar = true;
    },
    noshow() {
      this.flag.avatar = false;
    },
    changephoto(event) {
      this.form.avatar = event.target.files[0];
      let reader = new FileReader();
      reader.readAsDataURL(this.form.avatar);
      var that = this;
      reader.onload = function (e) {
        that.userimg = e.target.result;
      };
    },
    request(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          // console.log(this.form.avatar);
          let formData = new FormData();
          formData.append("file", this.form.avatar);
          formData.append("uid", this.$store.state.uid);
          formData.append("username", this.form.username);
          formData.append("sex", this.form.sex);
          // formData.append('telphone',this.form.telphone);
          // formData.append('address',this.form.address);
          requestupdateuser(formData)
            .then((res) => {
              if (res.flag === 1) {
                if (res.avatar != null) {
                  debugger;
                  this.$store.commit("setavatar", "/api/" + res.avatar);
                }
                this.$message({
                  message: res.msg,
                  type: "success",
                  center: true,
                  showClose: true,
                });
              } else {
                this.$message({
                  message: res.msg,
                  type: "error",
                  center: true,
                  showClose: true,
                });
              }
            })
            .catch((err) => {
              console.log(err);
            });
        } else {
          return false;
        }
      });
    },
  },
};
</script>
<style scoped>
.userchangemes {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.main {
  display: flex;
}

.changeform {
  margin-top: 2em;
  width: 30em;
}

.userimgbar {
  position: relative;
  margin-top: 4em;
  width: 380px;
  height: 180px;
}

.userimg {
  height: 180px;
  width: 180px;
  border-radius: 50%;
  overflow: hidden;
  margin: 0 auto;
}

.userimg .add {
  position: absolute;
  height: 180px;
  width: 180px;
  border-radius: 50%;
  cursor: pointer;
  background: rgba(27, 23, 23, 0.3);
}

.userimg .add img {
  position: absolute;
  top: 50%;
  left: 50%;
  margin-top: -16px;
  margin-left: -16px;
}

.upload {
  position: absolute;
  top: 0;
  left: 50%;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  margin-left: 30px;
  background: rgba(158, 155, 155, 0.7);
}

.upload img {
  position: absolute;
  top: 50%;
  left: 50%;
  margin-top: -10px;
  margin-left: -10px;
}

.userimg .avatar {
  width: 100%;
  height: 100%;
}
</style>
