import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import de.bezier.guido.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Minesweeper extends PApplet {




public static final int NUM_ROWS = 20;
public static final int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

public void setup ()
{
    
    textAlign(CENTER,CENTER);

    // make the manager / starts GUIDO
    Interactive.make( this );

    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i=0; i<NUM_ROWS; i++) {
      for (int j=0; j<NUM_COLS; j++) {
        buttons[i][j] = new MSButton(i,j);
        buttons[i][j].draw();
      }
    }

    bombs = new ArrayList<MSButton>();
    setBombs();
}
public void setBombs()
{
    for (int i=0; i<20; i++) {
      int bRow = (int) (Math.random() * NUM_ROWS);
      int bCol = (int) (Math.random() * NUM_COLS);
      bombs.add(buttons[bRow][bCol]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton {
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;

    public MSButton ( int rr, int cc ) {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc;
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked() {
        return marked;
    }
    public boolean isClicked() {
        return clicked;
    }
    // called by manager

    public void mousePressed() {
        if (mouseButton == LEFT) clicked = true;
        if (mouseButton == RIGHT && !marked) marked = true;
        else marked = false;
    }

    public void draw() {
        if (marked)
            fill(0);
        else if(clicked && bombs.contains(this))
             fill(255,0,0);
        else if(clicked)
            fill(200);
        else
            fill(100);

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel) {
        label = newLabel;
    }
    public boolean isValid(int r, int c) {
        //your code here
        return false;
    }
    public int countBombs(int row, int col) {
        int numBombs = 0;
        //your code here
        return numBombs;
    }
}
  public void settings() {  size(400, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Minesweeper" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
