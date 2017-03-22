package com.gaussic.bean;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

/**
 * Created by yuhe on 17/3/20.
 */
public class ConnectMysql {
    private String className;
    private String url;
    private String username;
    private String password;

    public String getClassName(){
        return className;
    }

    public void setClassName(String className){
        this.className = className;
    }

    public String getUrl(){
        return url;
    }

    public void setUrl(String url){
        this.url = url;

    }

    public String getUsername(){
        return username;
    }

    public void setUsername(String username){
        this.username = username;
    }
    public String getPassword(){
        return password;
    }
    public void setPassword(String password){
        this.password = password;

    }

    public DriverManagerDataSource getDataSource(){
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(className);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        return dataSource;
    }

}
