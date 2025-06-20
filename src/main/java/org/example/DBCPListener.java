package org.example;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.apache.commons.dbcp2.BasicDataSource;

@WebListener
public class DBCPListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        BasicDataSource ds = new BasicDataSource();

        ds.setUrl("jdbc:mysql://localhost:3306/complaint_db");
        ds.setUsername("root");
        ds.setPassword("1234");
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setInitialSize(5);
        ds.setMaxTotal(10);

        sce.getServletContext().setAttribute("ds", ds);
    }
    public void contextDestroyed(ServletContextEvent sce) {
        BasicDataSource ds = (BasicDataSource) sce.getServletContext().getAttribute("ds");

        try{
            if (ds != null) {
                ds.close();
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

}
