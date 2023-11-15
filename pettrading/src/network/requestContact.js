import request from "network/request.js"

//更新最近联系人记录
export function requestupdatecontact(parameter) {
    return request({
        url: "/contact/updatecontact",
        method: 'post',
        params: parameter
    })
}

//添加最近联系人
export function requestaddContact(parameter) {
    return request({
        url: "/contact/addContact",
        method: 'post',
        params: parameter
    })
}