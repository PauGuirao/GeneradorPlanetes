# Random Planet Generator
This is a random 2D planet generator created in Processing using Java perlin noise. Moons and background can be added too
<img src="Render.jpg" alt="Example Render" width="400" height="400">
## Create Planet
Call this functions to create a random 2D planet
- radius: integer to change the planet radius
- level_1: float to change the first layer of ground altitude (recommended: > 0.5)
- level_2: float to change the second layer of ground altitude (recommended: > 0.6)
```bash
$ drawPlanet(int radius, float level_1, float level_2)
```
## Create Moon
Call this functions to add a moon to the texture
- radius:  integer to change the moon radius
- distance:  integer to change the moon distance from the planet
```bash
$ drawMoon(int radius, int distance)
```
