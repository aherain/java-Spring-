package com.gaussic.pojo;

/**
 * Created by yuhe on 17/3/20.
 */
public class CategroyHotWords {
    private String category_name;
    private String price_div;
    private String reciver_area;
    private String season;
    private String key_words;
    private int tis;

    public String getCategory_name(){
        return category_name;
    }

    public void setCategory_name(String category_name){
        this.category_name = category_name;
    }

    public String getPrice_div(){
        return  price_div;
    }

    public void setPrice_div(String price_div){
        this.price_div = price_div;
    }

    public String getReciver_area(){
        return reciver_area;
    }

    public void setReciver_area(String reciver_area){
        this.reciver_area = reciver_area;
    }

    public String getSeason(){
        return  season;
    }

    public void setSeason(String reason){
        this.season = season;
    }

    public String getKey_words(){
        return  key_words;
    }

    public void setKey_words(String key_words){
        this.key_words = key_words;
    }

    public int getTis(){
        return  tis;
    }
    public void setTis(int tis){
        this.tis = tis;
    }
}
