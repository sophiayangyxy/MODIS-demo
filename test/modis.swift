type imagefile;
type landuse;

app (landuse output) getLandUse (imagefile input)
{
  getlanduse filename(input) stdout=filename(output);
}

int nFiles       = toInt(arg("nfiles", "1000"));
string MODISdir  = arg("modisdir", "modis-2002/");

imagefile geos[] <ext; exec="bin/modis.mapper", location=MODISdir, suffix=".modis", n=nFiles>;

landuse land[] <structured_regexp_mapper; source=geos, match="(h..v..)", transform=strcat("landuse/\\1.landuse.byfreq")>;

foreach g,i in geos {
    land[i] = getLandUse(g);
}