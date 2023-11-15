import request from "network/request.js"

//查询所有宠物种类
export function requestqueryBKind() {
    return request({
        url: "/bkind/queryBKind"
    })
}

//查询所有宠物种类及对应品种
export function requestqueryBKindandSKind(parameter) {
    return request({
        url: "/bkind/queryBKindandSKind",
        params: parameter
    })
}

//增加类型
export function requestaddBKind(parameter) {
    return request({
        url: "/bkind/addBKind",
        method: 'post',
        params: parameter
    })
}

//删除类型
export function requestdeleteBKind(parameter) {
    return request({
        url: "/bkind/deleteBKind",
        params: parameter
    })
}

//修改类型
export function requestupdateBKind(parameter) {
    return request({
        url: "/bkind/updateBKind",
        params: parameter
    })
}