import request from "network/request.js"

//查找单个用户信息
export function requestqueryuser(parameter) {
    return request({
        url: "/user/queryuser",
        params: parameter
    })
}

//更改用户信息
export function requestupdateuser(parameter) {
    return request({
        url: "/user/updateuser",
        method: "post",
        data: parameter
    })
}

// 修改密码
export function requestchangepassword(parameter) {
    return request({
        url: "/user/changepassword",
        method: "post",
        params: parameter
    })
}

//查找用户最近联系人
export function requestquerycontactuser(parameter) {
    return request({
        url: '/user/querycontactuser',
        params: parameter
    })
}

//查找所有用户
export function requestqueryAllUser(parameter) {
    return request({
      url: '/user/queryalluser',
      params: parameter
    })
}

//查找所有用户
export function requestqueryuserby(parameter) {
    return request({
      url: '/user/queryuserby',
      params: parameter
    })
}

//删除用户
export function requestdeleteUser(parameter) {
    return request({
      url: '/user/deleteUser',
      params: parameter
    })
}

//用户总数
export function requestcountuser() {
    return request({
      url: '/user/countuser'
    })
}