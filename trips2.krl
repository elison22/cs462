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
				mileage = event:attr("mileage").klog("-1- Mileage in trip_processed to compare to #{long_trip}: ");
			}
			fired{
				raise explicit event "found_long_trip"
					if (mileage >= long_trip);
					//if ( mileage >= long_trip );
					//if ( event:attr("mileage") >= long_trip);
			}
	}

}