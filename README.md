## Finding the optimal area for an afforestation programme

In the state of Mato Grosso, Brazil, agricultural expansion and illegal logging are constantly threatening the Amazon rainforest. Although not frequent, afforestation programmes take place in the region from time to time. The objective here is to find an optimal area for an afforestation programme in the region, located nearby Nature reserves. Abandoned agricultural fields can be used for the plantation of new trees. However, in order to be sucessful, the programme must avoid conflicts of interest with the agribusiness. Hampering the access to the afforestation area can also help (i.e., selecting only areas far from the main roads).

The steps to find the optimal afforestation area are:
- Find regions that are within 10 km range from Nature reserves, but are 5 km away from any roads and 8 km away from Croplands.
- Moreover, to be optimal for afforestation the area has to be located in regions which are currently Abandoned fields. 
- Calculate the area of optimal region polygon(s).
- Export the resulting polygon(s) as GeoJSON file(s).

### Data
- Data can be found here (https://www.dropbox.com/sh/4n2ifcpg0wy766e/AADYNljpqwZWngzucgsoSYt1a?dl=0).
- `MS_land_cover.geojson` is a land cover map of the state of Mato Grosso.
- `MS_roads.geojson` contains the main roads of Mato Grosso.

### Processes
- The data was downloaded in the script, and saved in a folder called `data`.
- The buffers were created with a function `createBuffer`, and placed in a file called `createBuffer.R`.
- The optimal area was assigned to the variable `opt_area`, in km². The result was rounded up, leaving no decimal places.
- The resulting polygon(s) were saved in a folder called `output`, as `afforestation_area.geojson`.


### Bonus
The polygon with the optimal region on top of the map of Mato Grosso was plotted, making it possible to tell in which region of the state this area is located. 

- Export the resulting map to a folder called `output`, as `afforestation_map.png`
- To highlight the optimal area, the color scheme of the background map was changed.



