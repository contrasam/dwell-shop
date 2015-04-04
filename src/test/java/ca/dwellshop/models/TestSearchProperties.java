package ca.dwellshop.models;

import org.junit.Test;

import java.util.List;

import static org.javalite.test.jspec.JSpec.the;

/**
 * Created by PradeepSamuel on 2015-03-21.
 */
public class TestSearchProperties {

    @Test
    public void itShouldSetAndGetRegion(){
        SearchProperties.setRegion("city","Whitehorse");
        the(SearchProperties.getRegion()).shouldContain("city");
        the(SearchProperties.getRegion()).shouldNotContain("state");
        SearchProperties.setRegion("state","Quebec");
        the(SearchProperties.getRegion()).shouldContain("state");
        the(SearchProperties.getRegion()).shouldNotContain("city");
    }

    @Test
    public void itShouldSetAndGetSearchQuery(){
        String searchQuery = "road";
        SearchProperties.setSearchQuery(searchQuery);
        the(searchQuery).shouldBeEqual(SearchProperties.getSearchQuery());
        searchQuery = "";
        SearchProperties.setSearchQuery(searchQuery);
        the(searchQuery).shouldBeEqual(SearchProperties.getSearchQuery());
    }

    @Test
    public void itShouldPerformSearchOnProperties(){
        List<IndexableProperty> searchResults = SearchProperties.search();
        the(searchResults.size() > 0).shouldBeTrue();
    }


}
