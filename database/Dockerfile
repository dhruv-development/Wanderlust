FROM mongo

WORKDIR /data/db

# Copy data folder containing JSON file
COPY sample_posts.json /data/sample_posts.json

# Run MongoDB and import data
CMD ["sh", "-c", "mongod --bind_ip_all & sleep 5 && mongoimport --db wanderlust --collection posts --file /data/sample_posts.json --jsonArray && tail -f /dev/null"]
