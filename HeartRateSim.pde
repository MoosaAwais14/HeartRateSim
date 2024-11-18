/**
 * Sine Wave
 * by Daniel Shiffman.  
 * 
 * Render a simple sine wave. 
 */
 
int xspacing = 5;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 40.0;  // Height of wave
float period = 250.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float f = 60.0;
String condition;
float[] yvalues;  // Using an array to store height values for the wave

int c;
int cc;
  
void setup() {
  size(1650, 1000);
  w = width+50;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
}


void draw() {
  background(0);
  calcWave();
  renderWave();
}

void curBPM(float ff){ // function responsible for visually displaying heart rate

  // each condition sets the color for that scenario, and passes an argument to the label function, where the condition of the heart rate is determined
  
  if(ff<=100 && ff >=60){ 
    c = #2051E0;
    cc = #9DADDB;
    label("Rest");
  }
  
  if(ff>100 && ff<180){
    c = #E7E8D3;
    cc = #D9E020;
    label("Exercise Likely");
  }
  
  if(ff>170 && ff<=204){
    c = #E8D3D3;
    cc = #E51C1C;
    label("TACHCARDIA  REACHED");
  }
  
  if(ff<60 && ff >20){
    c = #E8D3D3;
    cc = #E51C1C;
    label("BRADYCARDIA  REACHED");
  }
  
  if(ff == 20){
    c = #4B3838;
    cc = #FFFFFF;
    label("FLATLINE");
    ff-=20;
  }
  
  if(ff >= 204){
    c = #4B3838;
    cc = #FFFFFF;
    label("MAX  HR  REACHED");
  }
  
  // overlaying text on rect:
  fill(cc);
  rect(35, 85, 230, 45);
  textSize(50);
  fill(c);
  text((ff + " BPM"), 40, 120); // displaying current HR

  fill(cc);
}

void label(String cond){ 
    textSize(60);
    fill(cc);

  // making dynamic placeholders for each HR condition, depending on what is passed into the function
  
  if(f<=100 && f >=60){ 
    rect(995, 80, 120, 45);
    fill(c);
    text((cond), 1000, 120);
  }
  
  if(f>100 && f < 180){
    rect(995, 75, 370, 55);
    fill(c);
    text((cond), 1000, 120);
  }
  
  if(f>170 && f<=204){
    rect(995, 75, 600, 55);
    fill(c);
    text((cond), 1000, 120);
  }
  
  if(f<60 && f>20){
    rect(995, 75, 620, 55);
    fill(c);
    text((cond), 1000, 120);
  }
  
  //fill(c);
  
  if(f==20){
    rect(995, 75, 280, 55);
    fill(c);
    text((cond), 1000, 120);
  }
  
  if(f>=204){
    rect(995, 75, 480, 55);
    fill(c);
    text((cond), 1000, 120);
  }
   
}

void calcWave() {
  
  // changing the angular velocity of the sine function (equivalent to changing the speed of HB)
  theta += TWO_PI * (f/60.0) / 60.0;   // converts from BPM to BPS
  
  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
  }
}

void renderWave() {
  noStroke();
  fill(255);
  curBPM(f); // this function deals with drawing text that indicates that current HR
  for (int x = 0; x < yvalues.length; x++) { // draws the wave
    ellipse(x*xspacing, height/2+yvalues[x], 5, 5);
  }
}

void keyPressed() {
  
  if (key == ENTER && f < 204) {
    f += 10;
    amplitude+=10;  // Increasing the "heaight" of the wave (indicating an increase in HR)
  } 
 
 if (key == BACKSPACE && f>=30) {
    f -= 10;
    amplitude-=10;  // Decreasing the "heaight" of the wave (indicating a decrease in HR)
  }
  
 if(key=='r'){ // restets to resting HR
    amplitude=40.0;
    f = 60;
  }

}
