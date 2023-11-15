<!---->
<template>
  <div class='wantbuy'>
    <breadcrumb>
      <span slot="second" @click="tobuying">求购专区</span> > 发布求购
    </breadcrumb>
    <div class="title">
      <h1>发布求购信息</h1>
    </div>
    <div class="buy">
      <el-form :rules="rules" ref="ruleForm" label-width="80px" :model="form">
        <el-form-item label="宠物名称" prop="name">
          <el-input v-model="form.name" clearable placeholder="请输入宠物名称"></el-input>
        </el-form-item>
        <el-form-item label="宠物类型" prop="bkid">
          <el-select @change="bkindchange" style="width: 100%" v-model="form.bkid" clearable filterable placeholder="请选择宠物类型">
            <el-option
              v-for="item in bkind"
              :key="item.bkid"
              :label="item.bkindname"
              :value="item.bkid">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="宠物品种" prop="skid">
          <el-select @change="skindchange" style="width: 100%" v-model="form.skid" clearable filterable placeholder="请选择宠物品种">
            <el-option
              v-for="item in fskind"
              :key="item.skid"
              :label="item.skindname"
              :value="item.skid">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="宠物性别" prop="sex">
          <el-radio v-model="form.sex" label="不限">不限</el-radio>
          <el-radio v-model="form.sex" label="男">男</el-radio>
          <el-radio v-model="form.sex" label="女">女</el-radio>
        </el-form-item>
        <el-form-item label="宠物年龄" prop="age">
          <el-radio-group v-model="agelimit" @change="clearage">
            <el-radio :label=true>不限制</el-radio>
            <el-radio :label=false>限制</el-radio>
          </el-radio-group>
          <div style="width: 100%">
            <el-input clearable placeholder="请输入宠物年龄(单位月)" v-model.number="form.age" :disabled="agelimit"></el-input>
          </div>
        </el-form-item>
        <el-form-item label="求购价格" prop="price">
          <el-radio-group v-model="pricelimit" @change="clearprice">
            <el-radio :label=true>不限制</el-radio>
            <el-radio :label=false>限制</el-radio>
          </el-radio-group>
          <div style="width: 100%">
            <!-- <el-input-number v-model="form.minprice" :disabled="pricelimit" controls-position="right" :min="0"></el-input-number>
            ——
            <el-input-number v-model="form.maxprice" :disabled="pricelimit" controls-position="right" :min="0"></el-input-number> -->
            <el-input v-model="form.price" :disabled="pricelimit" placeholder="请输入可接受的最高价格（单位元）" clearable></el-input>
          </div>
        </el-form-item>
        <!-- <el-form-item label="联系电话" prop="phone">
          <el-input placeholder="请输入手机号" clearable v-model="form.phone"></el-input>
        </el-form-item> -->
        <el-form-item label="求购说明">
          <el-input type="textarea" placeholder="请输入内容" clearable rows=4 resize="none" show-word-limit v-model="form.desc"></el-input>
        </el-form-item>
        <el-form-item label="宠物照片" prop="photo">
          <el-upload
            class="upload-demo"
            ref="upload"
            action
            multiple
            list-type="picture-card"
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :on-change="handleChange"
            :on-exceed="handleExceed"
            :file-list="form.photo"
            :auto-upload="false">
            <i class="el-icon-plus"></i>
            <div slot="tip" class="el-upload__tip">最多上传5张图片,且每张图片不得超过10m</div>
          </el-upload>
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
          <!-- <span class="">请选择上传的图片</span> -->
        </el-form-item>
        <el-form-item>
          <el-button v-if="!$route.query.form" type="primary" @click="request('ruleForm')">立即创建</el-button>
          <el-button v-if="$route.query.form" type="primary" @click="updatepet('ruleForm')">确认修改</el-button>
        </el-form-item>
      </el-form>
    </div>
    <!-- <sidebar></sidebar> -->
  </div>
</template>

