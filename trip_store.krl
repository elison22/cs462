ruleset trip_store {

  meta {
    name "trip_store"
    logging on
    sharing on
    provides trip_processed
  }

  rule collect_trips {
    select when temp trip_processed
    pre{
    	mileage = event:attr("mileage").klog("iter 6: ");
    	map_test = ent:mt;
    	testbool = map_test.typeof();
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