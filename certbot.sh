while getopts e:d: flag
do
    case "${flag}" in
        e) email=${OPTARG};;
        d) domain=${OPTARG};;
    esac
done

if [ -z ${email+x} ]; then
    echo "Email is unset";
    exit 0
fi
if [ -z ${domain+x} ]; then
    echo "Domain is unset";
    exit 0
fi

echo "Email: $email";
echo "Domain: $domain";

docker run --rm --name temp_certbot \
    -v ./data/ssl/letsencrypt:/etc/letsencrypt \
    -v ./data/certbot/www:/tmp/letsencrypt \
    -v ./logs/certbot/log:/var/log \
    certbot/certbot:v1.8.0 \
    certonly --webroot --agree-tos --renew-by-default \
    --preferred-challenges http-01 --server https://acme-v02.api.letsencrypt.org/directory \
    --text --email $email \
    -w /tmp/letsencrypt -d $domain