<script>
  import Breadcrumb from "components/common/breadcrumb/Breadcrumb.vue"
  import Sidebar from "components/content/sidebar/Sidebar.vue"

  import {requestqueryBKindandSKind} from "network/requestbkind.js"
  import {requestqueryallskind} from "network/requestskind.js"
  import {requestaddpet,requestupdatePet} from "network/requestpet.js"

  export default {
    name: 'Wantbuy',
    components: {
      Breadcrumb,
      Sidebar
    },
    data () {
      //验证手机号
      // var checkphone = (rule, value, callback) => {
      //   if(!value) {
      //     return callback(new Error('联系电话不能为空'));
      //   }
      //   if(/^1\d{10}$/.test(this.form.phone)) {
      //     callback();
      //   }else {
      //     callback(new Error('请输入11位手机号码，1xx xxxx xxxx'));
      //   }
      // }
      //验证图片
      var checkphoto = (rule, value, callback) => {
        if(value.length > 5) {
          return callback(new Error('最多上传5张'));
        }else {
          for(let i=0;i<value.length;i++) {
            if(value[i].size / 1024 / 1024 > 10) {
              return callback(new Error('每张图片不可超过10m'));
            }
          }
          callback();
        }
      }
      //验证价格
      var checkprice = (rule, value, callback) => {
        if(this.pricelimit === true){
          return callback();
        }else if(/^\d+(\.\d+)?$/.test(this.form.price)) {
          return callback();
        }else {
          callback(new Error('请输入数字值'));
        }
      }
      //验证年龄
      var checkage = (rule, value, callback) => {
        if(this.agelimit === true) {
          return callback();
        }else if(!Number.isInteger(value)) {
          return callback(new Error('请输入数字值（单位月）'));
        }else {
          callback();
        }
      }
      return {
        pk: 3,
        dialogImageUrl: '',
        dialogVisible: false,
        agelimit: true,
        pricelimit: true,
        bkind: [],
        skind: [],
        fskind: [],
        form: {
          pid: '',
          name:'',
          bkid: '',
          skid: '',
          sex: '不限',
          price: '',
          age: '',
          phone: '',
          desc: '',
          photo: [],
          ppid: []
        },
        rules: {
          name: [
            { required: true, message: '请输入宠物名称', trigger: 'blur' }
          ],
          bkid: [
            { required: true, message: '请选择宠物类型', trigger: 'change' }
          ],
          skid: [
            { required: true, message: '请选择宠物品种', trigger: 'change' }
          ],
          sex: [
            { required: true, trigger: 'change' }
          ],
          age: [
            { validator: checkage, trigger: 'blur' }
          ],
          price: [
            { validator: checkprice, trigger: 'blur' }
          ],
          // phone: [
          //   { required: true, validator: checkphone, trigger: 'blur' }
          // ],
          photo: [
            { validator: checkphoto, trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      //选中类型时，筛选出对应品种
      bkindchange() {
        if(this.form.bkid === ""){
          this.fskind = this.skind.filter(n => {
            return n.skindname != "其他"
          })
        }else {
          this.fskind = this.skind.filter(n => {
            return n.bkid === this.form.bkid
          })
          let bsk = this.fskind.filter(n => {
            return n.skid === this.form.skid
          })
          if(bsk.length === 0) {
            this.form.skid = ""
          }
        }
      },
      //选中品种时，选中对应类型
      skindchange() {
        if(this.form.skid != ""){
          let sbk = this.fskind.find(n => {
            return n.skid === this.form.skid
          })
          this.form.bkid = sbk.bkid
        }
      },
      clearage() {
        this.$refs['ruleForm'].clearValidate('age');
      },
      clearprice() {
        this.$refs['ruleForm'].clearValidate('price');
      },
      handleChange(file, fileList) {
        this.form.photo = fileList;
      },
      handleRemove(file, fileList) {
        if(file.ppid) {
          if(this.form.ppid) {
            this.form.ppid.push(file.ppid)
          } else {
            this.form.ppid = []
            this.form.ppid.push(file.ppid)
          }
        }
        this.form.photo = fileList;
      },
      handlePreview(file) {
        // console.log(file);
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },
      handleExceed(files, fileList) {
        // this.$message.warning(`最多选择3个文件`);
      },
      //创建宠物
      request(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            if(this.form.desc == "") {
              this.form.desc = "暂无"
            }
            let formData = new FormData();
            formData.append('petname', this.form.name);
            formData.append('pk', this.pk);
            formData.append('bkid', this.form.bkid);
            formData.append('skid', this.form.skid);
            formData.append('sex', this.form.sex);
            formData.append('uid', this.$store.state.uid);
            if(this.agelimit === false) {
              formData.append('age', this.form.age);
            }else {
              formData.append('age', -1);
            }
            if(this.pricelimit === false) {
              formData.append('price', this.form.price);
            }else {
              formData.append('price', -1);
            }
            formData.append('description', this.form.desc);
            for(var i=0;i<this.form.photo.length;i++){
              formData.append('files', this.form.photo[i].raw);
            }
            requestaddpet(
              formData
            ).then(res => {
              this.$notify({
                title: '成功',
                message: res,
                type: 'success',
                offset: 100
              });
              this.$router.go(-1)
            }).catch(err => {
              console.log(err);
            })
          } else {
            this.$notify({
              title: '失败',
              message: '请输入正确的宠物信息',
              type: 'error',
              offset: 100
            });
            return false;
          }
        });
      },
      //修改宠物
      updatepet(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            if(this.form.desc == "") {
              this.form.desc = "暂无"
            }
            let formData = new FormData();
            formData.append('pid', this.form.pid);
            formData.append('petname', this.form.name);
            formData.append('pk', this.pk);
            formData.append('bkid', this.form.bkid);
            formData.append('skid', this.form.skid);
            formData.append('sex', this.form.sex);
            formData.append('uid', this.$store.state.uid);
            if(this.agelimit === false) {
              formData.append('age', this.form.age);
            }else {
              formData.append('age', -1);
            }
            if(this.pricelimit === false) {
              formData.append('price', this.form.price);
            }else {
              formData.append('price', -1);
            }
            formData.append('description', this.form.desc);
            for(var i=0;i<this.form.photo.length;i++){
              if(this.form.photo[i].raw){
                formData.append('files', this.form.photo[i].raw);
              }
            }
            if(this.form.ppid){
              this.form.ppid.forEach((value) => {
                formData.append('ppid', value);
              })
            }
            requestupdatePet(
              formData
            ).then(res => {
              this.$notify({
                title: '成功',
                message: res,
                type: 'success',
                offset: 100
              });
              this.$router.go(-1)
            }).catch(err => {
              console.log(err);
            })
          } else {
            this.$notify({
              title: '失败',
              message: '请输入正确的宠物信息',
              type: 'error',
              offset: 100
            });
            return false;
          }
        });
      },
      tobuying () {
        this.$router.push('/buying');
      }
    },
    created() {
      //查询所有宠物类型及对应品种
      requestqueryBKindandSKind().then(res => {
          this.bkind = res;
        }).catch(err => {
          console.log(err)
        });
      //查询所有宠物品种
      requestqueryallskind().then(res => {
        this.skind = res;
        if(this.$route.params.bkid) {
          this.form.bkid = this.$route.params.bkid
          this.fskind = this.skind.filter(n => {
            return n.bkid === this.form.bkid
          })
        }else {
          this.fskind = this.skind.filter(n => {
            return n.skindname != "其他"
          })
        }
      }).catch(err => {
        console.log(err)
      })
      if(this.$route.query.form){
        let oldform = JSON.parse(this.$route.query.form)
        this.form = oldform
        let photo = this.form.photo
        photo.forEach((value,index,array) => {
          photo[index].url = '/api/' + photo[index].url
        })
        if(this.form.age == -1) {
          this.form.age = ""
        }else {
          this.agelimit = false
        }
        if(this.form.price == -1) {
          this.form.price = ""
        }else {
          this.pricelimit = false
        }
      }
    }
  }
</script>
<style scoped>

.wantbuy {
  /* margin-top: 110px; */
  margin-top: 50px;
}

.buy {
  width: 45.7em;
  margin: auto;
}

.title {
  text-align: center;
  margin-bottom: 1.5em;
  text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.3);
  font-weight: 400;
}
</style>