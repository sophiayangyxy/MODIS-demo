type file;
type imagefile;
type landuse;
type getland_script;
type analyze_script;

app (landuse output) getLandUse (imagefile input, getland_script script, file rgb_script)
{
  bash filename(script) filename(input) stdout=filename(output);
}

app (file output, file tilelist, file error) analyzeLandUse (landuse input[], string usetype, int maxnum, analyze_script script)
{
  bash filename(script) @output @tilelist usetype maxnum @input stderr=filename(error);
}

# Constants and command line arguments
int nFiles       = toInt(arg("nfiles", "1000"));
int nSelect      = toInt(arg("nselect", "10"));
string landType  = arg("landtype", "urban");
string MODISdir  = arg("modisdir", "../data");

# Input Dataset
imagefile geos[] <ext; exec="../bin/modis.mapper", location=MODISdir, suffix=".rgb", n=nFiles>;

# Compute the land use summary of each MODIS tile
landuse land[] <structured_regexp_mapper; source=geos, match="(h..v..)", transform=strcat("landuse3/\\1.landuse.byfreq")>;

getland_script getland<"../bin/getlanduse.sh">;
analyze_script analyze<"../bin/analyzelanduse.sh">;
file rgb_his<"./rgb_histogram.pl">;

foreach g,i in geos {
    land[i] = getLandUse(g, getland, rgb_his);
}

file error<"./errorinfo">;

# Find the top N tiles (by total area of selected landuse types)
file topSelected <"topselected.txt">;
file selectedTiles <"selectedtiles.txt">;
(topSelected, selectedTiles, error) = analyzeLandUse(land, landType, nSelect, analyze);
