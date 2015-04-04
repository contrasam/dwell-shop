package ca.dwellshop.models;

import org.javalite.activejdbc.Base;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import javax.sql.DataSource;
import java.io.IOException;
import static org.javalite.test.jspec.JSpec.*;

/**
 * Created by PradeepSamuel on 2015-03-17.
 */
public class TestUser {

    private User user;
    private Location location;

    @Before
    public void setUp() {
        DataSource dataSource = DBCPDataSourceFactory.getDataSource();
        Base.open(dataSource);
        this.user = new User();
        this.location = new Location();
        this.user.set("first_name","John");
        this.user.set("last_name","John");
        this.user.set("email_address","john.doe@doe.com");
        this.user.set("password","test@123");
    }

    @Test
    public void itShouldGetAndSetValues(){
        this.user.set("first_name","John");
        a(this.user.get("first_name")).shouldBeEqual("John");
        this.user.set("last_name","John");
        a(this.user.get("last_name")).shouldBeEqual("John");
        this.user.set("email_address","john.doe@doe.com");
        a(this.user.get("email_address")).shouldBeEqual("john.doe@doe.com");
        this.user.set("password","test@123");
        a(this.user.get("password")).shouldBeEqual("test@123");
    }

    @Test
    public void itShouldStoreLocation(){
        this.location.set("street_number", 1650);
        this.location.set("street_name", "Some street somewhere");
        this.location.set("suite_number", "A123");
        this.location.set("city", "Montreal");
        this.location.set("state", "Quebec");
        this.location.set("zip_code", "HHH TTT");
        this.location.set("country", "Canada");
        this.location.set("latitude", 45.4951800);
        this.location.set("longitude", -73.5781420);
        this.location.saveIt();
        this.user.setLocation(location);
        the(location.getId()).shouldBeEqual(this.user.get("location_id"));
    }

    @Test
    public void itShouldCheckIfEmailAlreadyExists(){
        the(this.user.checkIfEmailExists("doe.john@mary.com")).shouldBeA(Boolean.class);
    }

    @Test
    public void itShouldCheckIdPasswordIsAtleastEightCharacters(){
        the(this.user.checkPasswordLength("test")).shouldBeFalse();
    }

    @Test
    public void itShouldCreateAnAccount(){
        the(this.user.createAccount(this.user)).shouldBeEqual("Account created successfully.");
    }

    @After
    public void tearDown() throws IOException {
        this.location.delete();
        this.user.delete();
        Base.close();
    }
}
