#! /usr/bin/env fish

# Legal characters in filenames
set -l legal '[:alnum:] '

inotifywait -m --format '%w%f' -e create -e moved_to $argv \
| while read file
    switch $file
        case '*.jpg' '*.JPG'
            true
        case '*'
            # Not a JPEG
            continue
    end

    # Make the watched file read-only.
    chmod a-w $file

    set -l datetime (exif -t DateTimeOriginal -m $file | tr -cd $legal | tr ' ' '_')
    if test -z $datetime
        echo >&2 'DateTime unset:' $file
        continue
    end

    # Determine where to move the watched file.
    set -l model (exif -t Model -m $file | tr -cd $legal)
    if test -z $model
        set -l model 'Unknown'
    end

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
