import request from "network/request.js"

//登录
export function requestLogin(parameter) {
    return request({
        url: "/user/login",
        params: parameter
    })
}

// 注册前验证账号是否已被注册
export function requestcheckuser(parameter) {
    return request({
        url: "/user/checkuser",
        params: parameter
    })
}

// 注册
export function requestregister(parameter) {
    return request({
        url: "/user/register",
        method: "post",
        params: parameter
    })
}