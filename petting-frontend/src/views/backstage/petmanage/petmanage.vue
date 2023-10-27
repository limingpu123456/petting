<!--宠物管理-->
<template>
  <div class="petmanage">
    <div class="selectbar">
      <el-form :inline="true" :model="form">
        <el-form-item label="宠物id">
          <el-input
            clearable
            v-model="form.pid"
            placeholder="宠物id"
          ></el-input>
        </el-form-item>
        <el-form-item label="用户id">
          <el-input
            clearable
            v-model="form.uid"
            placeholder="用户id"
          ></el-input>
        </el-form-item>
        <el-form-item label="宠物状态">
          <el-select
            style="width: 100%"
            v-model="form.pk"
            clearable
            filterable
            placeholder="宠物状态"
          >
            <el-option
              v-for="item in pk"
              :key="item.pkid"
              :label="item.pkname"
              :value="item.pkid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="宠物名称">
          <el-input
            clearable
            v-model="form.petname"
            placeholder="宠物名称"
          ></el-input>
        </el-form-item>
        <el-form-item label="宠物类型">
          <el-select
            @change="bkindchange"
            style="width: 100%"
            v-model="form.bkid"
            clearable
            filterable
            placeholder="宠物类型"
          >
            <el-option
              v-for="item in bkind"
              :key="item.bkid"
              :label="item.bkindname"
              :value="item.bkid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="宠物品种">
          <el-select
            @change="skindchange"
            style="width: 100%"
            v-model="form.skid"
            clearable
            filterable
            placeholder="宠物品种"
          >
            <el-option
              v-for="item in fskind"
              :key="item.skid"
              :label="item.skindname"
              :value="item.skid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="宠物年龄">
          <el-input
            clearable
            v-model="form.age"
            placeholder="宠物年龄"
          ></el-input>
        </el-form-item>
        <el-form-item label="宠物价格">
          <el-input
            clearable
            v-model="form.price"
            placeholder="宠物价格"
          ></el-input>
        </el-form-item>
        <el-form-item label="发布时间">
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
            icon="el-icon-search"
            type="primary"
            circle
            @click="request"
          ></el-button>
        </el-form-item>
      </el-form>
    </div>
    <div>
      <el-table :data="pet" style="width: 100%">
        <el-table-column prop="pid" sortable label="宠物id" width="86">
        </el-table-column>
        <el-table-column label="用户id" prop="uid" width="86">
        </el-table-column>
        <el-table-column label="宠物主图" width="100">
          <template slot-scope="scope">
            <div class="photo">
              <img :src="'/api/' + scope.row.photo[0].url" alt="" />
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="petname" label="宠物名称" width="180">
        </el-table-column>
        <el-table-column prop="bkind.bkindname" label="类型" width="100">
        </el-table-column>
        <el-table-column prop="skind.skindname" label="品种" width="100">
        </el-table-column>
        <el-table-column prop="sex" label="性别" width="80"> </el-table-column>
        <el-table-column width="100" label="年龄">
          <template slot-scope="scope">
            <span v-if="scope.row.age != -1">{{ scope.row.age }}个月</span>
            <span v-if="scope.row.age == -1">不限</span>
          </template>
        </el-table-column>
        <el-table-column width="100" label="价格">
          <template slot-scope="scope">
            <span v-if="scope.row.price != -1">{{ scope.row.price }}</span>
            <span v-if="scope.row.price == -1">不限</span>
          </template>
        </el-table-column>
        <el-table-column prop="description" label="发布说明"> </el-table-column>
        <el-table-column width="100" label="状态">
          <template slot-scope="scope">
            <span style="color: rgb(255, 194, 8)" v-if="scope.row.pk == 0"
              >出售中</span
            >
            <span style="color: rgb(102, 177, 255)" v-if="scope.row.pk == 1"
              >已出售</span
            >
            <span style="color: rgb(33, 213, 168)" v-if="scope.row.pk == 2"
              >已完成</span
            >
            <span style="color: pink" v-if="scope.row.pk == 3">求购中</span>
          </template>
        </el-table-column>
        <el-table-column prop="date" width="180" sortable label="发布时间">
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
          <el-form-item label="宠物名称">
            <el-input
              v-model="updateform.petname"
              placeholder="宠物名称"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item label="宠物类型">
            <el-select
              @change="updatebkindchange"
              style="width: 100%"
              v-model="updateform.bkid"
              clearable
              filterable
              placeholder="宠物类型"
            >
              <el-option
                v-for="item in bkind"
                :key="item.bkid"
                :label="item.bkindname"
                :value="item.bkid"
              >
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="宠物品种">
            <el-select
              @change="updateskindchange"
              style="width: 100%"
              v-model="updateform.skid"
              clearable
              filterable
              placeholder="宠物品种"
            >
              <el-option
                v-for="item in fskind"
                :key="item.skid"
                :label="item.skindname"
                :value="item.skid"
              >
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="性别">
            <el-radio-group v-model="updateform.sex">
              <el-radio label="不限">不限</el-radio>
              <el-radio label="男">男</el-radio>
              <el-radio label="女">女</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="年龄">
            <el-input
              v-model="updateform.age"
              placeholder="年龄"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item label="价格">
            <el-input
              v-model="updateform.price"
              placeholder="价格"
              clearable
            ></el-input>
          </el-form-item>
          <el-form-item label="宠物状态">
            <el-select
              style="width: 100%"
              v-model="updateform.pk"
              clearable
              filterable
              placeholder="宠物状态"
            >
              <el-option
                v-for="item in pk"
                :key="item.pkid"
                :label="item.pkname"
                :value="item.pkid"
              >
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="发布说明">
            <el-input
              type="textarea"
              placeholder="发布说明"
              clearable
              rows="4"
              resize="none"
              show-word-limit
              v-model="updateform.description"
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
import { requestqueryBKindandSKind } from "network/requestbkind.js";
import { requestqueryallskind } from "network/requestskind.js";
import {
  requestquerypetpage,
  requestdeletePet,
  requestupdatePet,
  requestquerypetcount,
} from "network/requestpet.js";

