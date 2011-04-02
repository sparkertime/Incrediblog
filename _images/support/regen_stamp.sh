convert -size 130x30 xc:grey30 -font Helvetica -pointsize 16 -gravity center \
        -draw "fill grey10  text 0,0  'spparker.com'" \
        stamp_fgnd.png
convert -size 130x30 xc:black -font Helvetica -pointsize 16 -gravity center \
        -draw "fill white  text  1,1  'spparker.com'  \
                           text  0,0  'spparker.com'  \
               fill black  text -1,-1 'spparker.com'" \
        +matte stamp_mask.png
composite -compose CopyOpacity  stamp_mask.png  stamp_fgnd.png  stamp.png
mogrify -trim +repage stamp.png
rm stamp_*.*
