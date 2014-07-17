type imagefile;
type landuse;
type get_script;

app (landuse output) getLandUse (imagefile input, get_script script)

{
  bash filename(script) filename(input) stdout=filename(output);
}

// imagefile modisImage <"data/europe/h18v05.rgb">;
imagefile modisImage<"../data/h00v08.rgb">;
// landuse result <"landuse/h18v05.landuse.byfreq">;
landuse result <"landuse/h00v08.landuse.byfreq">;
get_script script<"../bin/getlanduse.sh">;

result = getLandUse(modisImage, script);