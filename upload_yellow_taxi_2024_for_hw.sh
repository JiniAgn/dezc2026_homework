# GCP VM instance terminal
#!/bin/bash
# execute : ./upload_yellow_taxi_2024_for_hw.sh

BUCKET="gs://dezc_raw_dataset/yellow/"

for month in $(seq -w 1 6); do
  month_padded=$(printf "%02d" $month)
  FILE="yellow_tripdata_2024-${month_padded}.parquet"
  URL="https://d37ci6vzurychx.cloudfront.net/trip-data/${FILE}"

  echo "Downloading $FILE ..."
  wget -q "$URL" -O "$FILE"

  if [ -f "$FILE" ]; then
    echo "Uploading $FILE to $BUCKET ..."
    gsutil cp "$FILE" "$BUCKET"

    echo "Deleting local file $FILE ..."
    rm "$FILE"
  else
    echo "not found, skipping."
  fi
done
