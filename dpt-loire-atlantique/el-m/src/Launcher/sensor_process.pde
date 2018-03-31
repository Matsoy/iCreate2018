 import oscP5.*;
 
/*
Adjust these variables to get better results depending on the movement type
--------------------------------------------------------------------------------
treshold:
Defines acceleration's treshold for which you consider the crank handle was
pushed to avoid considering small changes

sensor_delay
Defines how frequently you analyze sensor movements detection (in ms)
*/
double treshold = 3;
double sensor_delay = 300;
 
OscP5 oscP5;
int sensor_time = millis();
double last_x = 0, last_z = 0, new_x, new_z;
boolean moving = false;
boolean isRolling = false;
ArrayList<Boolean> record_directions = new ArrayList<Boolean>();


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  //Update record of acceleration on x and z axis
  new_x = (Float) theOscMessage.arguments()[0];
  //println(new_x);
  new_z = (Float) theOscMessage.arguments()[2];

  double change = new_x - last_x;
  if(change > 2){
    record_directions.add(true);
  }
  else if(change < -2){
     record_directions.add(false);
  }
}

boolean isRolling(){
    /* Check if the crank handle is turning,
    and that it is in the right direction
    */
    if(last_z != 0){
      double change_z = Math.abs(new_z-last_z);
      if(change_z > 1){
        moving = true;
      }
      else{
        moving = false;
      }
      
      int cpt = 0;
      for(Boolean b : record_directions){
        if(b){
          cpt++;
        }
        else{
          cpt--;
        }
      }
      record_directions.clear();
    }
    
    //Reset entries
    sensor_time = millis();
    last_x = new_x;
    last_z = new_z;
    
    return moving;
    //return (moving && (cpt >= 0));
}
