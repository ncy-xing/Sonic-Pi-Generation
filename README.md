# Sonic-Pi-Generation

## Description
This project is a 5-minute music piece titled *Snowdrops*. It was composed and generated in Sonic Pi, a Ruby-based musical software. You can listen to the piece by cloning the repository and playing the `audio.wav` file. 

## Methodology 
*Snowdrops* was created for the Computational Creativity course at Bowdoin College. The task was to create a piece to be heard by Data Structures students which is suitable for focus or studying. 

When designing this song, I was inspired by several video game soundtracks I often listen to while studying (see the `brainstorming` file). Unlike typical lo-fi or chill synths used for studying, video game tracks tend to be upbeat and more stimulating. The challenge was to compose a vibrant and interesting piece resembling a video game track while avoiding making the piece too overwhelming and not suitable for studying. In the end, I used the tempo, design structure, and layering of the inspiring video game tracks to inform the creation of *Snowdrops*. 

*Snowdrops* employs two key features: gradually introducing various sound layers, and randomly generating sound layers. Each sound layer is a simple melody in the key of D minor drafted in Musescore. The layer's notes and rythmic structure were transcribed into Sonic Pi, and synth and relative volume were assigned for each layer. After playing a brief opening, *Snowdrops* introduces gradually builds itself by playing one new layer on top of the previous layer at a time. This allows both predictability (as the previous layers continue playing) and interest (as new layers emerge and build up the narrative). In the middle segment, the script randomly generates two such layers by selecting notes (including rests) from previous layers. This is then played on top of previous layers. 
