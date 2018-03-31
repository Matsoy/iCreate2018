public class Coordinate {
  public int id;
  public float latitude;
  public float longitude;
  public float x;
  public float y;

  public Coordinate(int id, float latitude, float longitude) {
    this.id = id;
    this.latitude = latitude;
    this.longitude = longitude;
    this.convertToXY();
  }
  
    public Coordinate(float latitude, float longitude) {
    this.id = -1;
    this.latitude = latitude;
    this.longitude = longitude;
    this.convertToXY();
  }

  public float getLatitude() {
    return latitude;
  }

  public void setLatitude(float latitude) {
    this.latitude = latitude;
  }

  public float getLongitude() {
    return longitude;
  }

  public void setLongitude(float longitude) {
    this.longitude = longitude;
  }  

  public float getX() {
    return x;
  }

  public void setX(float x) {
    this.x = x;
  }

  public float getY() {
    return y;
  }

  public void setY(float y) {
    this.y = y;
  }

  public void convertToXY(){
      this.x = (float) (((this.longitude - 14.15) * Math.cos(42.7))/13.20)+0.5;
      this.y = (float) (-(this.latitude - 42.7)/ 26.7)+0.5;
      //System.out.println(this.x + "," + this.y);
  }
}
