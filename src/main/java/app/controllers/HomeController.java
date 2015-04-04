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
