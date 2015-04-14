package app.controllers;

import ca.dwellshop.models.BiddableProperty;
import ca.dwellshop.models.BuyableProperty;
import ca.dwellshop.models.Location;
import ca.dwellshop.models.Property;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.POST;

import java.util.List;

/**
 * Created by PradeepSamuel on 2015-03-21.
 */
public class PropertyController extends AppController {
    public void index() {
        if (session("user_name") != null) {
            view("logged_in_user", session("user_name"));
        }
    }

    @POST
    public void query() {
        String property_id = param("property_id");
        if (property_id != null) {
            List<Property> properties = Property.where("id=?", property_id);
            if (properties.size() > 0) {
                Property property = properties.get(0);
                Gson gson = new Gson();
                JsonElement jsonElement = gson.toJsonTree(property);
                if (property.get("sale_type").toString().equals("buyable")) {
                    List<BuyableProperty> buyableProperties = BuyableProperty.where("property_id=?", property_id);
                    if (buyableProperties.size() > 0) {
                        jsonElement.getAsJsonObject().addProperty("sale_type_obj", gson.toJson(buyableProperties.get(0)));
                    }
                } else if (property.get("sale_type").toString().equals("biddable")) {
                    List<BiddableProperty> biddableProperties = BiddableProperty.where("property_id=?", property_id);
                    if (biddableProperties.size() > 0) {
                        jsonElement.getAsJsonObject().addProperty("sale_type_obj", gson.toJson(biddableProperties.get(0)));
                    }
                }
                List<Location> locations = Location.where("id=?", property.get("location_id").toString());
                if (locations.size() > 0) {
                    jsonElement.getAsJsonObject().addProperty("location_obj", gson.toJson(locations.get(0)));
                }
                respond(gson.toJson(jsonElement)).contentType("text/json").status(200);
            } else {
                respond("{}").contentType("text/json").status(200);
            }
        } else {
            respond("{}").contentType("text/json").status(200);
        }
    }

    public void map(){
        render().noLayout();
    }
}
