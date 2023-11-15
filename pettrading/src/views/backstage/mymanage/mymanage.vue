<!--后台个人管理-->
<template>
  <div class="mymanage">
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
          <el-form-item label="登录密码">
            <el-input
              clearable
              v-model="form.password"
              placeholder="请输入登录密码"
            ></el-input>
          </el-form-item>
          <el-button type="primary" @click="request('form')">修改</el-button>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import { requestqueryuser, requestupdateuser } from "network/requestuser.js";

export default {
  name: "mymanage",
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
    return {
      userimg: "",
      form: {
        username: "",
        password: "",
      },
      flag: {
        avatar: false,
      },
      rules: {
        username: [{ validator: checkusername, trigger: "blur" }],
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
        this.form.password = res.password;
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
      console.log(reader);
      reader.readAsDataURL(this.form.avatar);
      var that = this;
      reader.onload = function (e) {
        that.userimg = e.target.result;
      };
    },
    request(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          let formData = new FormData();
          formData.append("file", this.form.avatar);
          formData.append("uid", this.$store.state.uid);
          formData.append("username", this.form.username);
          formData.append("password", this.form.password);
          requestupdateuser(formData)
            .then((res) => {
              if (res.flag === 1) {
                if (res.avatar != null) {
                  this.$store.commit("setavatar", "/api/" + res.avatar);
                }
                this.$notify({
                  title: "修改成功",
                  message: res.msg,
                  type: "success",
                  offset: 100,
                });
              } else {
                this.$notify({
                  title: "修改失败",
                  message: res.msg,
                  type: "error",
                  offset: 100,
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
.mymanage {
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
