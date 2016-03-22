ruleset trip_store {

  meta {
    name "trip_store"
    logging on
    sharing on
    provides hello, message
  }

  rule collect_trips {
    select when explicit trip_processed
    pre{
    	mileage = event:attr("mileage");
    	map_test = ent:mt;
    }
    log("iter1")
    if (not map_test) then {
    	log("registered non-existent map")
    } else {
    	log("test failed for some reason")
    }

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