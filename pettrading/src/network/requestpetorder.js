import request from "network/request.js"

//添加订单请求
export function requestaddpetorder(parameter) {
    return request({
        url: "/petorder/addpetorder",
        method: "post",
        params: parameter
    })
}

//删除订单请求
export function requestdeletepetorder(parameter) {
    return request({
        url: "/petorder/deletepetorder",
        params: parameter
    })
}

//修改订单请求
export function requestupdatepetorder(parameter) {
    return request({
        url: "/petorder/updatepetorder",
        method: 'post',
        params: parameter
    })
}

//查询订单请求
export function requestquerypetorder(parameter) {
    return request({
        url: "/petorder/querypetorder",
        params: parameter
    })
}

//查询订单请求
export function requestquerypetorderpage(parameter) {
    return request({
        url: "/petorder/querypetorderpage",
        params: parameter
    })
}