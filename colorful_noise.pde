//this is a cellular automata simulation in processing
//main part of the code was written by Martin Zalz Austwick of
//CASA, UCL (casa.ucl.ac.uk)
//in the context of the module Visualization Project
//what i did, is i messed with the colours to produce this nice effect

/*
 CA
 Geometry: square grid
 Definition of neighbours:
   Moore or Von Neumann: Moore
 World Geometry
 Number of "species"
 Variable/Updates: cts or discrete?
 Temporary variables for storage  of future states
*/

Cell [][] cells;
//for an n x n array
int n=120;

void setup()
{
  size(600, 600);
  //noStroke();
  background(255);
  cells=new Cell[n][n];
  int cellSize=width/n;
  for (int i=0; i<n; i++)
  {
    for (int j=0; j<n; j++)
    {
      cells[i][j]=new Cell(i*cellSize, j*cellSize, cellSize-1);
      if (random(1)<0.2) cells[i][j].state=1;
      else cells[i][j].state=0;
    }
  }
  //frameRate(1);
}

void draw()
{
   for (int i=0; i<n; i++)
  {
    for (int j=0; j<n; j++)
    {
      cells[i][j].display();
    }
  }
  update();
}

void update()
{
  for (int i=0; i<n; i++)
  {
   for (int j=0; j<n; j++)
    {
      //the four conditions of the simple von Neumann's system     
      int a=(j - 1 + n)%n; //instead of [j-1]
      int b=(j + 1 + n)%n;
      int c=(i - 1 + n)%n;
      int d=(i + 1 + n)%n;
      /*
      cells[i][a];
      cells[i][b];     
      cells[c][j];
      cells[d][j];   
      
      cells[i][j-1];
      cells[i][j+1];     
      cells[i-1][j];
      cells[i+1][j];
      */
      /*
      the diagonal cells
      cells
      cells[i-1][j-1];
      cells[i+1][j-1];     
      cells[i+1][j+1];
      cells[i-1][j+1];
     
      cells[c][a];
      cells[d][b];     
      cells[c][b];
      cells[d][a]; 
       */
      
      float neighborscore=0;
      neighborscore+=cells[i][a].state;
      neighborscore+=cells[i][b].state;     
      neighborscore+=cells[c][j].state;
      neighborscore+=cells[d][j].state; 
      neighborscore+=cells[c][a].state;
      neighborscore+=cells[d][b].state;     
      neighborscore+=cells[c][b].state;
      neighborscore+=cells[d][a].state; 
      
      if (neighborscore<2) cells[i][j].nextState=0;
    //  if (neighborscore==3 || neighborscore==2) cells[i][j].nextState=cells[i][j].state;
      if (neighborscore==2) cells[i][j].nextState=cells[i][j].state;
      if (neighborscore==3) cells[i][j].nextState=1;
      //if (neighborscore==5) cells[i][j].nextState=cells[i][j].state;
      if (neighborscore>3) cells[i][j].nextState=0;
   }
  }
  for (int i=0; i<n; i++)
  {
    for (int j=0; j<n; j++)
    {
      cells[i][j].state=cells[i][j].nextState;
    }
  }  
}

class Cell
{
  float state, nextState;
  int x,y;
  int csize;
  
  Cell(int xin, int yin, int sizein)
  {
    x=xin;
    y=yin;
    csize=sizein;
  }
  
  void display()
  {
    fill(200*state, random(255), random(255));
    rect(x,y, csize, csize);
  }
}

void keyPressed()
{
  if (key=='r') setup();
}
