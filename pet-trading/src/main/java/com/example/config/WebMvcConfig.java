package com.example.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author starsea
 * @date 2021-01-22
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {

    }

    //添加静态资源的映射，通过addResourceHandler添加了一个资源处理器来处理/avatar/**开头的请求路径
    //物理资源指定为下面那个路径，绝对路径
    //配置静态资源映射，解决新上传的文件无法访问的问题
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/avatar/**").addResourceLocations("classpath:/resources/avatar/");
        registry.addResourceHandler("/petimg/**").addResourceLocations("classpath:/resources/petimg/");
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
    }

    //后端解决跨域问题
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("*")
                .allowedMethods("GET", "HEAD", "POST", "PUT", "DELETE", "OPTIONS")
                .allowCredentials(true)
                .maxAge(3600)
                .allowedHeaders("*");
    }
}
