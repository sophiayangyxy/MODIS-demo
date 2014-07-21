type imagefile;
type landuse;
type get_script;
type file;

app (landuse output) getLandUse (imagefile input, get_script script, file rgb_script)
{
  bash filename(script) filename(input) stdout=filename(output);
}

// imagefile modisImage <"data/europe/h18v05.rgb">;
imagefile modisImage<"../data/h00v08.rgb">;
// landuse result <"landuse1/h18v05.landuse.byfreq">;
landuse result <"landuse1/h00v08.landuse.byfreq">;
get_script script<"../bin/getlanduse.sh">;
file rgb_script<"./rgb_histogram.pl">;

result = getLandUse(modisImage, script, rgb_script);