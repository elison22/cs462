ruleset track_trips {

	meta {
		name "track_trips"
		logging on
		sharing on
		provides process_trip
	}

	rule process_trip {
		select when echo message
		pre{
    	mileage = event:attr("mileage");
    }
    send_directive("trip") with
      trip_length = "#{mileage}";
	}

}