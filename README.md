# Gradient shaders
This repository contains the code used in gradient shader series of tutorials.

## Two-color gradient
YouTube: [Unity shader stories - Creating a two colour gradient](https://youtu.be/15HoENdhXlM)

Create a two-colour gradient using the UV coordinates by assigning colours to each vertex. 
This enables the fragment shader to automatically interpolate the colours of the gradient for us.

Related files:
- VerticalGradient.shader
- AnimateGradient.cs

## Three-color gradient
YouTube: [Unity shader stories - Creating a two colour gradient](https://youtu.be/15HoENdhXlM)

Create a three-colour gradient using the UV coordinates by creating a fragment shader that applies the correct linear interpolation depending on which part of the gradient we are in (thus which two colours we should be interpolating).

Related files:
- TripleVerticalGradient.shader
