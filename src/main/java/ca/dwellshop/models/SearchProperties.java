package ca.dwellshop.models;

import io.orchestrate.client.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created by PradeepSamuel on 2015-03-21.
 */
public class SearchProperties {

    private static Client client = OrchestrateClient.builder("f59fa228-4d6e-4e99-89ce-95500714604a").build();
    private static Map<String, String> region;
    private static String searchQuery = "*";
    private static String type;
    private static String numberOfRooms;
    private static String minimumPrice;
    private static String maximumPrice;

    public static void setRegion(String type, String name) {
        region = new HashMap<String, String>();
        region.put(type, name);
    }

    public static Map getRegion() {
        if (region != null) {
            return region;
        } else {
            return new HashMap<String, String>();
        }
    }

    public static void setSearchQuery(String query) {
        SearchProperties.searchQuery = query;
    }

    public static String getSearchQuery() {
        if (SearchProperties.searchQuery.equals("*")) {
            return "";
        }
        return SearchProperties.searchQuery;
    }

    public static void setPriceRange(String minimumPrice, String maximumPrice) {
        SearchProperties.minimumPrice = minimumPrice;
        SearchProperties.maximumPrice = maximumPrice;
    }

    public static void setNumberOfRooms(String numberOfRooms) {
        SearchProperties.numberOfRooms = numberOfRooms;
    }

    public static String getNumberOfRooms() {
        return SearchProperties.numberOfRooms;
    }

    public static void setType(String type) {
        SearchProperties.type = type;
    }

    public static String getType() {
        return SearchProperties.type;
    }

    public static List<IndexableProperty> search() {
        String finalQuery;
        String typeQuery;
        String numberOfRoomsQuery;
        String priceQuery;
        if (SearchProperties.searchQuery == null || SearchProperties.searchQuery.equals("")) {
            SearchProperties.searchQuery = "*";
        }
        if (SearchProperties.type == null || SearchProperties.type.equals("")) {
            typeQuery = "";
        } else {
            typeQuery = " AND type:\"" + SearchProperties.type + "\"";
        }
        if (SearchProperties.numberOfRooms == null || SearchProperties.numberOfRooms.equals("")) {
            numberOfRoomsQuery = "";
        } else {
            numberOfRoomsQuery = " AND number_of_rooms:" + SearchProperties.numberOfRooms;
        }
        if ((SearchProperties.minimumPrice == null || SearchProperties.minimumPrice.equals("")) && (SearchProperties.maximumPrice == null || SearchProperties.maximumPrice.equals(""))) {
            priceQuery = "";
        } else {
            priceQuery = " AND price:[" + SearchProperties.minimumPrice + " TO " + SearchProperties.maximumPrice + "]";
        }
        finalQuery = SearchProperties.searchQuery + typeQuery + numberOfRoomsQuery + priceQuery;
        SearchResults<IndexableProperty> results = client.searchCollection("properties").get(IndexableProperty.class, finalQuery).get();
        List<IndexableProperty> searchResults = new ArrayList<IndexableProperty>();
        for (Result<IndexableProperty> result : results) {
            KvObject<IndexableProperty> propertyKv = result.getKvObject();
            IndexableProperty property = propertyKv.getValue();
            searchResults.add(property);
        }
        return searchResults;
    }

    public static void indexProperty(Property property) {
        List<Location> propertyLocations = Location.where("id = ?", property.getId().toString());
        Location propertyLocation = propertyLocations.get(0);
        IndexableProperty indexableProperty = new IndexableProperty();
        indexableProperty.setId((Integer) property.getId());
        indexableProperty.setNumber_of_rooms((Integer) property.get("number_of_rooms"));
        indexableProperty.setSale_status((String) property.get("sale_status"));
        indexableProperty.setSale_type((String) property.get("sale_type"));
        if (property.get("sale_type").toString().equals("buyable")) {
            List<BuyableProperty> buyableProperties = BuyableProperty.where("property_id=?", property.getId());
            if (buyableProperties.size() > 0) {
                indexableProperty.setPrice(new BigDecimal(buyableProperties.get(0).get("price").toString()));
            } else {
                indexableProperty.setPrice(new BigDecimal("0"));
            }
        } else if (property.get("sale_type").toString().equals("biddable")) {
            List<BiddableProperty> biddableProperties = BiddableProperty.where("property_id=?", property.getId());
            if (biddableProperties.size() > 0) {
                indexableProperty.setPrice(new BigDecimal(biddableProperties.get(0).get("minimum_bidding_price").toString()));
            } else {
                indexableProperty.setPrice(new BigDecimal("0"));
            }
        }
        indexableProperty.setSub_type((String) property.get("sub_type"));
        indexableProperty.setType((String) property.get("type"));
        indexableProperty.setYear((Date) property.get("year"));
        indexableProperty.setCity((String) propertyLocation.get("city"));
        indexableProperty.setCountry((String) propertyLocation.get("country"));
        indexableProperty.setLocation_id((Integer) propertyLocation.getId());
        indexableProperty.setLatitude((BigDecimal) propertyLocation.get("latitude"));
        indexableProperty.setLongitude((BigDecimal) propertyLocation.get("longitude"));
        indexableProperty.setState((String) propertyLocation.get("state"));
        indexableProperty.setStreet_name((String) propertyLocation.get("street_name"));
        indexableProperty.setSuite_number((String) propertyLocation.get("suite_number"));
        indexableProperty.setZip_code((String) propertyLocation.get("zip_code"));
        try {
            client.postValue("properties", indexableProperty);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void indexAllPropertiesFromDb() {
        if (SearchProperties.deleteAllIndexes()) {
            List<Property> properties = Property.findAll();
            for (Property property : properties) {
                SearchProperties.indexProperty(property);
            }
        }
    }

    public static boolean deleteAllIndexes() {
        boolean result = client.deleteCollection("properties").get();
        return result;
    }
}
