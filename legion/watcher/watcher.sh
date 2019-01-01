#! /usr/bin/env fish

inotifywait -m --format '%w%f' -e create -e moved_to $argv \
| while read file
    switch $file
        case '*.jpg' '*.JPG'
            # Check that the watched file is a JPEG image with EXIF metadata.
            if not exif -m $file >/dev/null 2>&1
                echo >&2 'No EXIF data:' $file
                continue
            else
                echo >&2 'Found EXIF data:' $file
            end
        case '*'
            # Not a JPEG
            continue
    end

    # Make the watched file read-only.
    chmod a-w $file

    # Determine where to move the watched file.
    set -l model (exif -t Model -m $file | tr -d ':/')
    set -l datetime (exif -t DateTime -m $file | tr -d ':/' | tr ' ' '_')
    set -l uniqueness (printf '%03u' (count $model/$datetime'_'*'.jpg'))
    set -l newfile $model/$datetime'_'$uniqueness'.jpg'

    if test -f $newfile
        echo >&2 'Could not rename ‘'$file'’ to ‘'$newfile'’: file exists'
    else
        mkdir -p $model
        mv $file $newfile
        echo >&2 'Moved ‘'$file'’ to ‘'$newfile'’'
    end
end
