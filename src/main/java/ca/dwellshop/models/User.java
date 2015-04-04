package ca.dwellshop.models;

import org.javalite.activejdbc.Model;

import java.util.List;

/**
 * Created by PradeepSamuel on 2015-03-12.
 */
public class User extends Model {

    public String createAccount(User user){
        if(checkIfEmailExists((String) user.get("email_address"))){
            return "The provided email address already exists, try logging in.";
        }
        if(!checkPasswordLength((String) user.get("password"))){
            return "The password have to be at least eight characters long.";
        }
        if(user.saveIt()){
            return "Account created successfully.";
        }
        return "Unexpected error occurred: please try again.";
    }

    public void setLocation(Location location){
        this.set("location_id",location.getId());
    }

    public Boolean checkIfEmailExists(String email_address) {
        List<User> users = User.where("email_address = '"+email_address+"'");
        if(users.size() > 0){
            return new Boolean(true);
        }else{
            return new Boolean(false);
        }
    }

    public Boolean checkPasswordLength(String password) {
        return password.length() >= 8;
    }
}
