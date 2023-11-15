<!--用户管理-->
<template>
  <div class="usermanage">
    <div class="selectbar">
      <el-form :inline="true" :model="form">
        <el-form-item label="用户id">
          <el-input
            clearable
            v-model="form.uid"
            placeholder="用户id"
          ></el-input>
        </el-form-item>
        <el-form-item label="用户名">
          <el-input
            clearable
            v-model="form.username"
            placeholder="用户名"
          ></el-input>
        </el-form-item>
        <el-form-item label="真实姓名">
          <el-input
            clearable
            v-model="form.realname"
            placeholder="真实姓名"
          ></el-input>
        </el-form-item>
        <el-form-item label="身份证">
          <el-input
            clearable
            v-model="form.idcard"
            placeholder="身份证"
          ></el-input>
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input
            clearable
            v-model="form.phone"
            placeholder="联系电话"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button
            clearable
            icon="el-icon-search"
            type="primary"
            circle
            @click="request"
          ></el-button>
        </el-form-item>
      </el-form>
    </div>
    <div>
      <el-table :data="user" style="width: 100%">
        <el-table-column prop="uid" label="id" sortable width="100">
        </el-table-column>
        <el-table-column label="用户头像" width="180">
          <template slot-scope="scope">
            <div class="avatar">
              <img :src="'/api/' + scope.row.avatar" alt="" />
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="username" label="用户名" width="180">
        </el-table-column>
        <el-table-column prop="password" label="登录密码" width="150">
        </el-table-column>
        <el-table-column prop="sex" label="性别" width="100"> </el-table-column>
        <el-table-column prop="realname" label="真实姓名" width="180">
        </el-table-column>
        <el-table-column prop="idcard" width="200" label="身份证号">
        </el-table-column>
        <el-table-column prop="telphone" label="手机号" width="180">
        </el-table-column>
        <el-table-column label="操作" width="180">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.$index, scope.row)"
              >编辑</el-button
            >
            <el-popconfirm
              confirmButtonText="确定"
              cancelButtonText="取消"
              placement="top"
              icon="el-icon-info"
              iconColor="red"
              title="确定删除该用户吗？"
              @confirm="handleDelete(scope.$index, scope.row)"
            >
              <el-button
                style="margin-left: 10px"
                size="mini"
                type="danger"
                slot="reference"
                >删除</el-button
              >
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="pagination">
      <el-pagination
        :hide-on-single-page="false"
        @current-change="handleCurrentChange"
        :page-size="pagesize"
        :pager-count="pagercount"
        :current-page.sync="currentpage"
        layout="total, prev, pager, next, jumper"
        :total="total"
      >
      </el-pagination>
    </div>
    <el-drawer :visible.sync="drawer" direction="rtl" size="50%">
      <div class="updatebar">
        <el-form :model="updateform" label-width="80px">
          <el-form-item label="用户名">
            <el-input
              v-model="updateform.username"
              placeholder="用户名"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item label="登录密码">
            <el-input
              v-model="updateform.password"
              placeholder="登录密码"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item label="性别">
            <el-radio-group v-model="updateform.sex">
              <el-radio label="保密">保密</el-radio>
              <el-radio label="男">男</el-radio>
              <el-radio label="女">女</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="真实姓名">
            <el-input
              v-model="updateform.realname"
              placeholder="真实姓名"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item label="身份证号">
            <el-input
              v-model="updateform.idcard"
              placeholder="身份证号"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item label="手机号">
            <el-input
              v-model="updateform.telphone"
              placeholder="手机号"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item>
            <div class="but">
              <el-button type="primary" @click="update">提交</el-button>
              <el-button type="primary" @click="drawer = false">取消</el-button>
            </div>
          </el-form-item>
        </el-form>
      </div>
    </el-drawer>
  </div>
</template>

<script>
import {
  requestqueryAllUser,
  requestcountuser,
  requestqueryuser,
  requestqueryuserby,
  requestdeleteUser,
  requestupdateuser,
} from "network/requestuser.js";

export default {
  name: "usermanage",
  data() {
    return {
      pagesize: 10,
      pagercount: 5,
      total: 10,
      currentpage: 1,
      drawer: false,
      form: {
        uid: "",
        username: "",
        realname: "",
        idcard: "",
        phone: "",
      },
      editform: {},
      updateform: {},
      user: [],
    };
  },
  created() {
    this.firstenter();
  },
  methods: {
    firstenter() {
      requestcountuser()
        .then((res) => {
          this.total = res;
        })
        .catch((err) => {
          console.log(err);
        });
      requestqueryAllUser({
        page: this.currentpage,
        count: this.total,
      })
        .then((res) => {
          this.user = res;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    handleCurrentChange() {
      requestqueryAllUser({
        page: this.currentpage,
        count: this.pagesize,
      })
        .then((res) => {
          this.user = res;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    request() {
      requestqueryuserby({
        uid: this.form.uid,
        username: this.form.username,
        realname: this.form.realname,
        idcard: this.form.idcard,
        telphone: this.form.phone,
      })
        .then((res) => {
          this.user = res.user;
          this.total = res.total;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    handleEdit(index, row) {
      this.editform = row;
      let editRow = JSON.stringify(row);
      this.updateform = JSON.parse(editRow);
      this.drawer = true;
    },
    handleDelete(index, row) {
      requestdeleteUser({
        uid: row.uid,
      })
        .then((res) => {
          this.$notify({
            title: "删除成功",
            message: res,
            offset: 100,
            type: "success",
          });
          this.firstenter();
        })
        .catch((err) => {
          console.log(err);
        });
    },
    update() {
      let formData = new FormData();
      formData.append("uid", this.updateform.uid);
      formData.append("username", this.updateform.username);
      formData.append("password", this.updateform.password);
      formData.append("sex", this.updateform.sex);
      formData.append("realname", this.updateform.realname);
      formData.append("idcard", this.updateform.idcard);
      formData.append("telphone", this.updateform.telphone);
      requestupdateuser(formData)
        .then((res) => {
          if (res.flag == 0) {
            this.$notify({
              title: "失败",
              message: res.msg,
              type: "error",
              offset: 100,
            });
          } else {
            this.$notify({
              title: "成功",
              message: res.msg,
              type: "success",
              offset: 100,
            });
            this.editform.username = this.updateform.username;
            this.editform.password = this.updateform.password;
            this.editform.sex = this.updateform.sex;
            this.editform.realname = this.updateform.realname;
            this.editform.idcard = this.updateform.idcard;
            this.editform.telphone = this.updateform.telphone;
            this.drawer = false;
          }
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>
<style scoped>
/* .usermanage {
  background: rgb(255, 255, 255);
  padding: 2.5em;
  height: 80vh;
} */

.selectbar {
  display: flex;
  margin-bottom: 1em;
}

.avatar {
  height: 2.5em;
}

.avatar img {
  height: 100%;
}

.updatebar {
  max-width: 30em;
  margin: auto;
}

.but {
  display: flex;
  justify-content: space-between;
}

.pagination {
  margin-top: 1em;
  display: flex;
  justify-content: center;
}
</style>