/*

 Pointillism Studio LITE
 
 This is a program intended to be a flexible tool in which the user can use their 
 creativity to sketch things on the canvas. This program comes with a flexible brush
 size, an eraser, a reset button, live mouse tracking and informational displays, random
 colors, and color spectrum cycling. 
 
 Instructions:
 > Hold down the mouse to draw
 > Hold the space bar until you reach your desired color along the entire color 
 spectrum (different shades of your desired color is unavailable)
 > Hold the shift key to cycle through the black and white spectrum
 > Press the RGB color button and type in a desired RGB value; if no value is entered,
 a random RGB color value will be chosen when you press enter
 > Press the up arrow key to increase the brush size, and press the down arrow key to decrease the brush size
 > Press the left arrow key to decrease brush opacity, and press the right arrow key to increase brush opacity
 > Press the eraser button OR the 'E' key to turn eraser on/off
 > Press p/P OR click the pause button to pause your work
 > Press r/R OR click the reset button to reset the entire drawing, color, eraser mode, 
 and brush size
 
 Notes:
 > The color currently selected will be displayed and updated dynamically at the top of
 the sketch.
 > Unlike the assigment rubric which asked for a println() function to track the mouse,
 I found that it took up unnecessary console space so I decided to track the live 
 coordinates of your mouse as text in the top-right corner of the screen.
 > When you type in RGB values by hand, the system will ADD whatever number you type in
 to the selected total value. For example, typing "11" will result in the value being 
 set to 2 and not 11. Zeros will add 10 to the total value. Press , to proceed to the 
 next value. 
 */

// VARIABLE LIST
boolean showInstructions = true; // The program will show instructions on start
boolean eraser = false; // Eraser is disabled
boolean paused = false; // The program is not paused
boolean shiftPressed = false; // The shift key has not been pressed
boolean receivingRgbInput = false;
boolean randomColor = false;
boolean displayingAuthor = false;

int dotSize = 20; // Default dot size is 20 pixels
int storeDotSize = 20; // Stores the dot size as 20

int dotColor1 = 0; // Sets the colors of ellipse to black for now
int dotColor2 = 0;
int dotColor3 = 0;
int dotOpacity = 255; // Maximum opacity

int storeDotR = 0; // Sets the stored color and opacity values to black/max for now
int storeDotG = 0;
int storeDotB = 0;
int storeOpacity = 255;

String eraserMode = "Off"; // Displays the eraser mode as "Off"
String rgbInput = dotColor1 + ", " + dotColor2 + ", " + dotColor3;
String rgbColor = "RGB Color: ";
String pauseText = "Pause";
String titleText = "Pointillism Studio LITE";

int currentInput = 1;
int userInputR = 0;
int userInputG = 0;
int userInputB = 0;

int textColorR = 0; // Sets the display bar color to black for now
int textColorG = 0;
int textColorB = 0;

int whiteBlack = 255;
int buttonStroke = 255;

int instructionsTextFill = 0;

// SET UP THE SKETCH
void setup() {
  size(1000, 800); // Sketch is 1000 by 800 pixels
  background(255); // Backgroubd is white
  noStroke(); // Disable stroke for now
  cursor(ARROW); // Sets the cursor within the sketch to a cross (+)
  smooth();

  // The following lines of code create the instruction text that's displayed when the sketch starts
  fill(255);
  rect(0, 0, width, height);
  fill(0);
  textAlign(CENTER);
  textSize(24);
  text("Instructions", width / 2, height / 2 - 100);
  textSize(16);
  text("Press and hold the mouse to draw", width / 2, height / 2 - 70);
  text("Press and hold the space bar to cycle through the color spectrum", width / 2, height / 2 - 50);
  text("Hold the shift key to cycle through the black and white spectrum", width / 2, height / 2 - 30);
  text("Press the RGB color button to enter a desired color value. If no value is entered, a random color is generated.", width / 2, height / 2 - 10);
  text("Press the up/down arrow keys to change brush size", width / 2, height / 2 + 10);
  text("Press the left/right arrow keys to change the brush opacity", width / 2, height / 2 + 30);
  text("Press the eraser button/the E key to toggle the eraser", width / 2, height / 2 + 50);
  text("Press the pause button/the P key to toggle pause", width / 2, height / 2 + 70);
  text("Press the reset button/the R key to reset the canvas", width / 2, height / 2 + 90);
  text("Ready? Click anywhere onscreen or press any key to begin!", width / 2, height / 2 + 130);
}

