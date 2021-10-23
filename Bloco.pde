class Bloco
{
  int col, row, size = 40, cont = 0;
  PVector pos;
  String status; // (None, Snake, Food)

  Bloco(int coluna, int linha)
  {
    this.col = coluna;
    this.row = linha;

    if (coluna == cabeca.x && linha == cabeca.y)
    {
      this.status = "Snake";
    } else
    {
      this.status = "None";
      cont = 0;
    }

    pos = new PVector(coluna*size, linha*size);
  }

  void update()
  {
    if (this.status == "Snake")
    {
      this.cont++;

      if (this.cont > limite)
      {
        this.status = "None";
        this.cont = 0;
      }
    } else
    {
      this.cont = 0;
    }
  }

  void draw()
  {
    if (this.status == "Snake")
    {
      fill(255);
    } else if (this.status == "Food")
    {
      fill(255, 128, 0);
    }
    else
    {
      fill(0);
    }
    
    noStroke();

    if(this.status == "Food")
    {
      ellipse(pos.x+size/2, pos.y+size/2, size*0.8, size*0.8);
    }
    else
    {
      rect(pos.x, pos.y, size, size);
    }
  }
}