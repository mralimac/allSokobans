String[] ground;  //Declares String Array for the ground //<>//
int groundindex= 0;  //Declares Int Value for the index of the ground Array
String MapObjectTile = "w";
int MapObjectx;  //Declares a variable for the X Coord of Map Objects
int MapObjecty;  //Declares a variable for the Y Coord of Map Objects
ArrayList<Floor> FloorList;  //Declares an ArrayList for storing the ground/floor
int Playerx = 150;  //Declares and sets the Players Starting X Position
int Playery = 150;  //Declares and sets the Players Starting Y Position
PImage floorimg;    //Declares an image for the floor  NOTE: THIS IS NOT USED
PImage tileimg;  //Declares an image for one of the ground tiles
PImage playerimg; //General Image
PImage playerimgup;  //Declares an image for the player up
PImage playerimgdown;  //Declares an image for the player down
PImage playerimgleft;  //Declares an image for the player left
PImage playerimgright;  //Declares an image for the player right
IntList xcoordwall;
IntList ycoordwall;
StringList coordlistwall;
String coordstring;
String coordresult;
int playerxfuture;
int playeryfuture;
StringList boxcoord;
StringList wintiles;
Player newPlayer;  //Declares a player object for the player class
Box newBox;  //Declares a box object for the box class
Tile newTile; //Declares a tile object for the tile class
MapObject newMapObject;  //Declares a map object for the objects class
Floor newFloor; //Declares a new floor object for the floor/ground class

void setup() {

  size(800, 550);
  wintiles = new StringList();
  coordlistwall = new StringList();
  boxcoord = new StringList();
  xcoordwall = new IntList();
  ycoordwall = new IntList();
  //Creates a new window with 700 pixels as the Width, and 550 Pixels as the Height
  floorimg = loadImage("floor.jpeg");
  //Loads the image for the floorimg variable to be used later
  tileimg = loadImage("tile.png");
  //Loads the image for the tileimg variable to be used later
  playerimgup = loadImage("player-up.png");
  playerimgdown = loadImage("player-down.png");
  playerimgleft = loadImage("player-left.png");
  playerimgright = loadImage("player-right.png");
  playerimg = playerimgup;
  //Loads the image for the playerimg variable to be used later
  ground = loadStrings("generator.txt");  
  //Loads the text file for generating the map
  FloorList = new ArrayList<Floor>();
  //Allocates and creates a new arraylist for the FloorList variable
  for (int loopX = 0; loopX < width; loopX +=50) {  
    //Starts a loop for the X coord of the floor

    for (int loopY = 0; loopY < height; loopY +=50) { 
      //Starts a loop for the Y coord of the floor

      FloorList.add(new Floor(loopX, loopY, 50, 50, color(100, 100, 100)));
      //Adds a new floor object by calling the class
    }
  }

  newPlayer = new Player(Playerx, Playery, 50, 50, color(255, 0, 0));  
  //Adds a new player by calling the player class with these variables
  newBox = new Box(300, 300, 50, 50, color(0, 0, 255));  
  //Adds a new box object by calling the box class with these variables
  try {
    //Starts a try for the file load, goes to catch if it fails
    String[] pieces = (split(ground[groundindex], ','));
    //Declares String Array and fills it with the split ground array. Spilting it by comma    
    for ( int tileindex = 0; tileindex < pieces.length; tileindex++) {
      //Starts a for loops for the map objects
      if (pieces[tileindex].equals(MapObjectTile) == true) {
        //If a value in the pieces string array equals the mapobjecttile variable then
        println(pieces[0], pieces[1], pieces[2], pieces[3]);
        //Write in console the first 4 values of the pieces String Array
        newMapObject = new MapObject(MapObjectx+100, MapObjecty+100, 50, 50, color(255, 200, 50));        
        //Adds a new mapobject by calling the mapobject class
      }
    }
  }
  catch (NullPointerException errorLoadingRectanglePositionsInSetup) {
    //This catches errors if the file is not found
    println("No File Found");
    //Writes in console that the file is missing
    fill(0);
    //Changes the color to black
    textSize(60);
    //Changes the text size to 60
    textAlign(CENTER);
    //Aligns the text to center
    text("FILE MISSING", width/2, height/2-50);
    //Writes text to the center top of the screen
    textSize(40);
    //Changes the text size to 40
    text("Please Close the Program", width/2, height/2+50);
    //Writes text to the center bottom of the screen
    stop();
    //Stops the programs from executing anymore code
  }
}