// DRAW THE SKETCH
void draw() {
  if (showInstructions == true) return; // Do not run the code below if instructions are shown

  rgbInput = dotColor1 + ", " + dotColor2 + ", " + dotColor3; // Display the RGB colors to the user

  // The following lines of code changes the type of cursor according to the position of
  // the mouse.
  if (mouseX >= width/2 - 406 && mouseX <= width/2 - 406 + 160 && mouseY >= 10 && mouseY <= 40) {
    cursor(HAND);
  } else if (mouseX >= 4 && mouseX <= 74 && mouseY >= 10 && mouseY <= 40) {
    cursor(HAND);
  } else if (mouseX >= width/2-230 && mouseX <= width/2-230+44 && mouseY >= 10 && mouseY <= 40) {
    cursor(HAND);
  } else if (mouseX >= width/2-176 && mouseX <= width/2-176+44 && mouseY >= 10 && mouseY <= 40) {
    cursor(HAND);
  } else if (mouseY > 50) {
    cursor(CROSS);
  } else if (mouseX >= width/2-86 && mouseX <= width/2-86+135 + 6 && mouseY >= 10 && mouseY <= 40) {
    cursor(HAND);
  } else if (mouseY <= 50) {
    cursor(ARROW);
  } 

  fill(textColorR, textColorG, textColorB); // Fills the display bar with its corresponding color variable
  rect(0, 0, width, 50); // Draws a display bar at the top of the sketch to dynamically display the current RGB color to the user

  stroke(buttonStroke); // Sets the stroke to 255 to draw white borders around the buttons to make them stand out
  strokeJoin(ROUND); // This is intended to make the borders of the buttons round
  rect(4, 10, 74, 30); // Button that corresponds to eraser mode
  rect(width/2 - 406, 10, 160, 30); // Button that corresponds with RGB color numbers
  rect(width/2-230, 10, 44, 30); // Button that resets the sketch
  rect(width/2-176, 10, 52, 30); // Button that pauses the sketch

  noStroke(); // Disables stroke again
  fill(whiteBlack); // White fill for the text
  textSize(12.5);
  textAlign(LEFT);
  text("Mouse: " + mouseX + ", " + mouseY, width - 110, 30); // Mouse coordinates text
  text(rgbColor + rgbInput, width/2-400, 30); // RGB colors text
  text("Reset", width/2-224, 30); // Reset text
  text(pauseText, width/2-170, 30); // Paused text
  text("Eraser: " + eraserMode, 10, 30); // Eraser mode text
  text("Brush size: " + dotSize, width - 208, 30); // Dot size text
  text("Dot opacity: " + dotOpacity + "/255", width - 356, 30); // Dot opacity text 

  textSize(15);
  text(titleText, width/2-80, 30); // Title text

  if (mousePressed) { // Mouse pressed events
    rgbColor = "RGB Color: "; // Changes the RGB button text to "RGB Color: " and not "Press enter: "

    if (eraser == true) { // This checks if the eraser is enabled; if it is, then it sets the ellipse color to white
      dotColor1 = 255;
      dotColor2 = 255;
      dotColor3 = 255;
      dotOpacity = 255;
    } 

    if (randomColor != true && eraser == false) { // This checks if the current RGB color is a random color and if the eraser is disabled
      dotColor1 = storeDotR; // If both conditions are met, change the RGB color to a stored value
      dotColor2 = storeDotG;
      dotColor3 = storeDotB;
      textColorR = dotColor1;
      textColorG = dotColor2;
      textColorB = dotColor3;
    }

    if (mouseX >= width/2-176 && mouseX <= width/2-176+52 && mouseY >= 10 && mouseY <= 40) { // If the mouse is over the pause button when it is pressed
      if (paused == false) { // Checks if the sketch is not paused
        dotOpacity = 0; // Makes the dot that's going to be drawn transparent so the user can't see it
        pauseText = "Paused"; // Change the text in the button to indicate that the sketch has been paused
      }
    }

    fill(dotColor1, dotColor2, dotColor3, dotOpacity); // Fill the ellipse with dot colors and opacity
    ellipse(mouseX, mouseY, dotSize, dotSize); // Draws an ellipse at the mouse coordinates with the dot size as diameter
  }

  if (keyPressed) { // Key pressed events
    if (keyCode == UP) { // If the up arrow key is pressed
      if (dotSize < 160) { // As long as the dot size is below 160 pixels, add 1 pixel to it for every frame that the arrow key is pressed
        dotSize++;
        if (eraser == false) {
          storeDotSize = dotSize; // If the eraser is disabled, change the stored dot size value to match the current dot size value
        }
      }
    } else if (keyCode == DOWN) { // If the down arrow key is pressed
      if (dotSize > 5) { // As long as the dot size is above 5 pixels, add 1 pixel to it for every frame that the arrow key is pressed
        dotSize--;
        if (eraser == false) {
          storeDotSize = dotSize; // If the eraser is disabled, change the stored dot size value to match the current dot size value
        }
      } // End of dotSize if statement
    } else if (keyCode == LEFT) { // If the left key is pressed
      if (dotOpacity > 1) { // Take away 1 point of dot opacity every frame if dot opacity is less than 1
        dotOpacity--;
        storeOpacity = dotOpacity; // Update the stored dot opacity value
      }  // End of dotOpacity if statement
    } else if (keyCode == RIGHT) { // If the right key is pressed
      if (dotOpacity < 255) { // Add 1 point of dot opacity every frame if dot opacity is less than 255
        dotOpacity++;
        storeOpacity = dotOpacity; // Update the stored dot opacity value
      }
    } else if (keyCode == SHIFT) { // If the shift key is pressed
      if (shiftPressed == false) { // If the shift key pressed state is false
        dotColor1 = 0; // Change the RGB value to black
        dotColor2 = 0;
        dotColor3 = 0;
        shiftPressed = true; // Change the shift key pressed state to true
      } else if (shiftPressed == true) { // If the shift key pressed state is true
        if (dotColor1 < 255) { // If the R value is less than 255 (white)
          dotColor1++; // Add 1 point to each of these values every frame
          dotColor2++;
          dotColor3++;
          rgbInput = dotColor1 + ", " + dotColor2 + ", " + dotColor3; // Update the RGB text display
        } else if (dotColor1 == 255) { // If the R value is equal to 255
          dotColor1 = 0; // Change these values to 0 (black) again so that it starts the cycle anew
          dotColor2 = 0;
          dotColor3 = 0;
        }
      }
      textColorR = dotColor1; // Change the display bar fill to match the current color
      textColorG = dotColor2;
      textColorB = dotColor3;
    }

    if (key == 'p' || key == 'P') {
      if (paused == false) {
        pauseText = "Paused"; // Change the pause button text to indicate that the sketch has been paused
      }
    }

    if (key == ' ') { // Algorithm to cycle through the entire color spectrum
      dotColor1 = storeDotR; // First, get the stored dot color values
      dotColor2 = storeDotG;
      dotColor3 = storeDotB; 
      dotOpacity = storeOpacity;
      if (dotColor1 == 0 && dotColor2 == 0 && dotColor3 == 0) { // Checks if the dot color is black (the default color)
        dotColor1 = 255; // If it is, then change the dot color to red
        dotColor2 = 0;
        dotColor3 = 0;
        /*
      The following code is based on a pattern that I found while cycling through the
         color selector and observing their values. This code changes the color values 
         based on the current color so that it is able to cycle through the entire 
         RGB spectrum (shades excluded)
         */
      } else if (dotColor1 == 255 && dotColor2 >= 0 && dotColor2 < 255 && dotColor3 == 0) {
        dotColor2++;
      } else if (dotColor1 > 0 && dotColor1 <= 255 && dotColor2 == 255 && dotColor3 == 0) {
        dotColor1--;
      } else if (dotColor1 == 0 && dotColor2 == 255 && dotColor3 >= 0 && dotColor3 < 255) {
        dotColor3++;
      } else if (dotColor1 == 0 && dotColor2 > 0 && dotColor2 <= 255 && dotColor3 == 255) {
        dotColor2--;
      } else if (dotColor1 >= 0 && dotColor1 < 255 && dotColor2 == 0 && dotColor3 == 255) {
        dotColor1++;
      } else if (dotColor1 == 255 && dotColor2 == 0 && dotColor3 <= 255 && dotColor3 > 0) {
        dotColor3--;
      } 

      randomColor = false; // This is not a random color

      storeDotR = dotColor1; // Update the stored color values
      storeDotG = dotColor2;
      storeDotB = dotColor3;
      textColorR = dotColor1; // Update the display bar color
      textColorG = dotColor2;
      textColorB = dotColor3;
    } // End of key == ' ' event
  } // End of keyPressed event

  if (receivingRgbInput == false) {
    if (dotColor1 >= 150 && dotColor2 >= 150 && dotColor3 >= 0) { // Changes the display bar text color between white and black depending on how dark the color is.
      whiteBlack = 0;
      buttonStroke = 0;
    } else if (dotColor1 >= 0 && dotColor2 >= 150 && dotColor3 >= 0) {
      whiteBlack = 0;
      buttonStroke = 0;
    } else {
      whiteBlack = 255;
      buttonStroke = 255;
    } // End of else statement
  }

  if (eraser == true) { // Change the button border colors when the eraser is enabled
    whiteBlack = 255;
    buttonStroke = 255;
  }
} // End of draw()

