
    setlistener("/controls/engines/engine[0]/throttle", func(n) {
	position=n.getValue();
    setprop("/controls/engines/engine[0]/reheat",0);
        if(position > .99){

               setprop("/controls/engines/engine[0]/reheat",1);
     };
   },1);
    setlistener("/controls/engines/engine[1]/throttle", func(n) {
	position=n.getValue();
    setprop("/controls/engines/engine[1]/reheat",0);
        if(position > .99){

               setprop("/controls/engines/engine[1]/reheat",1);
     };
   },1);


ext_slats = func {
        print ("airspeed");
  airspeed = getprop("/velocities/airspeed-kt");
    if (airspeed < 180) {
      setprop("/controls/flight/slats", 1.0);
      } else {
        setprop("/controls/flight/slats", 0.0);

      }
     settimer(ext_slats, 0.5);
   }

ext_slats;


toggle_canopy = func {
  canopy = aircraft.door.new ("/controls/canopy/",3);
  if(getprop("/controls/canopy/position-norm") > 0) {
      canopy.close();
  } else {

      canopy.open();
  }
}

#code from Phoenix

var fire = func(v,a) {
# This controls the Bay doors automaticly
# Call this when you shoot a missile.
var dt = 0;
var time = getprop("/sim/time/elapsed-sec");
var weapon = getprop("/controls/armament/selected-weapon-digit");


# Open the bay doors
# Determine weapon

	if (weapon == 2) {
# 77
            if(time - dt > 1)
            {
                dt = time;
	            	setprop("/controls/baydoors/AIM120", 1);
                print("bay doors open");
                timer_baydoorsclose.start();
            }




	} elsif (weapon == 1) {
# 73
            if(time - dt > 1)
            {
                dt = time;
	            	setprop("/controls/baydoors/AIM9X", 1);          # animations are inverted: todo fix the bay door animations
                print("9x doors open");
                timer_baydoorsclose.start();     
            }




  }
}



var closebays = func{
	            	setprop("/controls/baydoors/AIM120", 0);
	            	setprop("/controls/baydoors/AIM9X", 0);  # animations are inverted: todo fix the bay door animations
                print("closed");
                timer_baydoorsclose.stop();
}


var flares = func{
	var flarerand = rand();
props.globals.getNode("/rotors/main/blade[3]/flap-deg",1).setValue(flarerand);
props.globals.getNode("/rotors/main/blade[3]/position-deg",1).setValue(flarerand);
settimer(func   {
    props.globals.getNode("/rotors/main/blade[3]/flap-deg").setValue(0);
    props.globals.getNode("/rotors/main/blade[3]/position-deg").setValue(0);
                },1);

}



timer_baydoorsclose = maketimer(1, closebays);
