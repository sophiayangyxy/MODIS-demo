type imagefile;
type landuse;

app (landuse output) getLandUse (imagefile input)
{
  getlanduse filename(input) stdout=filename(output);
}

// imagefile modisImage <"data/europe/h18v05.rgb">;
imagefile modisImage<"../data/modis/2002/h00v08.rgb">;
// landuse result <"landuse/h18v05.landuse.byfreq">;
landuse result <"landuse/h00v08.landuse.byfreq">;
result = getLandUse(modisImage);
