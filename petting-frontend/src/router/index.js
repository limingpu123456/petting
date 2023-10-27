import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

// 路由连续点击报错解决方案
const originalPush = VueRouter.prototype.push;
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch((err) => err);
};

const Home = () => import("views/home/home.vue");
const Buying = () => import("views/buying/Buying.vue");
const Presell = () => import("views/presell/Presell.vue");
const Login = () => import("views/login/Login.vue");
const Register = () => import("views/register/Register.vue");
const Wantbuy = () => import("views/buying/Wantbuy.vue");
const Wantsell = () => import("views/presell/Wantsell.vue");
const Detail = () => import("views/detail/Detail.vue");
const User = () => import("views/user/User.vue");
const UserMessage = () => import("views/user/childcomps/UserMessage.vue");
const UserChangeMes = () => import("views/user/childcomps/UserChangeMes.vue");
const UserPlace = () => import("views/user/childcomps/UserPlace.vue");
const UserSafety = () => import("views/user/childcomps/UserSafety.vue");
const purchase = () => import("views/purchase/purchase.vue");
const PetOrder = () => import("views/petorder/PetOrder.vue");
const Pet = () => import("views/pet/Pet.vue");
const Usercenters = () => import("views/usercenters/Usercenters.vue");
const backstage = () => import("views/backstage/backstage.vue");
const petmanage = () => import("views/backstage/petmanage/petmanage.vue");
const petkindmanage = () =>
  import("views/backstage/petmanage/petkindmanage.vue");
const usermanage = () => import("views/backstage/usermanage/usermanage.vue");
const addressmanage = () =>
  import("views/backstage/usermanage/addressmanage.vue");
const petordermanage = () =>
  import("views/backstage/petordermanage/petordermanage.vue");
const mymanage = () => import("views/backstage/mymanage/mymanage.vue");
const about = () => import("views/about/about.vue");

const routes = [
  {
    path: "",
    redirect: "/home",
  },
  {
    path: "/home",
    component: Home,
    meta: {
      title: "宠物交易",
    },
  },
  {
    path: "/buying",
    component: Buying,
    meta: {
      title: "宠物求购",
    },
  },
  {
    path: "/presell",
    component: Presell,
    meta: {
      title: "宠物预售",
    },
  },
  {
    path: "/login",
    component: Login,
    meta: {
      title: "宠物交易-登录",
    },
  },
  {
    path: "/register",
    component: Register,
    meta: {
      title: "宠物交易-注册",
    },
  },
  {
    path: "/about",
    component: about,
  },
  {
    path: "/wantbuy",
    name: "wantbuy",
    component: Wantbuy,
    meta: {
      title: "宠物交易-求购",
    },
  },
  {
    path: "/wantsell",
    component: Wantsell,
    meta: {
      title: "宠物交易-出售",
    },
  },
  {
    path: "/detail",
    component: Detail,
    meta: {
      title: "宠物交易-宠物详情",
    },
  },
  {
    path: "/purchase",
    component: purchase,
    meta: {
      title: "购买",
    },
  },
  {
    path: "/usercenters",
    component: Usercenters,
    meta: {
      title: "用户管理",
    },
    children: [
      {
        path: "",
        redirect: "user",
      },
      {
        path: "user",
        component: User,
        meta: {
          title: "宠物交易-个人中心",
        },
        children: [
          {
            path: "",
            redirect: "message",
          },
          {
            path: "message",
            component: UserMessage,
            meta: {
              title: "个人信息",
            },
          },
          {
            path: "changemessage",
            component: UserChangeMes,
            meta: {
              title: "修改资料",
            },
          },
          {
            path: "userplace",
            component: UserPlace,
            meta: {
              title: "地址管理",
            },
          },
          {
            path: "safety",
            component: UserSafety,
            meta: {
              title: "安全中心",
            },
          },
        ],
      },
      {
        path: "petorder",
        component: PetOrder,
        meta: {
          title: "我的订单",
        },
      },
      {
        path: "pet",
        component: Pet,
        meta: {
          title: "我的宠物",
        },
      },
    ],
  },
  {
    path: "/backstage",
    component: backstage,
    meta: {
      title: "后台管理",
    },
    children: [
      {
        path: "",
        redirect: "mymanage",
      },
      {
        path: "mymanage",
        component: mymanage,
        meta: {
          title: "个人管理",
        },
      },
      {
        path: "usermanage",
        component: usermanage,
        meta: {
          title: "用户管理",
        },
      },
      {
        path: "addressmanage",
        component: addressmanage,
        meta: {
          title: "地址管理",
        },
      },
      {
        path: "petmanage",
        component: petmanage,
        meta: {
          title: "宠物管理",
        },
      },
      {
        path: "petkindmanage",
        component: petkindmanage,
        meta: {
          title: "宠物种类管理",
        },
      },
      {
        path: "petordermanage",
        component: petordermanage,
        meta: {
          title: "订单管理",
        },
      },
    ],
  },
];

const router = new VueRouter({
  mode: "history",
  routes,
});

router.beforeEach((to, from, next) => {
  document.title = to.matched[0].meta.title;
  next();
});

// 使页面跳转后回到顶部
router.afterEach((to, from, next) => {
  window.scrollTo(0, 0);
});

export default router;
