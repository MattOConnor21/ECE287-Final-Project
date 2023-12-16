# ECE287-Final-Project
Piano Tile game on DE2-112

## Overview
This repository contains the Verilog code for a Piano Tile game implemented on an FPGA board. The game involves notes falling from the top of the screen, and the player scores points by pressing a button when the note aligns with a horizontal line at the bottom.

## Problem Description
The goal of this project is to create an interactive game on an FPGA board using Verilog. The game features falling notes, user input from buttons, a scoring mechanism using the seven-segment display, and a complex FSM with multiple states. Note that there is a known issue with the scoring mechanism, where the imperfect input of the button can lead to multiple score increments for each tick (50MHz) the button is held down.

## Background Information
Understanding the Verilog code is essential for anyone intending to use or extend this project. The project includes modules for VGA display, game control, scoring, and synchronization with user input. The game's state machine transitions through idle, drawing, playing, erasing, and updating phases.

## Design Description
Let's break down the main Verilog modules:

# final_project_main
This is the top-level module that integrates all the essential components of the game. It brings together the display, control, and scoring aspects. The game's state machine manages transitions between drawing, playing, erasing, and updating phases.

# final_project_vga_controller
This module handles the VGA (Video Graphics Array) controller, generating signals needed for the display. VGA is a standard for interfacing computers with monitors, and in this case, it helps render the falling blocks on the screen. Special thanks to Jeremy Scott for providing the VGA display code.

# final_project_points
Responsible for managing the scoring logic based on user input and block positions. The module keeps track of the score, and there's a known issue here: pressing the button might lead to multiple score increments due to imperfect button input.

# final_project_main_control
This module oversees the game's control, managing state transitions. The game goes through drawing, playing, erasing, and updating phases, depending on user input and the current state.

# final_project_seven_seg
This module handles the display of the score on a seven-segment display. It breaks down the score into individual digits to showcase it visually.

# final_project_display
A module that combines the VGA display, scoring, and control. It ensures that the falling blocks are accurately displayed on the screen and responds to user input.

The scoring mechanism has a known issue where multiple score increments can occur if the button is held down for more than 1 tick (50MHz).

## Results
The game successfully runs on the FPGA board, providing an interactive experience for the player. The VGA display accurately renders falling notes, and the scoring system responds to timely button presses.

## Conclusion
Despite the known issue with the scoring mechanism, the project demonstrates the implementation of a falling notes game using Verilog on an FPGA. The modular design allows for easy understanding and potential extensions. Further improvements could address the scoring issue and enhance the game dynamics.

## Media
![Gameplay Screenshot](Falling_Notes.jpg)
*Caption: A screenshot demonstrating the gameplay of the falling notes game.*

**Demo Video**: https://youtube.com/shorts/JPL5mak56ks?feature=shared

## Video Description
As seen in the video the game is resting in an IDLE phase until switches 0 and 1 are turned on and then notes begin to fall. When the buttons corresponding to the displayed row are pressed as the note falls on the horizontal line the score is incremented. Finally, the reset feature is shown as switch 4 is turned on and then off. After being reset, the FSM continues to work as intended.

## Citations
The project utilizes standard Verilog constructs and FPGA board-specific modules. Credit goes to Huan Dang for the VGA display code, which greatly contributed to the project.

For any specific code credits or external references, provide links to the relevant sources in this section.

Feel free to contact the project contributors for any questions or collaboration opportunities.


