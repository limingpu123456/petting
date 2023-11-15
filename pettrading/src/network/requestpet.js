import request from "network/request.js"

//添加宠物请求
export function requestaddpet(parameter) {
    return request({
        url: "/pet/addPet",
        method: "post",
        data: parameter
    })
}

//分页查询宠物
export function requestquerypetpage(parameter) {
    return request({
        url: "/pet/querypetpage",
        params: parameter
    })
}

//根据pid查询宠物详情
export function requestquerypetbyid(parameter) {
    return request({
        url: "/pet/querypetbyid",
        params: parameter
    })
}

//查询宠物总条目数
export function requestquerypetcount(parameter) {
    return request({
        url: "/pet/querypetcount",
        params: parameter
    })
}

//查询宠物最高价
export function requestqueryMaxPrice() {
    return request({
        url: "/pet/queryMaxPrice",
    })
}

//查询所有宠物年龄
export function requestqueryage() {
    return request({
        url: "/pet/queryage",
    })
}

//修改宠物信息
export function requestupdatePet(parameter) {
    return request({
        url: "/pet/updatePet",
        method: 'post',
        data: parameter
    })
}

//查询所有宠物信息（可加uid）
export function requestqueryAllPet(parameter) {
    return request({
        url: "/pet/queryAllPet",
        params: parameter
    })
}

//删除宠物信息
export function requestdeletePet(parameter) {
    return request({
        url: "/pet/deletePet",
        params: parameter
    })
}