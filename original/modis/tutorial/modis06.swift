type file;
type imagefile;
type landuse;

app (landuse output) getLandUse (imagefile input, file getland_script, file rgb_script)
{
  bash filename(getland_script) filename(input) stdout=filename(output);
}

app (file output, file tilelist) analyzeLandUse (landuse input[],
string usetype, int maxnum, file analyze_script)
{
  bash filename(analyze_script) @output @tilelist usetype maxnum @input;
}

app (imagefile grid) markMap (file tilelist, file markmap_script, file
rgbtopgn_script, file world, file draw_script) 
{
  bash filename(markmap_script) @tilelist @grid;
}

app (imagefile output) colorModis (imagefile input, file color_script,
file adjust_script, file down_script)
{
  bash filename(color_script) @input @output;
}

app (imagefile mon) assemble (imagefile images[], file assemble_script, file montage_script, file rgbtopng_script)
{
   bash filename(assemble_script) filename(mon) filenames(images);
}

# Constants and command line arguments
int nFiles       = toInt(arg("nfiles", "1000"));
int nSelect      = toInt(arg("nselect", "10"));
string landType  = arg("landtype", "urban");
string MODISdir  = arg("modisdir", "../data");

# Input Dataset
imagefile geos[] <ext; exec="../bin/modis.mapper", location=MODISdir, suffix=".rgb", n=nFiles>;

# Compute the land use summary of each MODIS tile
landuse land[]    <structured_regexp_mapper; source=geos, match="(h..v..)", transform=strcat("landuse6/\\1.landuse.byfreq")>;


file getland_script<"../bin/getlanduse.sh">;
file analyze_script<"../bin/analyzelanduse.sh">;
file markmap_script<"../bin/markmap.sh">;
file color_script<"../bin/colormodis.sh">;
file rgb_script<"./rgb_histogram.pl">;
file rgbtopng_script<"../bin/rgb_to_png.py">;
file world<"../bin/world.rgb">;
file adjust<"../bin/rgb_adjust_color.pl">;
file downscale<"../bin/rgb_downscale.pl">;
file assemble_script<"../bin/assemble.sh">;
file montage_script<"../bin/montage.pl">;
file draw_script<"../bin/rgb_draw_rectangle.pl">;

foreach g,i in geos {
    land[i] = getLandUse(g, getland_script, rgb_script);
}

# Find the top N tiles (by total area of selected landuse types)
file topSelected <"topselected.txt">;
file selectedTiles <"selectedtiles.txt">;
(topSelected, selectedTiles) = analyzeLandUse(land, landType, nSelect,
analyze_script);

# Mark the top N tiles on a sinusoidal gridded map
imagefile gridmap <"gridmap.png">;
gridmap = markMap(topSelected, markmap_script, rgbtopng_script, world, draw_script);

# Create multi-color images for all tiles
imagefile colorImage[] <structured_regexp_mapper; source=geos, match="(h..v..)", transform=strcat("colorImages/\\1.color.rgb")>;

foreach g, i in geos {
  colorImage[i] = colorModis(g, color_script, adjust, downscale);
}

# Assemble a montage of the top selected areas
imagefile montage<"map.png">; # arg
montage = assemble(colorImage, assemble_script, montage_script, rgbtopng_script);

