
import de.bezier.guido.*;

public static final int NUM_ROWS = 20;
public static final int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
public static final int NUM_BOMBS = 40;

void setup () {
    size(400, 400);
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

    for (int i=0; i<NUM_ROWS; i++) {
      for (int j=0; j<NUM_COLS; j++) {
        buttons[i][j].setLabel("" + buttons[i][j].countBombs(i,j));
      }
    }
}
public void setBombs()
{
    for (int i=0; i<NUM_BOMBS; i++) {
      int bRow = (int) (Math.random() * NUM_ROWS);
      int bCol = (int) (Math.random() * NUM_COLS);
      bombs.add(buttons[bRow][bCol]);
    }
}

public void draw ()
{
    background(0);
    if(isWon())
        displayWinningMessage();
}
public boolean isWon() {

    return false;
}
public void displayLosingMessage()
{
  for (int i=0; i<NUM_ROWS; i++) {
    for (int j=0; j<NUM_COLS; j++) {
      if (bombs.contains(buttons[i][j])) {
        // buttons[i][j].marked = false;
        buttons[i][j].clicked = true;
      }
    }
  }
  String message = "YOU LOST";
  int begin = (NUM_COLS-message.length())/2;
  for (int i=begin; i<begin+message.length(); i++) {
    buttons[10][i].setLabel(message.charAt(i-begin) + "");
  }
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
        if (mouseButton == LEFT) {
          clicked = true;
          if (bombs.contains(this)) {
            displayLosingMessage();
          }
        }
        if (mouseButton == RIGHT && !marked) {
          marked = true;
        } else {
          marked = false;
        }
    }

    public void draw() {
        if (marked)
            fill(0);
        else if(clicked && bombs.contains(this)) {
             fill(255,0,0);
           }
        else if(clicked)
            fill(200);
        else
            fill(100);

        rect(x, y, width, height);
        if (clicked && !bombs.contains(this)) {
          if (label.equals("0")) {
            for (int i = r-1; i <= r+1; i++) {
              for (int j = c-1; j <= c+1; j++) {
                if (isValid(i,j)) {
                  buttons[i][j].clicked = true;
                }
              }
            }
          } else {
            showLabel();
          }
        }
    }
    public void setLabel(String newLabel) {
        label = newLabel;
    }
    public void showLabel() {
      fill(120 - max(2,Integer.parseInt(label)) * 20, Integer.parseInt(label) * 60, max(3,Integer.parseInt(label)) * 60);
      text(label,x+width/2,y+height/2);
    }
    public boolean isValid(int r, int c) {
      if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS) {
        return true;
      }
      return false;
    }
    public int countBombs(int row, int col) {
        int count = 0;
        for (int i = row-1; i <= row+1; i++) {
          for (int j = col-1; j <= col+1; j++) {
            if (isValid(i,j) && bombs.contains(buttons[i][j]) && !(i == row && j == col)) {
              count++;
            }
          }
        }
        return count;
    }
}
