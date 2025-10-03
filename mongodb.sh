#! /bin/bash

source ./source.sh

check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo 
VALIDATE $? "Adding mongo repo"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "Installing Mongo DB"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "Enable MONGODB"

systemctl start mongod 
VALIDATE $? "Start MongoDB"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Allowing remote connections to MongoDB"

systemctl restart mongod
VALIDATE $? "restarted MongoDB"

print_total_time