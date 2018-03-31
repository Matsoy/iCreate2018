import java.util.Calendar;

PImage img;
int smallPoint, largePoint;
ArrayList<Coordinate> from;
ArrayList<Coordinate> to;
float scaleH = 15;
float scaleW = 15;
//int date = 1859;   
Calendar date = Calendar.getInstance();
int time_animation = millis();
int delay_death = 300;
int delay_birth = 100;

String[] months = new String[]{"Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"};


// dans un vrai repère :
// -9.3 --> longitude gauche
// 37.1 --> longitude droite
// 29.7 --> latitude bas
// 56.39 --> latitude haut

// x total = 13.20
// y total = 26.7


void setup() {
  
  date.set(Calendar.YEAR, 1859);
  date.set(Calendar.MONTH, 0);
  
   /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  size(745, 439);
  img = loadImage("map.PNG");
  smallPoint = 4;
  largePoint = 40;
  imageMode(CENTER);
  noStroke();
  background(255);
  
  from = new ArrayList<Coordinate>();

  // Paris
  from.add(new Coordinate(1, 48.85, 2.35));
  // Athènes
  from.add(new Coordinate(2, 37.97, 23.74));
  // centre de la carte
  from.add(new Coordinate(3, 42.7, 14.15));
  // pointe Sud Tunisie
  from.add(new Coordinate(4, 30.23, 9.56));
  // gauche
  from.add(new Coordinate(5, 42.7, -9.3));
  // droite
  from.add(new Coordinate(6, 42.7, 37.1));
  // haut
  from.add(new Coordinate(7, 56.39, 14.15));
  // gauche
  from.add(new Coordinate(8, 29.7, 14.15));
  
}

void draw() { 
  background(img);
  
  // parcours des coordonnées
  for (Coordinate c : from) {
    fill(255, 0, 0, 63);
    ellipse(c.getX()*img.width, c.getY()*img.height, 15, 15);
  }
  
  rect(50,50,50,50);
  fill(255);
  
  //Update movment record
  
  if (millis() > sensor_time + sensor_delay){
    isRolling = isRolling();
  }
  
  int year = date.get(Calendar.YEAR);
  //Draw points on the map for births
  if ((millis() > (time_animation + delay_birth)) && isRolling && (year < 1914)){
 
     //addCoordinate();
     //CALL HERE FUNCTION TO DRAW POINTS WITH PARAMETER DATE (YEAR) FOR BIRTHS
     println("YEAR : " + year);
     
     date.add(Calendar.YEAR, 1); 
     time_animation = millis();
  }
  
  //Draw points for deaths
  if ((millis() > (time_animation + delay_death)) && isRolling && (year >= 1913) && (year < 1919)){
   
    println("YEAR : " + year + " MONTH " + months[date.get(Calendar.MONTH)]);
    //CALL HERE FUNCTION TO DRAW POINTS WITH PARAMETER DATE (YEAR and MONTH) FOR DEATHS
    
    date.add(Calendar.MONTH, 1);
    time_animation = millis();
  }
}

void addCoordinate(){
  from.add(new Coordinate(29.7 + random(56.39-29.7), -9.3+random(37.1-(-9.3))));
}
