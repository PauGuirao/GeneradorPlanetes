//Colors levels to create the planet
color sea = color(random(255),random(255),random(255));
color ground_1 = color(random(255),random(255),random(255));
color ground_2 = color(random(255),random(255),random(255));
color atmosColor = color(int(random(64)) + 128, int(random(64)) + 128, int(random(64)) + 128);

//Posicions de les estrelles del skyline
float[] Xposes = new float[300];
float[] Yposes = new float[300];

//Earth rotation velocity
float increment = 0;
int indexImg = 0;

void setup(){
  size(1000,1000);
  background(0,0,0);
  drawStarfield();
  drawPlanet(150,0.58,0.68);
  drawMoon(30,100);
  createTexture("Example","jpg");
}
void draw(){
  //background(0);
  
  //Dibuix de la imatge
  //drawStarfield();
  //drawPlanet(100);
  //drawMoon(true);
  
  //Increment amb el cual es mou la terra, es por variar
  increment+=0.1;
  
  //Desactivar en cas de no voler generar imatges
  //indexImg++;
  //save("render_"+indexImg+".jpg");
}

void createTexture(String name,String type){
  save(name+"."+type);
}
//Crea una lluna, com a parametre li passem un boolea en cas de que no la vulguem mostrar
void drawMoon(int radMoon, int distance){
    int rand = 200;
    for (int i = 0; i < 1000; i++) {
      for (int j = 0; j < 1000; j++) {
        if (isInsideCircle(j, distance+rand, i, distance+rand, radMoon)) {
              float n = noise(i* 0.05+increment*3,j*0.05+increment*3);
              stroke(100,100,100);
              if(n > 0){
                stroke(170,170,170);
              }
              if(n > 0.58){
                stroke(120,120,120);
              }
              if(n > 0.68){
                stroke(90,90,90);
              }
              point(i,j);
        }
      }
    }
  
}


//Genera tot el planet, surpeficie, hombres, nuvols, oclussió
void drawPlanet(int radius, float level_1,float level_2){
  translate((width/2)-radius,(height/2)-radius);
  drawSurface(radius,level_1,level_2);
  drawAtmos(radius);
  drawOcclusion(radius);
  drawPlanetShadow(radius);
  drawNuves(radius);
}
  
//Genera la superficie del planeta amb perlin noise, utilitza el la variable global increment per moure la terra, mes gran, mes velocitat
//Utilitzo el valor entre 0 i 1 del perlin noise per determinar altures i aixi poder pintar els continents o mar
void drawSurface(int radius, float level_1, float level_2) {
  for (int i = 0; i < 1000; i++) {
    for (int j = 0; j < 1000; j++) {
      if (isInsideCircle(j, radius, i, radius,radius)) {
          float n = noise(i* 0.02+increment,j*0.02+increment);
          if(n > 0){
            stroke(sea);
          }
          if(n > level_1){
            stroke(ground_1);
          }
          if(n > level_2){
            stroke(ground_2);
          }
          point(i,j);
          
          
      }
    }
  }
}

//Dibuixa els nuvols tambe amb perlin noise ara simplement pintat en blanc i amb opacitat reduida
void drawNuves(int radius){
  for (int i = 0; i < 1000; i++) {
    for (int j = 0; j < 1000; j++) {
      if (isInsideCircle(j, radius, i, radius, radius)) {
          float n = noise(j*0.02+increment,i*.01+increment);
          if(n > 0){
            stroke(255,255,255,0);
          }
          if(n > 0.68){
            stroke(255,255,255,50);
          }
          point(i,j);
          
          
      }
    }
  }
}

//Dibuixa una ombra al planeta
void drawPlanetShadow(int radius) {
  for (int i = 0; i < 1000; i++) {
    for (int j = 0; j < 1000; j++) {
      if (!isInsideCircle(j, radius + (radius / 4), i, 3 * radius / 4, (int)(radius * 0.9)) && isInsideCircle(j, radius, i, radius, radius)) {
          stroke(0,0,0,48);
          point(i,j);
      }
    }
  }
}

//Dibuixa la oclussió del planeta per donar un efecte mes realista
void drawOcclusion(int radius){
  for (int i = 0; i < 1000; i++) {
    for (int j = 0; j < 1000; j++) {
      if (isInsideCircle(j, radius, i, radius, radius - (1)) && isInsideCircle(j, radius, i, radius, radius)) {
          stroke(0,0,0,96);
          point(i,j); 
        }
    }
  }
}

//Dibuixa l'atmosfera d'un color random (una mica innecessari pero perque no?)
void drawAtmos(int radius){
  for (int i = 0; i < 1000; i++) {
    for (int j = 0; j < 1000; j++) {
      if (isInsideCircle(j, radius, i, radius, radius)) {
          stroke(red(atmosColor), green(atmosColor), blue(atmosColor), 55);
          point(i,j);
       }
    }
  }
}

//Funcio que serveix per generar una mascara rodona i aixi poder dibuixar un planeta
boolean isInsideCircle(int x, int centerX, int y, int centerY, int radius) {
  return sq(x - centerX) + sq(y - centerY) < sq(radius);
}


//Crea les posicions a on es generaran les estrelles
void createStarField(){
  for(int i = 0; i< 300; i++){
    float x = random(-width,width);
    float y = random(-height,height);
    Xposes[i] = x;
    Yposes[i] = y;
  }
}

//Dibuixa les estrelles a les posicions previament generades a <createStarField>
void drawStarfield(){
  createStarField();
  for(int i = 0; i< 300; i++){
    float size = random(0,1.5);
    ellipse(Xposes[i],Yposes[i],2+size,2+size);
  }
}


  
  
