package app.controllers;

import ca.dwellshop.models.IndexableProperty;
import ca.dwellshop.models.SearchProperties;
import com.google.gson.Gson;
import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.POST;

import java.util.List;

/**
 * Created by PradeepSamuel on 2015-03-21.
 */
public class SearchController extends AppController {
    public void index() {
        if (session("user_name") != null) {
            view("logged_in_user", session("user_name"));
        }
    }

    @POST
    public void query() {
        String query = param("query");
        String type = param("type");
        String numberOfRooms = param("number_of_rooms");
        String minimumPrice = param("minimum_price");
        String maximumPrice = param("maximum_price");
        if (type != null) {
            SearchProperties.setType(type);
        } else {
            SearchProperties.setType("");
        }
        if (numberOfRooms != null) {
            SearchProperties.setNumberOfRooms(numberOfRooms);
        } else {
            SearchProperties.setNumberOfRooms("");
        }
        if (minimumPrice != null && maximumPrice != null) {
            SearchProperties.setPriceRange(minimumPrice, maximumPrice);
        } else {
            SearchProperties.setPriceRange("","");
        }
        SearchProperties.setSearchQuery(query);
        List<IndexableProperty> results = SearchProperties.search();
        Gson gson = new Gson();
        String json = gson.toJson(results);
        respond(json).contentType("text/json").status(200);
    }
}
