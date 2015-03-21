package ca.dwellshop.models;

import org.javalite.activejdbc.Base;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import java.io.IOException;
import static org.javalite.test.jspec.JSpec.*;

/**
 * Created by PradeepSamuel on 2015-03-17.
 */
public class TestUser {

    private User user;

    @Before
    public void setUp() {
        Base.open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/dwell_shop", "root", "");
        this.user = new User();
    }

    @Test
    public void itShouldGetAndSetValues(){
        this.user.set("first_name","John");
        a(this.user.get("first_name")).shouldBeEqual("John");
        this.user.set("last_name","John");
        a(this.user.get("last_name")).shouldBeEqual("John");
    }

    @Test
    public void itShouldStoreLocation(){
        Location location = new Location();
        this.user.setLocation(location);
    }

    @Test
    public void itShouldCreateAnAccount(){
        this.user.createAccount(this.user);
    }

    @After
    public void tearDown() throws IOException {
        this.user.delete();
        Base.close();
    }
}
