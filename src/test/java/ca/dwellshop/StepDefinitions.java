package ca.dwellshop;

import ca.dwellshop.models.*;
import cucumber.api.PendingException;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.javalite.activejdbc.Base;

import static org.javalite.test.jspec.JSpec.*;

import javax.sql.DataSource;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class StepDefinitions {

    private User user;
    private User testUser;
    private Location location;
    private Property property;
    private BiddableProperty biddableProperty;
    private String bidResponse;
    private Bid bid;


    @Before
    public void setUp() {
        DataSource dataSource = DBCPDataSourceFactory.getDataSource();
        Base.open(dataSource);
    }

    @Given("^I am a new user to Dwell Shop$")
    public void i_am_a_new_user_to_Dwell_Shop() throws Throwable {
        this.user = new User();
    }

    @When("^I enter my personal details$")
    public void i_enter_my_personal_details() throws Throwable {
        this.user.set("first_name", "John");
        this.user.set("last_name", "Doe");
        this.user.set("profession", "Engineer");
        this.user.set("company", "Some Inc.");
        this.location = new Location();
        this.location.set("street_number", 1650);
        this.location.set("street_name", "Some street somewhere");
        this.location.set("suite_number", "A123");
        this.location.set("city", "Montreal");
        this.location.set("state", "Quebec");
        this.location.set("zip_code", "H3H 2J2");
        this.location.set("country", "Canada");
        this.location.set("latitude", 45.4951800);
        this.location.set("longitude", -73.5781420);
        if (this.location.saveIt()) {
            this.user.setLocation(this.location);
        }
    }

    @When("^I provide my \"(.*?)\" and \"(.*?)\"$")
    public void i_provide_my_and(String email_address, String password) throws Throwable {
        this.user.set("email_address", email_address);
        this.user.set("password", password);
    }

    @Then("^I should be shown a message as \"(.*?)\"$")
    public void i_should_be_shown_a_message_as(String message) throws Throwable {
        the(this.user.createAccount(this.user)).shouldBeEqual(message);
        this.user.delete();
        this.location.delete();
    }

    @Given("^I have selected the region of search$")
    public void i_have_selected_the_region_of_search() throws Throwable {
        SearchProperties.setRegion("state", "Quebec");
    }

    @When("^I provide a search text and click on search$")
    public void i_provide_a_search_text_and_click_on_search() throws Throwable {
        SearchProperties.setSearchQuery("road");
    }

    @Then("^I should be shown properties matching the search text$")
    public void i_should_be_shown_properties_matching_the_search_text() throws Throwable {
        List<IndexableProperty> searchResults = SearchProperties.search();
        the(searchResults.get(0).getStreet_name()).shouldContain("Road");
        the(searchResults.get(1).getStreet_name()).shouldContain("Road");
    }

    @When("^I choose a particular property type$")
    public void i_choose_a_particular_property_type() throws Throwable {
        SearchProperties.setSearchQuery("");
        SearchProperties.setType("Condominium");
    }

    @Then("^I should be shown properties only of that particular type$")
    public void i_should_be_shown_properties_only_of_that_particular_type() throws Throwable {
        List<IndexableProperty> searchResults = SearchProperties.search();
        the(searchResults.get(0).getType()).shouldBeEqual(SearchProperties.getType());
        the(searchResults.get(2).getType()).shouldBeEqual(SearchProperties.getType());
        the(searchResults.get(3).getType()).shouldBeEqual(SearchProperties.getType());
        the(searchResults.get(4).getType()).shouldBeEqual(SearchProperties.getType());
        the(searchResults.get(5).getType()).shouldBeEqual(SearchProperties.getType());
    }

    @When("^I choose a particular number of rooms$")
    public void i_choose_a_particular_number_of_rooms() throws Throwable {
        SearchProperties.setSearchQuery("");
        SearchProperties.setType("");
        SearchProperties.setNumberOfRooms("2");
    }

    @Then("^I should be shown properties only with the specified number of rooms$")
    public void i_should_be_shown_properties_only_with_the_specified_number_of_rooms() throws Throwable {
        List<IndexableProperty> searchResults = SearchProperties.search();
        the(searchResults.get(0).getNumber_of_rooms()).shouldBeEqual(Integer.parseInt(SearchProperties.getNumberOfRooms()));
        the(searchResults.get(1).getNumber_of_rooms()).shouldBeEqual(Integer.parseInt(SearchProperties.getNumberOfRooms()));
    }

    @When("^I select a minimum price and a maximum price$")
    public void i_select_a_minimum_price_and_a_maximum_price() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Then("^I should b shown properties only within that price range$")
    public void i_should_b_shown_properties_only_within_that_price_range() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Given("^I have selected a property to bid on$")
    public void i_have_selected_a_property_to_bid_on() throws Throwable {
        this.property = new Property();
        this.property.set("location_id", 1);
        this.property.set("owner_id", 19);
        this.property.set("type", "Condominium");
        this.property.set("year", 1990);
        this.property.set("sale_type", "biddable");
        this.property.set("sale_status", "open");
        this.property.set("sub_type", "5 1/2");
        this.property.set("number_of_rooms", "5");
        this.property.set("created", new Date());
        this.property.saveIt();
        this.biddableProperty = new BiddableProperty();
        this.biddableProperty.set("property_id", this.property.getId());
        this.biddableProperty.set("minimum_bidding_price", new BigDecimal(9000));
        this.biddableProperty.set("number_of_bids", 0);
        this.biddableProperty.saveIt();
        // creating a test bidder
        this.testUser = new User();
        this.testUser.set("first_name", "John");
        this.testUser.set("last_name", "Doe");
        this.testUser.set("profession", "Engineer");
        this.testUser.set("company", "Some Inc.");
        this.location = new Location();
        this.location.set("street_number", 1650);
        this.location.set("street_name", "Some street somewhere");
        this.location.set("suite_number", "A123");
        this.location.set("city", "Montreal");
        this.location.set("state", "Quebec");
        this.location.set("zip_code", "H3H 2J2");
        this.location.set("country", "Canada");
        this.location.set("latitude", 45.4951800);
        this.location.set("longitude", -73.5781420);
        if (this.location.saveIt()) {
            this.testUser.setLocation(this.location);
        }
        this.testUser.set("email_address", "testme@test.com");
        this.testUser.set("password", "test@1234");
        this.testUser.saveIt();
    }

    @When("^I provide the bidding amount higher than the minimum bidding price$")
    public void i_provide_the_bidding_amount_higher_than_the_minimum_bidding_price() throws Throwable {
        this.bid = new Bid();
        this.bidResponse = this.bid.placeBid(this.testUser, this.biddableProperty, new BigDecimal(9500));
    }

    @When("^I provide the bidding amount lower than the minimum bidding price$")
    public void i_provide_the_bidding_amount_lower_than_the_minimum_bidding_price() throws Throwable {
        this.bid = new Bid();
        this.bidResponse = this.bid.placeBid(this.testUser, this.biddableProperty, new BigDecimal(8500));
    }

    @Then("^the bid would be placed for the property$")
    public void the_bid_would_be_placed_for_the_property() throws Throwable {
        String message = "The bid was placed successfully.";
        the(this.bidResponse).shouldBeEqual(message);
        this.testUser.delete();
        this.bid.delete();
        this.biddableProperty.delete();
        this.property.delete();
    }

    @Then("^I should be shown a error message stating that the bidding amount should be above the minimum bidding amount$")
    public void i_should_be_shown_a_error_message_stating_that_the_bidding_amount_should_be_above_the_minimum_bidding_amount() throws Throwable {
        String message = "The bidding amount should be higher than the minimum bidding price.";
        the(this.bidResponse).shouldBeEqual(message);
        this.testUser.delete();
        this.bid.delete();
        this.biddableProperty.delete();
        this.property.delete();
    }

    @Given("^I am a seller of a property$")
    public void i_am_a_seller_of_a_property() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @When("^I make the property as biddable$")
    public void i_make_the_property_as_biddable() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Then("^The bidding window should be open for only three days$")
    public void the_bidding_window_should_be_open_for_only_three_days() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Given("^I am interested in buying a property$")
    public void i_am_interested_in_buying_a_property() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @When("^I click on buy property$")
    public void i_click_on_buy_property() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Then("^The seller of the property will be indicated that I am interested in buying the property$")
    public void the_seller_of_the_property_will_be_indicated_that_I_am_interested_in_buying_the_property() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @When("^I indicate that the property is sold$")
    public void i_indicate_that_the_property_is_sold() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Then("^the property will appear as sold to all the users for (\\d+) days$")
    public void the_property_will_appear_as_sold_to_all_the_users_for_days(int arg1) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Given("^I am an exiting user$")
    public void i_am_an_exiting_user() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @When("^I provide a my email address and password$")
    public void i_provide_a_my_email_address_and_password() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Then("^I should be granted access to Dwell Shop$")
    public void i_should_be_granted_access_to_Dwell_Shop() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Then("^I should be shown a message stating that the email address or password is incorrect$")
    public void i_should_be_shown_a_message_stating_that_the_email_address_or_password_is_incorrect() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @After
    public void tearDown() {
        Base.close();
    }
}
