package com.gaussic.controller;
import com.gaussic.bean.ConnectMysql;
import com.gaussic.pojo.CategroyHotWords;
import net.minidev.json.JSONArray;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class IndexController extends AbstractController {
    private boolean execute;
    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        //1、收集参数
        //2、绑定参数到命令对象
        //3、调用业务对象
        //4、选择下一个页面
        //链接数据库操作的方法
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        ConnectMysql mysql = (ConnectMysql)context.getBean("dataBean");
        DriverManagerDataSource dataSource = mysql.getDataSource();
        //个性化拼接sql查询:

        String category_name = (String)req.getParameter("category_name")==null?"美妆":new String(req.getParameter("category_name").getBytes("ISO-8859-1"), "UTF-8");
        String reciver_area = (String)req.getParameter("reciver_area")==null?"不区分":new String(req.getParameter("reciver_area").getBytes("ISO-8859-1"), "UTF-8");
        String price_div = (String)req.getParameter("price_div")==null?"不区分":new String(req.getParameter("price_div").getBytes("ISO-8859-1"), "UTF-8");
        String season = (String)req.getParameter("season")==null?"不区分":new String(req.getParameter("season").getBytes("ISO-8859-1"), "UTF-8");
        String limit = req.getParameter("limit")==null?"10":new String(req.getParameter("limit").getBytes("ISO-8859-1"), "UTF-8");

        //添加模型数据
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("category_name",category_name);
        paramMap.put("reciver_area",reciver_area);
        paramMap.put("price_div",price_div);
        paramMap.put("season",season);
        //第一种：普遍使用，二次取值
        String sqlfield="";
        String sqlcond="";
        for (String key : paramMap.keySet()) {
            if (paramMap.get(key).equals("不区分")|| paramMap.get(key).equals("")){

            }else{
                sqlfield=sqlfield.concat(","+key);
                sqlcond=sqlcond.concat(" and "+key+"='"+paramMap.get(key)+"'");

            }
        }

        String sql = "select \"all\" ".concat(sqlfield+", key_words, SUM(tis) as tis from category_hot_words where 1=1"+sqlcond+" group by \"all\""+sqlfield+",key_words");

        sql = "select * from (".concat(sql+") as t1 order by tis desc limit "+Integer.parseInt(limit));


        ResultSet rs=dataSource.getConnection().prepareStatement(sql).executeQuery();
        List<CategroyHotWords> list = new ArrayList<CategroyHotWords>();
        while(rs.next()){
            CategroyHotWords  CategroyWordsList= new CategroyHotWords();
            CategroyWordsList.setCategory_name(rs.getString("category_name"));
            CategroyWordsList.setPrice_div(paramMap.get("price_div").equals("不区分")?"all":rs.getString("price_div"));
            CategroyWordsList.setReciver_area(paramMap.get("reciver_area").equals("不区分")?"all":rs.getString("reciver_area"));
            CategroyWordsList.setSeason(paramMap.get("season").equals("不区分")?"all":rs.getString("season"));
            CategroyWordsList.setKey_words(rs.getString("key_words"));
            CategroyWordsList.setTis(rs.getInt("tis"));
            list.add(CategroyWordsList);
        }

        //获取价格段
        //对象数据列表的json化
        String topCategoryWords = JSONArray.toJSONString(list);
        paramMap.put("limit",limit);
        ModelAndView mv = new ModelAndView();
        mv.addObject("paramMap",paramMap);
        mv.addObject("sqlstr",sql);
        mv.addObject("datasize",list.size());
        mv.addObject("listdata", list);

        mv.addObject("categorydata", topCategoryWords);
        //设置逻辑视图名，视图解析器会根据该名字解析到具体的视图页面
        mv.setViewName("index");
        return mv;
    }

}
