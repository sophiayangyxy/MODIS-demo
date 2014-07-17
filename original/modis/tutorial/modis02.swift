type imagefile;
type landuse;
type getscript;

app (landuse output) getLandUse (imagefile input, getscript script)
{
  bash filename(script) filename(input) stdout=filename(output);
}

# Constants and command line arguments
int nFiles       = toInt(arg("nfiles", "1000"));
string MODISdir  = arg("modisdir", "../data/");

# Input Dataset
imagefile geos[] <ext; exec="../bin/modis.mapper", location=MODISdir, suffix=".rgb", n=nFiles>;

# Compute the land use summary of each MODIS tile
landuse land[] <structured_regexp_mapper; source=geos, match="(h..v..)", transform=strcat("landuse2/\\1.landuse.byfreq")>;

getscript script<"../bin/getlanduse.sh">;

foreach g,i in geos {
    land[i] = getLandUse(g, script);
}

