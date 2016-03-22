ruleset track_trips {

	global{
		long_trip = 100
	}

	rule process_trip {
		select when car new_trip
		pre{
    	mileage = event:attr("mileage");
    }
    send_directive("trip") with
      trip_length = "#{mileage}";

    fired{
	    raise explicit event "trip_processed"
				attributes event:attrs();
    }

	}

	rule find_long_trips {
		select when explicit trip_processed
			pre{
				mileage = event:attr("mileage").klog("Mileage in trip_processed to compare to #{long_trip}: ");
			}
			if ( event:attr("mileage") >= long_trip ) then {
				send_directive("trip") with
      		trip_length = "in the then";
			}
			fired{
				raise explicit event "found_long_trip";
					//if ( event:attr("mileage") >= long_trip );
			}
			else {
				send_directive("trip") with
      		trip_length = "in the else";
			}
	}

}