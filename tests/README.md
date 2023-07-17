<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Lobster, verified and packaged by Elestio

A better community platform for the modern web.

[Lobster](https://lobste.rs/) It is a Rails codebase and uses a SQL (MariaDB in production) backend for the database.

Deploy a <a target="_blank" href="https://elest.io/open-source/lobster">fully managed Lobster</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

<img src="https://github.com/elestio-examples/lobster/raw/main/lobster.png" alt="lobster" width="800">

[![deploy](https://github.com/elestio-examples/lobster/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/lobster)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/lobster.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    mkdir -p ./db-data
    chmod 777 ./db-data

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:3020`

The defaults credential for admin will be:

    username: test
    password: test

Don't forget to change them.

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"

    services:
        lobster-db:
            image: elestio/mysql:latest
            restart: always
            command: mysqld --default-authentication-plugin=mysql_native_password --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --max_connections=1000   --gtid-mode=ON --enforce-gtid-consistency=ON
            environment:
                MYSQL_ROOT_PASSWORD: ${ADMIN_PASSWORD}
                MYSQL_DATABASE: lobster
            ports:
                - "172.17.0.1:3306:3306"
            volumes:
                - ./db-data:/var/lib/mysql

        lobster:
            image: elestio4test/lobster:${SOFTWARE_VERSION_TAG}
            restart: always
            ports:
                - "172.17.0.1:3020:3000"
            environment:
                DATABASE_URL: "mysql2://root:${ADMIN_PASSWORD}@lobster-db:3306/lobster"
                RAILS_ENV: production
                RACK_ENV: production
                RAILS_SERVE_STATIC_FILES: "true"
                APP_DOMAIN: ${DOMAIN}
                APP_NAME: ${APP_NAME}
                SECRET_KEY_BASE: ${SECRET_KEY_BASE}
                X_SENDFILE_HEADER: ""
                SMTP_HOST: ${SMTP_HOST}
                SMTP_PORT: ${SMTP_PORT}
                SMTP_STARTTLS_AUTO: "false"
                SMTP_USERNAME: ${SMTP_USERNAME}
                SMTP_PASSWORD: ${SMTP_PASSWORD}
                SMTP_SENDER: ${SMTP_SENDER}
            depends_on:
                - lobster-db

### Environment variables

|       Variable       |        Value (example)         |
| :------------------: | :----------------------------: |
| SOFTWARE_VERSION_TAG |             latest             |
|    ADMIN_PASSWORD    |         your-password          |
|       APP_NAME       |            Lobster             |
|     ADMIN_EMAIL      |         your@email.com         |
|        DOMAIN        |          your.domain           |
|      SMTP_HOST       |           172.17.0.1           |
|      SMTP_PORT       |               25               |
|    SMTP_USERNAME     |         user@mail.com          |
|    SMTP_PASSWORD     |         your-password          |
|     SMTP_SENDER      |        sender@mail.com         |
|   SECRET_KEY_BASE    | 128-characters-long-secret-key |

# Maintenance

## Logging

The Elestio Lobster Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/Lobster/Lobster">Lobster Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/lobster">Elestio/lobster Github repository</a>
