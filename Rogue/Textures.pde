class Textures{
  SpriteSheet wall;
  SpriteSheet floor;
  SpriteSheet ammo;
  SpriteSheet amulet;
  SpriteSheet armor;
  SpriteSheet book;
  SpriteSheet boot;
  SpriteSheet flesh;
  SpriteSheet food;
  SpriteSheet glove;
  SpriteSheet hat;
  SpriteSheet light;
  SpriteSheet long_weapon;
  SpriteSheet medium_weapon;
  SpriteSheet short_weapon;
  SpriteSheet money;
  SpriteSheet music;
  SpriteSheet potion;
  SpriteSheet ring;
  SpriteSheet rock;
  SpriteSheet scroll;
  SpriteSheet shield;
  SpriteSheet tool;
  SpriteSheet wand;
  SpriteSheet fence;
  SpriteSheet tile;
  
  AnimatedSheet decor;
  AnimatedSheet door;
  AnimatedSheet effect;
  AnimatedSheet ground;
  AnimatedSheet hill;
  AnimatedSheet map;
  AnimatedSheet ore;
  AnimatedSheet trap;
  AnimatedSheet tree;
  AnimatedSheet pit;
  AnimatedSheet gui;
  AnimatedSheet chest;
  AnimatedSheet aquatic;
  AnimatedSheet avian;
  AnimatedSheet cat;
  AnimatedSheet demon;
  AnimatedSheet dog;
  AnimatedSheet elemental;
  AnimatedSheet humanoid;
  AnimatedSheet misc;
  AnimatedSheet pest;
  AnimatedSheet plant;
  AnimatedSheet player;
  AnimatedSheet quadraped;
  AnimatedSheet reptile;
  AnimatedSheet rodent;
  AnimatedSheet slime;
  AnimatedSheet undead;
  
  
  Textures(){
    //Objects
    decor = new AnimatedSheet(16, "Objects/Decor0.png", "Objects/Decor1.png");
    door = new AnimatedSheet(16, "Objects/Door0.png", "Objects/Door1.png");
    effect = new AnimatedSheet(16, "Objects/Effect0.png", "Objects/Effect1.png");
    fence = new SpriteSheet(16, loadImage("Dawnlike/Objects/Fence.png"));
    floor = new SpriteSheet(16, loadImage("Dawnlike/Objects/Floor.png"));
    ground = new AnimatedSheet(16, "Objects/Ground0.png", "Objects/Ground1.png");
    hill = new AnimatedSheet(16, "Objects/Hill0.png", "Objects/Hill1.png");
    map = new AnimatedSheet(16, "Objects/Map0.png", "Objects/Map1.png");
    ore = new AnimatedSheet(16, "Objects/Ore0.png", "Objects/Ore1.png");
    pit = new AnimatedSheet(16, "Objects/Pit0.png", "Objects/Pit1.png");
    tile = new SpriteSheet(16, loadImage("Dawnlike/Objects/Tile.png"));
    trap = new AnimatedSheet(16, "Objects/Trap0.png", "Objects/Trap1.png");
    tree = new AnimatedSheet(16, "Objects/Tree0.png", "Objects/Tree1.png");
    wall = new SpriteSheet(16, loadImage("Dawnlike/Objects/Wall.png"));
    
    //GUI
    gui = new AnimatedSheet(16, "GUI/GUI0.png", "GUI/GUI1.png");
    
    //Items
    ammo = new SpriteSheet(16, loadImage("Dawnlike/Items/Ammo.png"));
    amulet = new SpriteSheet(16, loadImage("Dawnlike/Items/Amulet.png"));
    armor = new SpriteSheet(16, loadImage("Dawnlike/Items/Armor.png"));
    book = new SpriteSheet(16, loadImage("Dawnlike/Items/Book.png"));
    boot = new SpriteSheet(16, loadImage("Dawnlike/Items/Boot.png"));
    chest = new AnimatedSheet(16, "Items/Chest0.png", "Items/Chest1.png");
    flesh = new SpriteSheet(16, loadImage("Dawnlike/Items/Flesh.png"));
    food = new SpriteSheet(16, loadImage("Dawnlike/Items/Food.png"));
    glove = new SpriteSheet(16, loadImage("Dawnlike/Items/Glove.png"));
    hat = new SpriteSheet(16, loadImage("Dawnlike/Items/Hat.png"));
    light = new SpriteSheet(16, loadImage("Dawnlike/Items/Light.png"));
    long_weapon = new SpriteSheet(16, loadImage("Dawnlike/Items/LongWep.png"));
    medium_weapon = new SpriteSheet(16, loadImage("Dawnlike/Items/MedWep.png"));
    short_weapon = new SpriteSheet(16, loadImage("Dawnlike/Items/ShortWep.png"));
    money = new SpriteSheet(16, loadImage("Dawnlike/Items/Money.png"));
    music = new SpriteSheet(16, loadImage("Dawnlike/Items/Music.png"));
    potion = new SpriteSheet(16, loadImage("Dawnlike/Items/Potion.png"));
    ring = new SpriteSheet(16, loadImage("Dawnlike/Items/Ring.png"));
    rock = new SpriteSheet(16, loadImage("Dawnlike/Items/Rock.png"));
    scroll = new SpriteSheet(16, loadImage("Dawnlike/Items/Scroll.png"));
    shield = new SpriteSheet(16, loadImage("Dawnlike/Items/Shield.png"));
    tool = new SpriteSheet(16, loadImage("Dawnlike/Items/Tool.png"));
    wand = new SpriteSheet(16, loadImage("Dawnlike/Items/Wand.png"));
    
    //Characters
    aquatic = new AnimatedSheet(16, "Characters/Aquatic0.png", "Characters/Aquatic1.png");
    avian = new AnimatedSheet(16, "Characters/Avian0.png", "Characters/Avian1.png"); 
    cat = new AnimatedSheet(16, "Characters/Cat0.png", "Characters/Cat1.png");
    demon = new AnimatedSheet(16, "Characters/Demon0.png", "Characters/Demon1.png");
    dog = new AnimatedSheet(16, "Characters/Dog0.png", "Characters/Dog1.png");
    elemental = new AnimatedSheet(16, "Characters/Elemental0.png", "Characters/Elemental1.png");
    humanoid = new AnimatedSheet(16, "Characters/Humanoid0.png", "Characters/Humanoid1.png");
    misc = new AnimatedSheet(16, "Characters/Misc0.png", "Characters/Misc1.png");
    pest = new AnimatedSheet(16, "Characters/Pest0.png", "Characters/Pest1.png");
    plant = new AnimatedSheet(16, "Characters/Plant0.png", "Characters/Plant1.png");
    player = new AnimatedSheet(16, "Characters/Player0.png", "Characters/Player1.png");
    quadraped = new AnimatedSheet(16, "Characters/Quadraped0.png", "Characters/Quadraped1.png");
    reptile = new AnimatedSheet(16, "Characters/Reptile0.png", "Characters/Reptile1.png");
    rodent = new AnimatedSheet(16, "Characters/Rodent0.png", "Characters/Rodent1.png");
    slime = new AnimatedSheet(16, "Characters/Slime0.png", "Characters/Slime1.png");
    undead = new AnimatedSheet(16, "Characters/Undead0.png", "Characters/Undead1.png");
  }
}

