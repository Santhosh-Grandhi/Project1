source CommonFile.sh
rm -f /tmp/expense.log

if [ -z "$1" ]; then
  echo "Input is missing"
  exit 1
fi

Heading "Install MySql Server"
dnf install mysql-server -y &>> /tmp/expense.log
STAT $?

Heading "Enable and Start MYSQL"
systemctl enable mysqld &>> /tmp/expense.log
systemctl start mysqld &>> /tmp/expense.log
STAT $?

Heading "Set MySql Password"
mysql_secure_installation --set-root-pass $1 &>> /tmp/expense.log
STAT $?