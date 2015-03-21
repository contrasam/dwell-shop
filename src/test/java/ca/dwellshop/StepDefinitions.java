package ca.dwellshop;

import ca.dwellshop.models.User;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.javalite.activejdbc.Base;
import static org.javalite.test.jspec.JSpec.*;

public class StepDefinitions {

    private User user;

    @Before
    public void setup() {
        Base.open("com.mysql.jdbc.Driver", "jdbc:mysql://localhost/dwell_shop", "root", "1234");
    }

    @Given("^I am a new user to Dwell Shop$")
    public void i_am_a_new_user_to_Dwell_Shop() throws Throwable {
        this.user = new User();
    }

    @When("^I enter my personal details$")
    public void i_enter_my_personal_details() throws Throwable {
        this.user.set("first_name","John");
        this.user.set("last_name","Doe");
        this.user.set("profession","Engineer");
        this.user.set("company","Some Inc.");
    }

    @When("^I provide my \"(.*?)\" and \"(.*?)\"$")
    public void i_provide_my_and(String email_address, String password) throws Throwable {
        this.user.set("email_address",email_address);
        this.user.set("password",password);
    }



    @After
    public void tearDown() {
        Base.close();
    }
}