class AnimatedSheet{
  ArrayList<SpriteSheet> sheets = new ArrayList<SpriteSheet>();
  
  AnimatedSheet(int tileSize, String... sheetUrls){
    for(String url : sheetUrls){
      addSheet(new SpriteSheet(tileSize, loadImage("Dawnlike/" + url)));
    }
  }
  
  PImage get(int index, int frame){
    return sheets.get(frame % sheets.size()).get(index);
  }
  
  PImage get(int x, int y, int frame){
    return sheets.get(frame % sheets.size()).get(x, y);
  }
  
  void addSheet(SpriteSheet s){
    sheets.add(s);
  }
  
  void removeSheet(SpriteSheet s){
    sheets.remove(s);
  }
}

class SpriteSheet{
  PImage sheet;
  PImage[] sprites;
  int size;
  int cols;
  int rows;
  
  SpriteSheet(int tileSize, PImage sheet){
    load(tileSize, sheet);
  }
  
  void load(int tileSize, PImage sheet){
    this.size = tileSize;
    this.sheet = sheet;
    
    cols = floor(sheet.width / size);
    rows = floor(sheet.height / size);
    
    sprites = new PImage[cols * rows];
    for(int i = 0; i < sprites.length; i++){
      int x = i % cols;
      int y = floor(i / cols);
      sprites[i] = sheet.get(x * size, y * size, size, size);
    }
  }
  
  PImage get(int index){
    return sprites[index % sprites.length]; 
  }
  
  PImage get(int x, int y){
    return get(x + y * cols);
  }
}