class MapObject extends Tile {
 //Declares the MapObject class using values from the Tile Class 
 MapObject(int newXPosition, int newYPosition, int newWidth, int newHeight, int newcolor) {
   //This is the line called when a new map object is called
   super(newXPosition, newYPosition, newWidth, newHeight, newcolor);
   //Draws a new mapobject/wall using these values
 }
}