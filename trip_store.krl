ruleset trip_store {

  meta {
    name "trip_store"
    logging on
    sharing on
    provides trip_processed
  }

  rule collect_trips {
    select when explicit trip_processed
    pre{
    	mileage = event:attr("mileage");
    	map_test = ent:mt;
    }
    log (not map_test)

  }



  //rule message{
  //  select when echo message
  //  pre{
  //    input = event:attr("input");
  //  }
  //  send_directive("say") with
  //    something = "#{input}";
  //}
 
}