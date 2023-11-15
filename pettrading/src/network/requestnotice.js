import request from "network/request.js"

//查找聊天记录
export function requestqueryusernotice(parameter) {
    return request({
        url: "/notice/queryusernotice",
        params: parameter
    })
}