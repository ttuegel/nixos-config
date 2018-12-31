#! /usr/bin/env fish

inotifywait -m --format '%w%f' -e create -e move_to $argv 2>/dev/null | while read file
    if not exif -m $file >/dev/null 2>&1
        echo >&2 'No EXIF data:' $file
        continue
    else
        echo >&2 'Found EXIF data:' $file
    end

    set -l model (exif -t Model -m $file)
    set -l datetime (exif -t DateTime -m $file | tr -d ':' | tr ' ' '_')
    set -l uniqueness (printf '%03u' (count $model/$datetime'_'*'.jpg'))
    set -l newfile $model/$datetime'_'$uniqueness'.jpg'
    if test -f $newfile
        echo >&2 'Could not rename' $file 'to' $newfile ': file exists'
    else
        mkdir -p $model
        echo >&2 'mv' $file $newfile
        mv $file $newfile
    end
end
