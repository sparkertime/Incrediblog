rm output.jpg
convert -size 130x30 xc:grey30 -font Helvetica -pointsize 16 -gravity center \
        -draw "fill grey70  text 0,0  'citizenparker.com'" \
        stamp_fgnd.png
convert -size 130x30 xc:black -font Helvetica -pointsize 16 -gravity center \
        -draw "fill white  text  1,1  'citizenparker.com'  \
                           text  0,0  'citizenparker.com'  \
               fill black  text -2,-2 'citizenparker.com'  \
               fill black  text -1,-1 'citizenparker.com'" \
        +matte stamp_mask.png
composite -compose CopyOpacity  stamp_mask.png  stamp_fgnd.png  stamp.png
mogrify -trim +repage stamp.png
rm stamp_*.png
composite -gravity southeast stamp.png uwars.jpg output.jpg
open output.jpg
