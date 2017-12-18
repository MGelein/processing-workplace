class KeyListener{
  
  boolean[] keys = new boolean[200];
  
  void setDown(int code){
    keys[code] = true;
  }
  
  void setUp(int code){
    keys[code] = false;
  }
  
  boolean isDown(int code){
    return keys[code] == true;
  }
}