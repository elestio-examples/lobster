sed -i "s~<nobody@#{Rails.application.domain}>~ENV.fetch("SMTP_SENDER", "")~g" ./app/mailers/ban_notification.rb
sed -i "s~<nobody@#{Rails.application.domain}>~ENV.fetch("SMTP_SENDER", "")~g" ./app/mailers/application_mailer.rb
sed -i "s~<nobody@#{Rails.application.domain}>~ENV.fetch("SMTP_SENDER", "")~g" ./script/mail_new_activity.rb

docker buildx build . --output type=docker,name=elestio4test/lobster:latest | docker load