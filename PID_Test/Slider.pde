class Slider {
  float x, y, w, h, maxValue;
  float handleX, handleY, handleSize;
  String nameTag; // Variable for the name tag
  boolean dragging = false;

  Slider(float x, float y, float w, float h, float maxValue, String nameTag) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.maxValue = maxValue;
    this.nameTag = nameTag;

    this.handleSize = 20;
    this.handleX = x;
    this.handleY = y + h / 2;
  }

  void display() {
    // Draw slider track
    stroke(0);
    fill(220);
    rect(x, y, w, h);
  
    // Draw slider handle
    fill(180);
    circle(handleX, handleY, handleSize);
  
    // Display the name tag centered in the y position of the bar
    fill(0);
    textAlign(CENTER, CENTER); // Set text alignment to center
    text(nameTag, x + w / 2, y + h / 2); // Position the text in the center of the bar
  }


  void update() {
    if (dragging) {
      handleX = constrain(mouseX, x, x + w);
    }
  }

  boolean overHandle() {
    return dist(mouseX, mouseY, handleX, handleY) < handleSize / 2;
  }

  float getValue() {
    return map(handleX, x, x + w, 0, maxValue);
  }

  void startDrag() {
    if (overHandle()) {
      dragging = true;
    }
  }

  void stopDrag() {
    dragging = false;
  }
  
  void reset() {
    handleX = x; // Reset handle to the initial position
  }
}
