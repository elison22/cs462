ruleset track_trips {

	meta {
		name "track_trips"
		logging on
		sharing on
		provides process_trip, find_long_trips, test_long_trip
	}

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
			}
	}

	rule test_long_trip {
		select when explicit found_long_trip
			noop();
	}

}