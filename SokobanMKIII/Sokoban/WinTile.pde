class WinTile extends Tile{
//Declares the WinTile class using values from the Tile Class 
 WinTile(int newXPosition, int newYPosition, int newWidth, int newHeight,  int newcolor) {
   //This is the line called when a new win tile object is called
    super(newXPosition, newYPosition, newWidth, newHeight, newcolor);
    //Draws a new WinTile using these values
    wintiles.append(newXPosition + "/" + newYPosition);
  }
  

  
}