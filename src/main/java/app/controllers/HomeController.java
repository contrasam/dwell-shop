package app.controllers;

import ca.dwellshop.models.Location;
import ca.dwellshop.models.User;
import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.GET;
import org.javalite.activeweb.annotations.POST;
import java.util.List;

/**
 * Created by PradeepSamuel on 2015-03-20.
 */
public class HomeController extends AppController {
    @GET
    public void index(){
        if(session("user_name") != null){
            view("logged_in_user",session("user_name"));
        }
    }

    @GET
    public void loginForm(){
        if(session("login_error") != null){
            flash("login_error", session("login_error"));
        }
    }

    @GET
    public void registerForm(){
        if(session("register_error") != null){
            flash("register_error", session("register_error"));
        }
    }

    @POST
    public void register(){
        User user = new User();
        Location location = new Location();
        String email_address = param("email_address");
        String password = param("password");
        String first_name = param("first_name");
        String last_name = param("last_name");
        String profession = param("profession");
        String company = param("company");
        String street_number = param("street_number");
        String street_name = param("street_name");
        String suite_number = param("suite_number");
        String city = param("city");
        String state = param("state");
        String zip_code = param("zip_code");
        String country = param("country");
        String latitude = param("latitude");
        String longitude = param("longitude");
        if(email_address == null || email_address.equals("")){
            session("register_error","Email address cannot be blank");
            redirect("/home/register_form");
        }
        if(password == null || password.equals("")){
            session("register_error","Password cannot be blank");
            redirect("/home/register_form");
        }
        if(first_name == null || first_name.equals("")){
            session("register_error","First name cannot be blank");
            redirect("/home/register_form");
        }
        if(last_name == null || last_name.equals("")){
            session("register_error","Last name cannot be blank");
            redirect("/home/register_form");
        }
        if(profession == null || profession.equals("")){
            profession = "";
        }
        if(company == null || company.equals("")){
            company = "";
        }
        user.set("first_name", first_name);
        user.set("last_name", last_name);
        user.set("profession", profession);
        user.set("company", company);
        location.set("street_number", street_number);
        location.set("street_name", street_name);
        location.set("suite_number", suite_number);
        location.set("city",city);
        location.set("state", state);
        location.set("zip_code", zip_code);
        location.set("country", country);
        location.set("latitude", latitude);
        location.set("longitude", longitude);
        if (location.saveIt()) {
            user.setLocation(location);
        }
        user.set("email_address", email_address);
        user.set("password", password);
        String response = user.createAccount(user);
        session("register_error",response);
        redirect("/home/register_form");
    }

    @POST
    public void login(){
        String email_address = param("email_address");
        String password = param("password");
        List<User> users = User.where("email_address = ? AND password = ?",email_address,password);
        if(users.size() > 0){
            session("user_id", users.get(0).getId().toString());
            session("user_name", users.get(0).get("first_name").toString());
            session("city", Location.where("id = ?",users.get(0).get("location_id")).get(0).get("city").toString());
            redirect("/home/index");
        }else{
            session("login_error","Invalid username or password.");
            redirect("/home/login_form");
        }
    }

    @GET
    public void logout(){
        session().invalidate();
        redirect("/home/index");
    }
}
