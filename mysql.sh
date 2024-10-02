source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo Input Password is missing
  exit 1
fi

Print_Task_Heading "Install Mysql Server"
dnf install mysql-server -y &>>$LOG
Check_Status $?

Print_Task_Heading "Start Mysql Server"
systemctl enable mysqld &>>$LOG
systemctl start mysqld &>>$LOG
Check_Status $?

Print_Task_Heading "Setup Mysql Password"
echo 'show databases' | mysql -h 172.31.87.179 -uroot -p${mysql_root_password} &>>LOG
if [ $? -ne 0 ]; then
  mysql_secure_installation --set-root-pass ${mysql_root_password}  &>>$LOG
fi
Check_Status $?