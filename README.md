SVGenerator
===========

SVG images generator with ocaml

This program uses Ocamllex and Ocamlyacc to build a SVG image from a text file with a specific langage.
All functions of SVG have not been implemented but this project is still in development.


Language
--------

The input file with the image source code is a simple text file but there is a precise syntaxe for the langage:

To start, you must define a block starting with the keyword "image" and a its name within quotes. After that, you have to define the size of the output file by specifying the size between parenthesis (all values are pixels). The block length is delimited by braces.

	image "Example" (200, 200) {
		//TODO
	}

In the bock, we can define various elements :

+ A description is required:

		description ("This is an exemple of source file for generation.");
	
+ A line between two dots:

		line (dot(0,0), dot(200,200)[, fill(color_name), stroke(color_name)]);

+ A circle with a dot which represents its center and its radius:

		circle (dot(50,150), radius(50)[, fill(color_name), stroke(color_name)]);

+ A rectangle defined by a starting dot and an ending dot:

		rectangle (dot(50,50), dot(100,100)[, fill(color_name), stroke(color_name)]);
	
+ A text with a starting dot and several optional attributes (police, size,...):
	
		text ("This image is a test", dot(20,70)[, police, 40, fill(color_name), stroke(color_name)]);

+ A polygon defined by some dots:

		polygon (dot(60,80), dot(50,30)[, dot(100,90),...] [,  fill(color_name), stroke(color_name)]);
	
For all these shapes, you can specify colors (optional).

You can also add comments at the end of the instruction like that:

		description ("Text");// Example of endline comment
