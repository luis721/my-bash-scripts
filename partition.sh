# Partitions a mp4 file in parts of the same length.
# Call example:
# ./partition.sh ./movie 5
# this will partition the file movie.mp4 in 5 parts of same length

file=$1;
parts=$2;

total=$(ffprobe -i $file.mp4 -show_entries format=duration -v quiet -of csv="p=0")
total=$( printf "%.0f" $total )

step=$((total/parts))

start=0

echo Partitioning and compressing file
for ((i = 1; i <= $parts; i++));
do
	# --
	echo Part ${i}
	part=${file}-part${i}.mp4
	ffmpeg -i $file.mp4 -ss $start -t $step $part
done

echo Done
