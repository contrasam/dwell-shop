package ca.dwellshop.models;

import org.apache.commons.dbcp.BasicDataSource;

import javax.sql.DataSource;

/**
 * Created by PradeepSamuel on 2015-03-21.
 */
public class DBCPDataSourceFactory {
    public static DataSource getDataSource(){
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName("com.mysql.jdbc.Driver");
        ds.setUsername("root");
        ds.setPassword("1234");
        ds.setUrl("jdbc:mysql://localhost/dwell_shop");
        return ds;
    }
}
