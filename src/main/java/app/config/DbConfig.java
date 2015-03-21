package app.config;

import org.javalite.activeweb.AbstractDBConfig;
import org.javalite.activeweb.AppContext;

public class DbConfig extends AbstractDBConfig {

    public void init(AppContext context) {
        environment("development").jdbc("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/dwell_shop", "root", "1234");
        environment("development").testing().jdbc("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/dwell_shop", "root", "1234");
    }
}
