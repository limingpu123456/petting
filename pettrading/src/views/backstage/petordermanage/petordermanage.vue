<!--订单管理-->
<template>
  <div class="petordermanage">
    <div class="selectbar">
      <el-form :inline="true" :model="form">
        <el-form-item label="订单id">
          <el-input
            clearable
            v-model="form.poid"
            placeholder="宠物id"
          ></el-input>
        </el-form-item>
        <el-form-item label="订单宠物id">
          <el-input
            clearable
            v-model="form.pid"
            placeholder="宠物名称"
          ></el-input>
        </el-form-item>
        <el-form-item label="下单用户id">
          <el-input
            clearable
            v-model="form.uid"
            placeholder="用户id"
          ></el-input>
        </el-form-item>
        <el-form-item label="收件人">
          <el-input
            clearable
            v-model="form.recipientname"
            placeholder="收件人"
          ></el-input>
        </el-form-item>
        <el-form-item label="收货地址">
          <el-input
            clearable
            v-model="form.address"
            placeholder="收货地址"
          ></el-input>
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input
            clearable
            v-model="form.phone"
            placeholder="联系电话"
          ></el-input>
        </el-form-item>
        <el-form-item label="宠物状态">
          <el-select
            style="width: 100%"
            v-model="form.postatu"
            clearable
            filterable
            placeholder="宠物状态"
          >
            <el-option
              v-for="item in postatus"
              :key="item.postatu"
              :label="item.postatuname"
              :value="item.postatu"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="下单时间">
          <el-date-picker
            type="date"
            format="yyyy-MM-dd"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
            v-model="form.date"
          ></el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button
            @click="querypetorder"
            icon="el-icon-search"
            type="primary"
            circle
          ></el-button>
        </el-form-item>
      </el-form>
    </div>
    <div>
      <el-table :data="petorder" style="width: 100%">
        <el-table-column prop="poid" label="订单id" sortable width="90">
        </el-table-column>
        <el-table-column prop="pid" label="宠物id" width="90">
        </el-table-column>
        <el-table-column prop="pet.petname" label="宠物名称" width="130">
        </el-table-column>
        <el-table-column prop="uid" label="下单用户id" width="100">
        </el-table-column>
        <el-table-column prop="user.username" label="下单用户名" width="130">
        </el-table-column>
        <el-table-column prop="recipientname" label="收件人" width="100">
        </el-table-column>
        <el-table-column prop="address" label="收货地址"> </el-table-column>
        <el-table-column prop="phone" label="联系电话" width="150">
        </el-table-column>
        <el-table-column width="100" label="订单状态">
          <template slot-scope="scope">
            <span style="color: rgb(255, 194, 8)" v-if="scope.row.postatu == 0"
              >进行中</span
            >
            <span style="color: rgb(33, 213, 168)" v-if="scope.row.postatu == 1"
              >已完成</span
            >
            <span
              style="color: rgb(204, 203, 203)"
              v-if="scope.row.postatu == 2"
              >已取消</span
            >
            <span
              style="color: rgb(102, 177, 255)"
              v-if="scope.row.postatu == 3"
              >修改中</span
            >
            <span style="color: red" v-if="scope.row.postatu == 4">取消中</span>
          </template>
        </el-table-column>
        <el-table-column prop="date" sortable label="下单时间" width="180">
        </el-table-column>
        <el-table-column label="操作" width="150">
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
          <el-form-item label="收件人">
            <el-input
              v-model="updateform.recipientname"
              placeholder="收货人"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item label="收货地址">
            <el-input
              v-model="updateform.address"
              placeholder="收货地址"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item label="联系电话">
            <el-input
              v-model="updateform.phone"
              placeholder="联系电话"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item label="订单状态">
            <el-select
              style="width: 100%"
              v-model="updateform.postatu"
              clearable
              filterable
              placeholder="宠物状态"
            >
              <el-option
                v-for="item in postatus"
                :key="item.postatu"
                :label="item.postatuname"
                :value="item.postatu"
              >
              </el-option>
            </el-select>
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
  requestquerypetorderpage,
  requestdeletepetorder,
  requestupdatepetorder,
} from "network/requestpetorder.js";

export default {
  name: "petordermanage",
  data() {
    return {
      pagesize: 10,
      pagercount: 5,
      total: 10,
      currentpage: 1,
      //0-进行中，1-已完成，2-已取消，3-修改中，4-取消中
      postatus: [
        {
          postatu: 0,
          postatuname: "进行中",
        },
        {
          postatu: 1,
          postatuname: "已完成",
        },
        {
          postatu: 2,
          postatuname: "已取消",
        },
        {
          postatu: 3,
          postatuname: "修改中",
        },
        {
          postatu: 4,
          postatuname: "取消中",
        },
      ],
      form: {},
      petorder: [],
      editform: {},
      updateform: {},
      drawer: false,
    };
  },
  created() {
    requestquerypetorderpage({
      page: this.currentpage,
      count: this.pagesize,
    })
      .then((res) => {
        this.petorder = res.petorder;
        this.total = res.total;
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    handleCurrentChange() {
      requestquerypetorderpage({
        poid: this.form.poid,
        pid: this.form.pid,
        uid: this.form.uid,
        recipientname: this.form.recipientname,
        address: this.form.address,
        phone: this.form.phone,
        postatu: this.form.postatu,
        date: this.form.date,
        page: this.currentpage,
        count: this.pagesize,
      })
        .then((res) => {
          this.petorder = res.petorder;
          this.total = res.total;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    querypetorder() {
      this.currentpage = 1;
      requestquerypetorderpage({
        poid: this.form.poid,
        pid: this.form.pid,
        uid: this.form.uid,
        recipientname: this.form.recipientname,
        address: this.form.address,
        phone: this.form.phone,
        postatu: this.form.postatu,
        date: this.form.date,
        page: this.currentpage,
        count: this.pagesize,
      })
        .then((res) => {
          this.petorder = res.petorder;
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
      requestdeletepetorder({
        poid: row.poid,
      })
        .then((res) => {
          this.$notify({
            title: "删除成功",
            message: res,
            offset: 100,
            type: "success",
          });
          requestquerypetorderpage({
            poid: this.form.poid,
            pid: this.form.pid,
            uid: this.form.uid,
            recipientname: this.form.recipientname,
            address: this.form.address,
            phone: this.form.phone,
            postatu: this.form.postatu,
            date: this.form.date,
            page: this.currentpage,
            count: this.pagesize,
          })
            .then((res) => {
              this.petorder = res.petorder;
              this.total = res.total;
            })
            .catch((err) => {
              console.log(err);
            });
        })
        .catch((err) => {
          console.log(err);
        });
    },
    update() {
      requestupdatepetorder({
        poid: this.updateform.poid,
        recipientname: this.updateform.recipientname,
        address: this.updateform.address,
        phone: this.updateform.phone,
        postatu: this.updateform.postatu,
      })
        .then((res) => {
          this.$notify({
            title: "修改成功",
            message: "订单修改成功",
            type: "success",
            offset: 100,
          });
          this.editform.recipientname = this.updateform.recipientname;
          this.editform.address = this.updateform.address;
          this.editform.phone = this.updateform.phone;
          this.editform.postatu = this.updateform.postatu;
          this.drawer = false;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>
<style scoped>
.selectbar {
  display: flex;
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