export default {
  name: "petmanage",
  data() {
    return {
      pagesize: 8,
      pagercount: 5,
      total: 8,
      currentpage: 1,
      form: {
        bkid: "",
        skid: "",
      },
      pet: [],
      bkind: [],
      skind: [],
      fskind: [],
      editform: {},
      updateform: {
        bkid: "",
        skid: "",
      },
      pk: [
        {
          pkid: 0,
          pkname: "出售中",
        },
        {
          pkid: 1,
          pkname: "已出售",
        },
        {
          pkid: 2,
          pkname: "已完成",
        },
        {
          pkid: 3,
          pkname: "求购中",
        },
      ],
      drawer: false,
    };
  },
  created() {
    requestquerypetcount()
      .then((res) => {
        this.total = res;
      })
      .catch((err) => {
        console.log(err);
      });
    requestquerypetpage({
      page: this.currentpage,
      count: this.pagesize,
    })
      .then((res) => {
        this.pet = res;
      })
      .catch((err) => {
        console.log(err);
      });
    //查询所有宠物类型及对应品种
    requestqueryBKindandSKind()
      .then((res) => {
        this.bkind = res;
      })
      .catch((err) => {
        console.log(err);
      });
    //查询所有宠物品种
    requestqueryallskind()
      .then((res) => {
        this.skind = res;
        this.fskind = this.skind.filter((n) => {
          return n.skindname != "其他";
        });
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    handleCurrentChange() {
      requestquerypetpage({
        page: this.currentpage,
        count: this.pagesize,
        pid: this.form.pid,
        uid: this.form.uid,
        pk: this.form.pk,
        petname: this.form.petname,
        bkid: this.form.bkid,
        skid: this.form.skid,
        age: this.form.age,
        price: this.form.price,
        date: this.form.date,
      })
        .then((res) => {
          this.pet = res;
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
      requestdeletePet({
        pid: row.pid,
      })
        .then((res) => {
          this.$notify({
            title: "删除成功",
            message: res,
            offset: 100,
            type: "success",
          });
          this.total--;
          requestquerypetpage({
            page: this.currentpage,
            count: this.pagesize,
            sort: "sp.pid",
            pid: this.form.pid,
            uid: this.form.uid,
            pk: this.form.pk,
            petname: this.form.petname,
            bkid: this.form.bkid,
            skid: this.form.skid,
            age: this.form.age,
            price: this.form.price,
            date: this.form.date,
          })
            .then((res) => {
              this.pet = res;
            })
            .catch((err) => {
              console.log(err);
            });
        })
        .catch((err) => {
          console.log(err);
        });
    },
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
    //选中品种时，选中对应类型
    skindchange() {
      if (this.form.skid != "") {
        let sbk = this.fskind.find((n) => {
          return n.skid === this.form.skid;
        });
        this.form.bkid = sbk.bkid;
      }
    },
    updatebkindchange() {
      if (this.updateform.bkid === "") {
        this.fskind = this.skind.filter((n) => {
          return n.skindname != "其他";
        });
      } else {
        this.fskind = this.skind.filter((n) => {
          return n.bkid === this.updateform.bkid;
        });
        let bsk = this.fskind.filter((n) => {
          return n.skid === this.updateform.skid;
        });
        if (bsk.length === 0) {
          this.updateform.skid = "";
        }
      }
    },
    //选中品种时，选中对应类型
    updateskindchange() {
      if (this.updateform.skid != "") {
        let sbk = this.fskind.find((n) => {
          return n.skid === this.updateform.skid;
        });
        this.updateform.bkid = sbk.bkid;
      }
    },
    request() {
      this.currentpage = 1;
      requestquerypetcount({
        pid: this.form.pid,
        uid: this.form.uid,
        pk: this.form.pk,
        petname: this.form.petname,
        bkid: this.form.bkid,
        skid: this.form.skid,
        age: this.form.age,
        price: this.form.price,
        date: this.form.date,
      })
        .then((res) => {
          this.total = res;
        })
        .catch((err) => {
          console.log(err);
        });
      requestquerypetpage({
        page: this.currentpage,
        count: this.pagesize,
        pid: this.form.pid,
        uid: this.form.uid,
        pk: this.form.pk,
        petname: this.form.petname,
        bkid: this.form.bkid,
        skid: this.form.skid,
        age: this.form.age,
        price: this.form.price,
        date: this.form.date,
      })
        .then((res) => {
          this.pet = res;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    update() {
      let formData = new FormData();
      formData.append("pid", this.updateform.pid);
      formData.append("petname", this.updateform.petname);
      formData.append("bkid", this.updateform.bkid);
      formData.append("skid", this.updateform.skid);
      formData.append("sex", this.updateform.sex);
      formData.append("age", this.updateform.age);
      formData.append("price", this.updateform.price);
      formData.append("pk", this.updateform.pk);
      formData.append("description", this.updateform.description);
      requestupdatePet(formData)
        .then((res) => {
          this.$notify({
            title: "修改成功",
            message: "该宠物信息修改成功",
            type: "success",
            offset: 100,
          });
          this.editform.petname = this.updateform.petname;
          this.editform.bkid = this.updateform.bkid;
          this.editform.skid = this.updateform.skid;
          this.bkind.forEach((value) => {
            if (value.bkid == this.updateform.bkid) {
              this.editform.bkind = value;
            }
          });
          this.skind.forEach((value) => {
            if (value.skid == this.updateform.skid) {
              this.editform.skind = value;
            }
          });
          this.editform.sex = this.updateform.sex;
          this.editform.age = this.updateform.age;
          this.editform.price = this.updateform.price;
          this.editform.pk = this.updateform.pk;
          this.editform.description = this.updateform.description;
          this.drawer = false;
        })
        .catch((err) => {});
    },
  },
};
</script>
<style scoped>
.selectbar {
  display: flex;
}

.photo {
  height: 2.5em;
}

.photo img {
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