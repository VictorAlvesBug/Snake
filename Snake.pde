int maxColunas, maxLinhas;

Bloco[][] bloco;
String direcao = "right"; // (up, down, left, right)
PVector cabeca, food;
int limite = 3;
boolean mudouDirecao = false;

void setup()
{
  size(800, 800);
  //fullScreen();

  //noCursor();

  maxColunas = width/40;
  maxLinhas = height/40;

  bloco = new Bloco[maxColunas][maxLinhas];
  cabeca = new PVector((int)maxColunas/2, (int)maxLinhas/2);

  for (int row=0; row<maxLinhas; row++)
  {
    for (int col=0; col<maxColunas; col++)
    {
      bloco[col][row] = new Bloco(col, row);
    }
  }

  GerarFood();
}

void draw()
{
  background(0);

  switch(direcao)
  {
  case "up":
    cabeca.y--;
    break;
  case "down":
    cabeca.y++;
    break;
  case "left":
    cabeca.x--;
    break;
  case "right":
    cabeca.x++;
    break;
  }

  if (cabeca.x < 0)
  {
    cabeca.x = maxColunas - 1;
  }

  if (cabeca.x >= maxColunas)
  {
    cabeca.x = 0;
  }

  if (cabeca.y < 0)
  {
    cabeca.y = maxLinhas - 1;
  }

  if (cabeca.y >= maxLinhas)
  {
    cabeca.y = 0;
  }

  if (bloco[(int)cabeca.x][(int)cabeca.y].status == "Food")
  {
    limite++;
    GerarFood();
  } else if (bloco[(int)cabeca.x][(int)cabeca.y].status == "Snake")
  {
    // GAME OVER
    limite = 3;
  }

  bloco[(int)cabeca.x][(int)cabeca.y].status = "Snake";

  for (int row=0; row<maxLinhas; row++)
  {
    for (int col=0; col<maxColunas; col++)
    {
      bloco[col][row].update();
    }
  }

  for (int row=0; row<maxLinhas; row++)
  {
    for (int col=0; col<maxColunas; col++)
    {
      bloco[col][row].draw();
    }
  }

  //delay(50);

  mudouDirecao = false;

  //Artificial Intellingence

  if (!mudouDirecao)
  {
    if (cabeca.x == food.x)
    {
      if (food.y < cabeca.y && direcao != "down")
      {
        direcao = "up";
        mudouDirecao = true;
      } else if (food.y > cabeca.y && direcao != "up")
      {
        direcao = "down";
        mudouDirecao = true;
      } else
      {
        direcao = "right";
        mudouDirecao = true;
      }
    } else
    {
      direcao = "right";
      mudouDirecao = true;
    }
  }
}

void keyPressed() 
{
  if (key == CODED && !mudouDirecao) 
  {
    if (direcao == "up" || direcao == "down")
    {
      switch(keyCode)
      {
      case LEFT:
        direcao = "left";
        mudouDirecao = true;
        break;
      case RIGHT:
        direcao = "right";
        mudouDirecao = true;
        break;
      }
    } else
    {
      switch(keyCode)
      {
      case UP:
        direcao = "up";
        mudouDirecao = true;
        break;
      case DOWN:
        direcao = "down";
        mudouDirecao = true;
        break;
      }
    }
  }
}

void GerarFood()
{
  int rndX, rndY;

  do
  {
    rndX = (int)random(maxColunas);
    rndY = (int)random(maxLinhas);
  }
  while (bloco[rndX][rndY].status == "Snake");

  bloco[rndX][rndY].status = "Food";
  food = new PVector(rndX, rndY);
}