set -o allexport; source .env; set +o allexport;

echo "Waiting for the software to be ready..."
sleep 90s;

docker-compose exec -T lobsters bash << EOF
rails console
user = User.find_by(username: "test")
user.password = "${ADMIN_PASSWORD}"
user.password_confirmation = "${ADMIN_PASSWORD}"
user.email = "${ADMIN_EMAIL}"
user.username = "admin"
user.save
EOF
