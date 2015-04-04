package app.controllers;

import org.javalite.activeweb.AppController;

/**
 * Created by PradeepSamuel on 2015-03-21.
 */
public class SearchController extends AppController {
    public void index(){
        if(session("user_name") != null){
            view("logged_in_user",session("user_name"));
        }

    }
}
