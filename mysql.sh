source common.sh

Print_Task_Heading "Install Mysql server"
dnf install mysql-server -y &>>$LOG
Check_Status $?

Print_Task_Heading "Enable and Start mysqld"
systemctl enable mysqld &>>$LOG
systemctl start mysqld &>>$LOG
Check_Status $?

Print_Task_Heading "Secure Installation"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG
Check_Status $?