void mouseReleased() { // Mouse released events (this will only run once when the mouse is released)
  if (showInstructions == true) { // If instructions are showing
    showInstructions = false; // Set boolean to false

    fill(255); // Draws a white rectangle over the entire program to cover up the text
    rect(0, 0, width, height);
  }

  if (showInstructions == true) return; // Do not run the code if instructions are shown

  if (mouseX >= width/2 - 406 && mouseX <= width/2 - 406 + 160 && mouseY >= 10 && mouseY <= 40) { // Random RGB color/manual user input button
    if (receivingRgbInput == false) { // Checks if input is not being received
      if (eraser == false) { // Checks if the eraser is off
        dotColor1 = 0; // If it is, change the dot color to black (for the display bar)
        dotColor2 = 0;
        dotColor3 = 0;
        rgbColor = "Press enter: "; // Prompts the user to press the enter key when done
        receivingRgbInput = true; // The program is now receiving user input
        currentInput = 1; // The RGB position is set to the red value currently
        textColorR = dotColor1; // Update the display bar
        textColorG = dotColor2;
        textColorB = dotColor3;
        
        whiteBlack = 255;
        buttonStroke = 255;
      } else { // This else statement prevents the user from choosing a color while eraser is turned on
        dotColor1 = 255;
        dotColor2 = 255;
        dotColor3 = 255;
        textColorR = 0;
        textColorG = 0;
        textColorB = 0;
        rgbColor = "RGB Color: ";
        receivingRgbInput = false;
      }
    }
  }

  if (mouseX >= 4 && mouseX <= 74 && mouseY >= 10 && mouseY <= 40) { // Eraser button click event
    if (eraser == false) { // Checks if the eraser is turned off
      whiteBlack = 255; // Updates display bar text colors
      buttonStroke = 255;
      eraser = true; // The eraser is now turned on
      eraserMode = "On"; // Change the eraser mode display text to indicate that it's on
      textColorR = 0; // Sets the display bar color to blaack
      textColorG = 0;
      textColorB = 0;
      dotColor1 = 255; // Changes the dot color values to white, effectively creating an eraser
      dotColor2 = 255;
      dotColor3 = 255;
      dotOpacity = 255;
      whiteBlack = 255;
      buttonStroke = 255;
      dotSize = 20; // Changes the size of the brush back to the default size
    } else {
      dotColor1 = storeDotR; // Retrieves the stored brush values and changes the brush color accordingly
      dotColor2 = storeDotG;
      dotColor3 = storeDotB;
      dotOpacity = storeOpacity;
      dotSize = storeDotSize;
      if (dotColor1 >= 80 && dotColor2 >= 50 && dotColor3 >= 50) { // Updates the display bar's text color between white and black according to the selected color
        whiteBlack = 0;
        buttonStroke = 0;
      } else {
        whiteBlack = 255;
        buttonStroke = 255;
      }
      textColorR = dotColor1; // Updates display bar color
      textColorG = dotColor2;
      textColorB = dotColor3;
      eraser = false; // The eraser is now disabled
      eraserMode = "Off"; // Update the eraser display text that the user sees
    }
  }

  if (mouseX >= 270 && mouseX <= 314 && mouseY >= 10 && mouseY <= 40) { // Reset button click event
    fill(255); 
    rect(0, 0, width, height); // Draws a white rectangle over the entire program, effectively creating a blank canvas
    whiteBlack = 255; // Changes the text color on the display bar
    buttonStroke = 255; 
    dotColor1 = 0; // Resets brush color values
    dotColor2 = 0;
    dotColor3 = 0;
    dotOpacity = 255; // The brush is now fully opaque
    storeOpacity = 255;
    storeDotR = dotColor1; // Update the stored values
    storeDotG = dotColor2;
    storeDotB = dotColor3;
    textColorR = 0; // Makes the display bar background black
    textColorG = 0;
    textColorB = 0;
    dotSize = 20; // Resets brush size
    storeDotSize = 20; // Resets the stored brush size
    eraser = false; // The eraser is now off
    receivingRgbInput = false; // The program is no longer receiving input
    userInputR = 0; // Resets user input values
    userInputG = 0;
    userInputB = 0;
    eraserMode = "Off"; // Update the eraser display text
  }

  if (mouseX >= width/2 - 86 && mouseX <= width/2 - 86 + 135 + 6 && mouseY >= 10 && mouseY <= 40) { // Title click
    if (displayingAuthor == false) { // If the title is currently not my name
      titleText = "By Jeremy Liu"; // Self credit! :)
      displayingAuthor = true; // It is now displaying my name
    } else { // If it's already displayaing my name
      titleText = "Pointillism Studio LITE"; // Change the name back
      displayingAuthor = false; // It is now not displaying my name
    }
  }

  if (mouseX >= width/2 - 176 && mouseX <= width/2 - 176 + 52 && mouseY >= 10 && mouseY <= 40) { // Pause button
    if (paused == false) { // If the sketch isn't paused
      noLoop(); // Stop the sketch from looping
      cursor(ARROW); // Change the cursor to an arrow
      paused = true;
    } else { // If the sketch is already paused
      loop(); // Enable loop once again
      cursor(HAND); // Change the cursor back to the hand
      dotOpacity = storeOpacity;
      pauseText = "Pause";
      paused = false;
    } // End of else statement
  } // End of mouseX and mouseY if statement
} // End of mouseReleased()

