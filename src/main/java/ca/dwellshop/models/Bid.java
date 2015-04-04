package ca.dwellshop.models;

import org.javalite.activejdbc.Model;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by PradeepSamuel on 2015-03-12.
 */
public class Bid extends Model {
    public String placeBid(User bidder,BiddableProperty property,BigDecimal biddingAmount){
        Bid bid = new Bid();
        bid.set("bidder_id",bidder.getId());
        bid.set("biddable_property_id",property.getId());
        bid.set("status","placed");
        bid.set("price",biddingAmount);
        bid.set("created",new Date());
        int res = biddingAmount.compareTo(new BigDecimal(BiddableProperty.where("id="+property.getId()).get(0).get("minimum_bidding_price").toString()));
        if(!(res == 1)){
            return "The bidding amount should be higher than the minimum bidding price.";
        }
        if(bid.saveIt()){
            return "The bid was placed successfully.";
        }
        return "Unexpected error occurred, please try again later";
    }
}