void draw() {
  background(0);
  //Puts a black background to refresh all the on-screen elements every frame
  for (int i =0; i < FloorList.size(); i++) {
    //Starts a for loop to display all the floor tiles
    Floor FloorInOurList = (Floor) FloorList.get(i);
    //Gets the floor object at a certain index and assigns it to the class variable
    FloorInOurList.display();
    //Calls the void inside the floor class to display/update the floor tile
  }
  newPlayer.display();
  //Calls the player class to update the player position
  newMapObject.display();
  //Calls the mapobject class to update the mapobject position
  newBox.display();
  //Calls the Box class to update the box position
  if(wintiles.hasValue(newBox.getXPosition()+"/"+newBox.getYPosition())){
    Win();
  }
}
void keyPressed() {
  if (key == 'u') {
    println(boxcoord);
  }
  //Void that is called whenever a key is pressed on the keyboard
  if (newPlayer.getYPosition() > 0) {
    //Checks if the players position is lower than the windows top
    if (keyCode == UP || key == 'w') {
      playerimg = playerimgup;
      //Checks if the Up arrow or the W key is pressed   
      playerxfuture = newPlayer.getXPosition();
      playeryfuture = newPlayer.getYPosition()-50;
      coordresult = playerxfuture+"/"+playeryfuture;
      if (!coordlistwall.hasValue(coordresult)) {
        //if (!ycoordwall.hasValue(newPlayer.getYPosition() - 50) && !xcoordwall.hasValue(newPlayer.getXPosition())) {
        println("Player Moves");
        println(newPlayer.getYPosition());
        println(newPlayer.getXPosition());
        newPlayer.setYPos(-50);
        if (boxcoord.hasValue(coordresult) && newBox.getYPosition()-50 > -1 && !coordlistwall.hasValue(coordresult)) {        
          newBox.setYPos(-50);
          int index = 0;

          while (!boxcoord.hasValue(coordresult)) {
            index = index + 1;
          }
          int boxXCoord = newBox.getXPosition();
          int boxYCoord = newBox.getYPosition();
          boxcoord.set(index, boxXCoord+"/"+boxYCoord);
        }
        //Updates the players Y position by 50
      } else {
        println("Wall in way");
      }
    }
  }

  if (newPlayer.getYPosition() < height-50) {
    //Checks if the players position is higher than the window bottom
    if (keyCode == DOWN || key == 's') {
      playerimg = playerimgdown;
      //Checks if the Down arrow or the S key is pressed
      playerxfuture = newPlayer.getXPosition();
      playeryfuture = newPlayer.getYPosition()+50;
      coordresult = playerxfuture+"/"+playeryfuture;
      if (!coordlistwall.hasValue(coordresult)) {
        println("Player Moves");
        newPlayer.setYPos(+50);
        if (boxcoord.hasValue(coordresult) && newBox.getYPosition()+50 < height && !coordlistwall.hasValue(coordresult)) {        
          newBox.setYPos(+50);
          int index = 0;

          while (!boxcoord.hasValue(coordresult)) {
            index = index + 1;
          }
          int boxXCoord = newBox.getXPosition();
          int boxYCoord = newBox.getYPosition();
          boxcoord.set(index, boxXCoord+"/"+boxYCoord);
        }
        //Updates the players Y position by 50
      } else {
        println("Wall in way");
      }
    }
  }

  if (newPlayer.getXPosition() > 0) {
    //Checks if the players position is more than the windows left edge
    if (keyCode == LEFT || key == 'a') {
      playerimg = playerimgleft;
      //Checks if the left arrow or the A key is pressed
      playerxfuture = newPlayer.getXPosition()-50;
      playeryfuture = newPlayer.getYPosition();
      coordresult = playerxfuture+"/"+playeryfuture;
      if (!coordlistwall.hasValue(coordresult)) {
        println("Player Moves");
        newPlayer.setXPos(-50);
        if (boxcoord.hasValue(coordresult) && newBox.getXPosition()-50 > -1 && !coordlistwall.hasValue(coordresult)) {        
          newBox.setXPos(-50);
          int index = 0;

          while (!boxcoord.hasValue(coordresult)) {
            index = index + 1;
          }
          int boxXCoord = newBox.getXPosition();
          int boxYCoord = newBox.getYPosition();
          boxcoord.set(index, boxXCoord+"/"+boxYCoord);
        }
        //Updates the players X position by 50
      } else {
        println("Wall in way");
      }
    }
  }

  if (newPlayer.getXPosition() < width-50) {
    //Checks if the players position is less than the windows right edge
    if (keyCode == RIGHT || key == 'd') {
      playerimg = playerimgright;
      //Checks if the right arrow or the D key is pressed
      playerxfuture = newPlayer.getXPosition()+50;
      playeryfuture = newPlayer.getYPosition();
      coordresult = playerxfuture+"/"+playeryfuture;
      if (!coordlistwall.hasValue(coordresult)) {
        println("Player Moves");
        newPlayer.setXPos(+50);
        if (boxcoord.hasValue(coordresult) && newBox.getXPosition()+50 < width && !coordlistwall.hasValue(coordresult)) {        
          newBox.setXPos(+50);
          int index = 0;

          while (!boxcoord.hasValue(coordresult)) {
            index = index + 1;
          }
          int boxXCoord = newBox.getXPosition();
          int boxYCoord = newBox.getYPosition();
          boxcoord.set(index, boxXCoord+"/"+boxYCoord);
        }
        //Updates the players X position by 50
      } else {
        println("Wall in way");
      }
    }
  }
}