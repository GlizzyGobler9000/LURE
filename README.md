# LURE
A lua library for making text based displays

LURE - V1.0.0 - GlizzyGobbler9000


-------------------------------- LURE DOCUMENTATION --------------------------------


The lure library is for creating text based displays.

Lure contains 3 parts.
The world, the window, and functions for interaction with the former.

--------------------------------------------------------------------------------------------------------------------

The world contains classes and objects, where you can put objcets inside a class.
Has no functions, and is simply a container.

--------------------------------------------------------------------------------------------------------------------

The window/display of lure

1. The size of the window - Table

    > The width and height of the window
    Contains:
        1. width - Number
        2. height - Number

    > Must be an integer

2. The title of the project - String

    > Text displayed on the top left of the display

3. sleep() - Function

    > Stops execution for the inputed time in millseconds

    > Inputs:
        1. milliseconds - Number

    > Returns: nothing

4. clear()

    > Clears the console of all text

    > Inputs: nothing

    > Returns: nothing

5. draw()

    > Draws a grid with a base of '_', with '  ' as spacing. All objects and objects in classes with show set to true are outputed here. Uses the window's width and height as size.

    > Inputs: nothing

    > Returns: nothing

--------------------------------------------------------------------------------------------------------------------

The functions used for controling the lure world.

1. addObject()
2. addClass()
3. moveObjectToClass()
4. removeClass()
5. removeObject()
6. getObject()
7. getClass()
