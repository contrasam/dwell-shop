package ca.dwellshop.models;

import org.javalite.activejdbc.Model;

/**
 * Created by PradeepSamuel on 2015-03-12.
 */
public class User extends Model {

    public String createAccount(User user){

        return "";
    }

    public void setLocation(Location location){
        this.set("location_id",location.get("id"));
    }
}
