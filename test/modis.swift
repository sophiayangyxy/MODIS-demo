type imagefile;
type landuse;
type file;

app (landuse output) getLandUse (imagefile input)
{
  getlanduse filename(input) stdout=filename(output);
}

app (file output, file tilelist) analyzeLandUse (landuse input[], string usetype, int maxnum)
{
  analyzelanduse filename(output) filename(tilelist) usetype maxnum filename(input);
}

app (imagefile grid) markMap (file tilelist, file worldmap, file convert)
{
  markmap filename(tilelist) filename(grid);
}

app (imagefile output) colorModis (imagefile input)
{
	colormodis filename(input) filename(output);
}

int nFiles       = toInt(arg("nfiles", "1000"));
int nSelect      = toInt(arg("nselect", "10"));
string landType  = arg("landtype", "urban");
string MODISdir  = arg("modisdir", "modis-2002/");

imagefile geos[] <ext; exec="bin/modis.mapper", location=MODISdir, suffix=".modis", n=nFiles>;

landuse land[] <structured_regexp_mapper; source=geos, match="(h..v..)", transform=strcat("landuse/\\1.landuse.byfreq")>;

imagefile colorImage[] <structured_regexp_mapper; source=geos, match="(h..v..)", transform=strcat("colorImages/\\1.color.rgb")>;

foreach g,i in geos {
    land[i] = getLandUse(g);
    colorImage[i] = colorModis(g);
}

file topSelected <"topselected.txt">;
file selectedTiles <"selectedtiles.txt">;
(topSelected, selectedTiles) = analyzeLandUse(land, landType, nSelect);

imagefile gridmap <"gridmap.png">;
file world <"bin/world.rgb">;
file convert<"bin/rgb_to_png.py">;
gridmap = markMap(topSelected, world, convert);



















