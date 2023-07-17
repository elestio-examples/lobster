set -o allexport; source .env; set +o allexport;

echo "Waiting for the software to be ready..."
sleep 90s;

docker-compose exec -T lobster bash << EOF
rails console
user = User.find_by(username: "test")
user.password = "${ADMIN_PASSWORD}"
user.password_confirmation = "${ADMIN_PASSWORD}"
user.email = "${ADMIN_EMAIL}"
user.save!
EOF

docker-compose exec -it lobster-db bash << EOF
mysql -u root lobster -p${ADMIN_PASSWORD};
UPDATE users SET username = 'admin' WHERE id = 2;
EOF