void keyReleased() { // Key released events 
  if (showInstructions == true) {
    showInstructions = false;
    
    fill(255);
    rect(0, 0, width, height);
  }

  if (showInstructions == true) return;
  
  // The following lines of code checks for if the user has pressed the number keys, and add the values that are correspondent to the number keys
  if (key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' || key == '0') {
    if (receivingRgbInput == true) {
      if (currentInput == 1) {
        if (key == '1' && userInputR + 1 <= 255) {
          userInputR += 1;
        } else if (key == '2' && userInputR + 2 <= 255) {
          userInputR += 2;
        } else if (key == '3' && userInputR + 3 <= 255) {
          userInputR += 3;
        } else if (key == '4' && userInputR + 4 <= 255) {
          userInputR += 4;
        } else if (key == '5' && userInputR + 5 <= 255) {
          userInputR += 5;
        } else if (key == '6' && userInputR + 6 <= 255) {
          userInputR += 6;
        } else if (key == '7' && userInputR + 7 <= 255) {
          userInputR += 7;
        } else if (key == '8' && userInputR + 8 <= 255) {
          userInputR += 8;
        } else if (key == '9' && userInputR + 9 <= 255) {
          userInputR += 9;
        } else if (key == '0' && userInputR + 10 <= 255) {
          userInputR += 10;
        }
        dotColor1 = userInputR;
      } else if (currentInput == 2) {
        if (key == '1' && userInputG + 1 <= 255) {
          userInputG += 1;
        } else if (key == '2' && userInputG + 2 <= 255) {
          userInputG += 2;
        } else if (key == '3' && userInputG + 3 <= 255) {
          userInputG += 3;
        } else if (key == '4' && userInputG + 4 <= 255) {
          userInputG += 4;
        } else if (key == '5' && userInputG + 5 <= 255) {
          userInputG += 5;
        } else if (key == '6' && userInputG + 6 <= 255) {
          userInputG += 6;
        } else if (key == '7' && userInputG + 7 <= 255) {
          userInputG += 7;
        } else if (key == '8' && userInputG + 8 <= 255) {
          userInputG += 8;
        } else if (key == '9' && userInputG + 9 <= 255) {
          userInputG += 9;
        } else if (key == '0' && userInputG + 10 <= 255) {
          userInputG += 10;
        }
        dotColor2 = userInputG;
      } else if (currentInput == 3) {
        if (userInputB < 255) {
          if (key == '1' && userInputB + 1 <= 255) {
            userInputB += 1;
          } else if (key == '2' && userInputB + 2 <= 255) {
            userInputB += 2;
          } else if (key == '3' && userInputB + 3 <= 255) {
            userInputB += 3;
          } else if (key == '4' && userInputB + 4 <= 255) {
            userInputB += 4;
          } else if (key == '5' && userInputB + 5 <= 255) {
            userInputB += 5;
          } else if (key == '6' && userInputB + 6 <= 255) {
            userInputB += 6;
          } else if (key == '7' && userInputB + 7 <= 255) {
            userInputB += 7;
          } else if (key == '8' && userInputB + 8 <= 255) {
            userInputB += 8;
          } else if (key == '9' && userInputB + 9 <= 255) {
            userInputB += 9;
          } else if (key == '0' && userInputB + 10 <= 255) {
            userInputB += 10;
          }
          dotColor3 = userInputB;
        }
      }
    }
  }

  if (key == ',') { // When the user wants to proceed to the next RGB value
    if (receivingRgbInput == true) { // If the program is receiving input...
      if (currentInput < 3) { // If the current input position is on R or G 
        currentInput++; // Add 1 to the input position so that the user proceeds to the next RGB value
      }
    }
  }

  if (keyCode == ENTER || keyCode == RETURN) { // When the user presses the enter key
    if (receivingRgbInput == true) { // If the program is receiving input
      if (userInputR == 0 && userInputG == 0 && userInputB == 0) { // If the user hasn't inputted any values
        randomColor = true; // This is then a random color
        dotColor1 = int(random(255)); // Picks three random values for the brush color
        dotColor2 = int(random(255));
        dotColor3 = int(random(255));
        receivingRgbInput = false; // The program is no longer receiving input
      } else { // If the user has inputted some values
        randomColor = true; // Technically this isn't a "random" color, but this is for the sake of simplicity so that another boolean value doesn't have to be used
        dotColor1 = userInputR; // Update brush colors to the user's desired color
        dotColor2 = userInputG;
        dotColor3 = userInputB;
        receivingRgbInput = false; // The program is no longer receiving input
      }
      textColorR = dotColor1; // Updates display bar values
      textColorG = dotColor2;
      textColorB = dotColor3;
    } 

    userInputR = 0; // Sets the user input values to 0 so that they can start fresh if they want a new color
    userInputG = 0;
    userInputB = 0;

    rgbColor = "RGB Color: "; // Update the text displayed to the user so it's no longer a prompt
  } 

  if (key == 'R' || key == 'r') { // If the user has pressed the r/R key
    fill(255); // Reset the sketch (you can find detailed comments in the part where the user presses the reset button)
    rect(0, 0, width, height);
    whiteBlack = 255;
    buttonStroke = 255;
    dotColor1 = 0;
    dotColor2 = 0;
    dotColor3 = 0;
    dotOpacity = 255;
    storeOpacity = 255;
    storeDotR = dotColor1;
    storeDotG = dotColor2;
    storeDotB = dotColor3;
    textColorR = 0;
    textColorG = 0;
    textColorB = 0;
    dotSize = 20;
    storeDotSize = 20;
    receivingRgbInput = false;
    eraser = false;
    eraserMode = "Off";
    rgbColor = "RGB Color: ";
    userInputR = 0;
    userInputG = 0;
    userInputB = 0;
  }

  if (key == 'e' || key == 'E') { // If the user presses the e/E key
    rgbInput = dotColor1 + ", " + dotColor2 + ", " + dotColor3;
    if (eraser == false) { // Turns on eraser (you can find detailed comments in the part where the user presses the eraser button)
      whiteBlack = 255;
      buttonStroke = 255;
      eraser = true;
      eraserMode = "On";
      textColorR = 0;
      textColorG = 0;
      textColorB = 0;
      dotColor1 = 255;
      dotColor2 = 255;
      dotColor3 = 255;
      dotOpacity = 255;
      dotSize = 20;
    } else {
      dotColor1 = storeDotR;
      dotColor2 = storeDotG;
      dotColor3 = storeDotB;
      dotOpacity = storeOpacity;
      dotSize = storeDotSize;
      if (dotColor1 >= 80 && dotColor2 >= 50 && dotColor3 >= 50) {
        whiteBlack = 0;
        buttonStroke = 0;
      } else {
        whiteBlack = 255;
        buttonStroke = 255;
      }
      textColorR = storeDotR;
      textColorG = storeDotG;
      textColorB = storeDotB;
      eraser = false;
      eraserMode = "Off";
    }
  }

  if (key == 'p' || key == 'P') { // Checks for the p/P key being pressed
    if (paused == false) { // Pauses the sketch (you can find detailed comments in the part where the user presses the pause button)
      noLoop();
      cursor(ARROW);
      paused = true;
    } else {
      loop();
      pauseText = "Pause";
      paused = false;
    }
  }
}
