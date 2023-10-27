import request from "network/request.js"

//查询所有宠物品种
export function requestqueryallskind(parameter) {
    return request({
      url: "/skind/queryallskind",
      params: parameter
    })
}

//查询所有宠物品种
export function requestaddskind(parameter) {
    return request({
      url: "/skind/addskind",
      method: 'post',
      params: parameter
    })
}

//删除品种
export function requestdeleteskind(parameter) {
    return request({
      url: "/skind/deleteskind",
      params: parameter
    })
}

//删除品种
export function requestupdateskind(parameter) {
    return request({
      url: "/skind/updateskind",
      method: 'post',
      params: parameter
    })
}