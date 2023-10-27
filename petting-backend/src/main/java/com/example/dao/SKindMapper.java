package com.example.dao;

import com.example.domain.SKind;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
@Mapper
public interface SKindMapper {

    @Insert("insert into skind (savatar,skindname,bkid) values (#{savatar},#{skindname},#{bkid})")
    @Options(useGeneratedKeys = true,keyProperty = "skid")
    int addSKind(SKind skind);

    int deleteSKind(Map map);

    int updateSKind(SKind skind);

    List<SKind> queryAllSKind(Map map);
}
