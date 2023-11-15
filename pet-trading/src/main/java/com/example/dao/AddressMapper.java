package com.example.dao;

import com.example.domain.Address;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
@Mapper
public interface AddressMapper {

    @Insert("insert into address (phone,address,uid,username) value (#{phone},#{address},#{uid},#{username})")
    @Options(useGeneratedKeys = true,keyProperty = "aid")
    int addAddress(@Param("address") Address address);

    int deleteAddress(Map map);

    int updateAddress(@Param("address") Address address);

    @Select("select * from address where uid=#{uid}")
    List<Address> queryAddressbyuid(Map map);

    List<Address> queryAddress(Map map);

    int countaddress(Map map);
}
