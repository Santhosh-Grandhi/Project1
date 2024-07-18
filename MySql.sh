source CommonFile.sh

Heading "Install MySql Server"
dnf install mysql-server -y
STAT $?

Heading "Enable and Start MYSQL"
systemctl enable mysqld
systemctl start mysqld
STAT $?

Heading "Set MySql Password"
mysql_secure_installation --set-root-pass ExpenseApp@1
STAT $?