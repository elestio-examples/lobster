#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./db-data
chmod 777 ./db-data

SECRET_KEY_BASE=${SECRET_KEY_BASE:-`openssl rand -hex 64`}

cat /opt/elestio/startPostfix.sh > post.txt
filename="./post.txt"

SMTP_HOST=""
SMTP_PORT=""
SMTP_USERNAME=""
SMTP_PASSWORD=""
SMTP_SENDER=""

# Read the file line by line
while IFS= read -r line; do
  # Extract the values after the flags (-e)
  values=$(echo "$line" | grep -o '\-e [^ ]*' | sed 's/-e //')

  # Loop through each value and store in respective variables
  while IFS= read -r value; do
    if [[ $value == RELAYHOST_USERNAME=* ]]; then
      SMTP_USERNAME=${value#*=}
      SMTP_SENDER=${value#*=}
    elif [[ $value == RELAYHOST_PASSWORD=* ]]; then
      SMTP_PASSWORD=${value#*=}
    elif [[ $value == RELAYHOST=* ]]; then
      IFS=":"
      read -ra array <<< "$value"
      SMTP_HOST=${value#*=}
      SMTP_HOST=${SMTP_HOST::-3}
      SMTP_PORT=${array[1]}
    fi
  done <<< "$values"

done < "$filename"

cat << EOT >> ./.env

SMTP_HOST=${SMTP_HOST}
SMTP_PORT=${SMTP_PORT}
SMTP_USERNAME=${SMTP_USERNAME}
SMTP_PASSWORD=${SMTP_PASSWORD}
SMTP_SENDER=${SMTP_SENDER}
SECRET_KEY_BASE=${SECRET_KEY_BASE}
EOT

rm post.txt