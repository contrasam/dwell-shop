package ca.dwellshop.models;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by PradeepSamuel on 2015-03-21.
 */
public class IndexableProperty {

    private int id;
    private int location_id;
    private String type;
    private Date year;
    private String sale_type;
    private String sale_status;
    private String sub_type;
    private int number_of_rooms;
    private int street_number;
    private String street_name;
    private String suite_number;
    private String city;
    private String state;
    private String zip_code;
    private String country;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private BigDecimal price;

    public BigDecimal getPrice(){return price; }

    public void setPrice(BigDecimal price){
        this.price = price;
    }

    public int getStreet_number() {
        return street_number;
    }

    public String getStreet_name() {
        return street_name;
    }

    public String getSuite_number() {
        return suite_number;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public String getZip_code() {
        return zip_code;
    }

    public String getCountry() {
        return country;
    }

    public BigDecimal getLatitude() {
        return latitude;
    }

    public BigDecimal getLongitude() {
        return longitude;
    }

    public int getLocation_id() {
        return location_id;
    }

    public void setLocation_id(int location_id) {
        this.location_id = location_id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getYear() {
        return year;
    }

    public void setYear(Date year) {
        this.year = year;
    }

    public String getSale_type() {
        return sale_type;
    }

    public void setSale_type(String sale_type) {
        this.sale_type = sale_type;
    }

    public String getSale_status() {
        return sale_status;
    }

    public void setSale_status(String sale_status) {
        this.sale_status = sale_status;
    }

    public String getSub_type() {
        return sub_type;
    }

    public void setSub_type(String sub_type) {
        this.sub_type = sub_type;
    }

    public int getNumber_of_rooms() {
        return number_of_rooms;
    }

    public void setNumber_of_rooms(int number_of_rooms) {
        this.number_of_rooms = number_of_rooms;
    }

    public void setStreet_number(int street_number) {
        this.street_number = street_number;
    }

    public void setStreet_name(String street_name) {
        this.street_name = street_name;
    }

    public void setSuite_number(String suite_number) {
        this.suite_number = suite_number;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setState(String state) {
        this.state = state;
    }

    public void setZip_code(String zip_code) {
        this.zip_code = zip_code;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public void setLatitude(BigDecimal latitude) {
        this.latitude = latitude;
    }

    public void setLongitude(BigDecimal longitude) {
        this.longitude = longitude;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
