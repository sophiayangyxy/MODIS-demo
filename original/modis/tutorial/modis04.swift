type file;
type imagefile;
type landuse;
type getland_script;
type analyze_script;
type markmap_script;

app (landuse output) getLandUse (imagefile input, getland_script script, file rgb_script)
{
  bash filename(script) filename(input) stdout=filename(output);
}

app (file output, file tilelist) analyzeLandUse (landuse input[], string usetype, int maxnum, analyze_script script)
{
  bash filename(script) filename(output) filename(tilelist) usetype maxnum @input;
}

app (imagefile grid) markMap (file tilelist, markmap_script script, file rgbtopng_script, file world, file draw_script) 
{
  bash filename(script) @tilelist @grid;
}

# Constants and command line arguments
int nFiles       = toInt(arg("nfiles", "1000"));
int nSelect      = toInt(arg("nselect", "10"));
string landType  = arg("landtype", "urban");
string MODISdir  = arg("modisdir", "../data/modis/2002/europe");

# Input Dataset
imagefile geos[] <ext; exec="../bin/modis.mapper", location=MODISdir, suffix=".rgb", n=nFiles>;

# Compute the land use summary of each MODIS tile
landuse land[]    <structured_regexp_mapper; source=geos, match="(h..v..)", transform=strcat("landuse4/\\1.landuse.byfreq")>;

getland_script getland<"../bin/getlanduse.sh">;
analyze_script analyze<"../bin/analyzelanduse.sh">;
markmap_script markmap<"../bin/markmap.sh">;
file rgb_script<"./rgb_histogram.pl">;
file rgbtopgn_script<"../bin/rgb_to_png.py">;
file world<"../bin/world.rgb">;
file draw_script<"../bin/rgb_draw_rectangle.pl">;

foreach g,i in geos {
    land[i] = getLandUse(g, getland, rgb_script);
}

# Find the top N tiles (by total area of selected landuse types)
file topSelected <"topselected.txt">;
file selectedTiles <"selectedtiles.txt">;
(topSelected, selectedTiles) = analyzeLandUse(land, landType, nSelect, analyze);

# Mark the top N tiles on a sinusoidal gridded map
imagefile gridmap <"gridmap.png">;
gridmap = markMap(topSelected, markmap, rgbtopgn_script, world, draw_script);
