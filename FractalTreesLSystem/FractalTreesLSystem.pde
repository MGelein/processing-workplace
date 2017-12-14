String axiom = "F";
String sentence = axiom;
float len = 150;
float angle = radians(25);

ArrayList<Rule> rules = new ArrayList<Rule>();

void setup(){
  size(640, 480);
  
  rules.add(new Rule("F", "FF+[+F-F-F]-[-F+F+F]"));
  
  turtle();
}

void generate(){
  StringBuilder builder = new StringBuilder();
  len *= 0.5f;
  
  int i = 0;
  int max = sentence.length();
  String current;
  boolean found;
  for(i = 0; i < max; i++){
     current = sentence.substring(i, i + 1);
     found = false;
     for(Rule r : rules){
       if(r.found.equals(current)){
         builder.append(r.replace); 
         found = true;
         break;
       }
     }
     if(!found) builder.append(current);
  }
  
  sentence = builder.toString();
}

void mousePressed(){
  generate();
  turtle();
}

void draw(){
  
}


void turtle(){
  background(51);
  stroke(255, 100);
  resetMatrix();
  translate(width / 2, height);
  println(sentence.length() + " drawing instructions found");
  for(char c : sentence.toCharArray()){
    if(c == 'F'){
      line(0, 0, 0, -len);
      translate(0, -len);
    }else if(c =='+'){
      rotate(angle);
    }else if(c == '-'){
      rotate(-angle);
    }else if(c == '['){
      pushMatrix();
    }else if(c == ']'){
      popMatrix();
    }
  }
}