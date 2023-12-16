int frequency = 120;
PID xPID = new PID(0, 0, 0, frequency, 1);
PID yPID = new PID(0, 0, 0, frequency, 1);
Ball moveObject = new Ball(0, 0, 25);
Slider pGainSlider;
Slider iGainSlider;
Slider dGainSlider;
Button resetButton;


void setup() {
  size(900, 600);
  frameRate(frequency);
  
  float maxPGain = 1;
  float maxIGain = .01;
  float maxDGain = 1;
  
  moveObject.x = width / 2;
  moveObject.y = height / 2;
  
  // Set up sliders;
  pGainSlider = new Slider(50, height - 70, width - 100, 20, maxPGain, "P Gain");
  iGainSlider = new Slider(50, height - 50, width - 100, 20, maxIGain, "I Gain");
  dGainSlider = new Slider(50, height - 30, width - 100, 20, maxDGain, "D Gain");

  
  // Set up Button;
  resetButton = new Button(width - 150, 10, 140, 30, "Reset PID");
}

void draw() {
  background(255);
  
  // Draw the PID position;
  int x = moveObject.getX();
  int y = moveObject.getY();
  
  int targetX = mouseX;
  int targetY = mouseY;
  
  float xMove = xPID.getMove(targetX, x);
  float yMove = yPID.getMove(targetY, y);
  
  int[] result = moveObject.move(xMove, yMove);
  
  fill(0, 0, 255);
  circle(result[0], result[1], 30);
  
  
  // Update and display the sliders;
  pGainSlider.update();
  pGainSlider.display();
  
  iGainSlider.update();
  iGainSlider.display();
  
  dGainSlider.update();
  dGainSlider.display();
  
  // Draw Button;
  
  resetButton.display();
  
  // Set the gain from the sliders;
  float pGain = pGainSlider.getValue();
  xPID.setPGain(pGain);
  yPID.setPGain(pGain);
  
  float iGain = iGainSlider.getValue();
  xPID.setIGain(iGain);
  yPID.setIGain(iGain);
  
  float dGain = dGainSlider.getValue();
  xPID.setDGain(dGain);
  yPID.setDGain(dGain);
}

// Slider stuff;
void mousePressed() {
  pGainSlider.startDrag();
  iGainSlider.startDrag();
  dGainSlider.startDrag();
  
  if (resetButton.overButton()) {
    xPID.reset();
    yPID.reset();
    pGainSlider.reset();
    iGainSlider.reset();
    dGainSlider.reset();
    
    moveObject.x = width / 2;
    moveObject.y = height / 2;
    moveObject.xMomentum = 0;
    moveObject.yMomentum = 0;
    
  }
}

void mouseReleased() {
  pGainSlider.stopDrag();
  iGainSlider.stopDrag();
  dGainSlider.stopDrag();
}
