package com.example.utils;

import java.util.UUID;

public class createUUID {

    /**
     * 获得一个UUID
     * @return String UUID
     */
    public static String getUUID() {
        String uuid = UUID.randomUUID().toString();
        //去掉“-”符号
        return uuid.replaceAll("-", "");
    }
}
