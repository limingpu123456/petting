import request from "network/request.js"

//增加地址
export function requestaddAddress(parameter) {
    return request({
        url: "/address/addAddress",
        method: "post",
        params: parameter
    })
}

//删除地址
export function requestdeleteAddress(parameter) {
    return request({
        url: "/address/deleteAddress",
        params: parameter
    })
}

//修改地址
export function requestupdateAddress(parameter) {
    return request({
        url: "/address/updateAddress",
        method: 'post',
        params: parameter
    })
}

//查询用户所有地址
export function requestqueryAddressbyuid(parameter) {
    return request({
        url: "/address/queryAddressbyuid",
        params: parameter
    })
}

//根据条件查询所有地址
export function requestqueryaddress(parameter) {
    return request({
        url: "/address/queryaddress",
        params: parameter
    })
}