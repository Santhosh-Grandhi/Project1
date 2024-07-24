source CommonFile.sh
rm -f /tmp/expense.log

if [ -z "$1" ]; then
  echo "Input Missing"
  exit 2
fi

Heading "Disable Nodejs"
dnf module disable nodejs -y
STAT $?

Heading "Enable NodeJS 20 Version"
dnf module enable nodejs:20 -y
STAT S?

Heading "Install Node JS 20 Version"
dnf install nodejs -y
STAT $?

Heading "Add Expense User"
id expense
if [ $? -ne 0 ]; then
  useradd expense
fi
STAT $?

Heading "Setup Backend Service"
cp backend.service /etc/systemd/system/backend.service
STAT $?

Heading "Remove Existing Application Directory"
rm -rf /app
STAT $?

Heading "Create an Application Directory"
mkdir /app
STAT $?

Heading "Download backend content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip
STAT $?

cd /app

Heading "Unzip backend file"
unzip /tmp/backend.zip
STAT $?

Heading "Install Nodejs dependencies"
npm install
STAT $?

Heading "Install MYSQL Client"
dnf install mysql -y
STAT $?

Heading "Load Schema"
mysql -h "MYSQL-SERVER-IPADDRESS" -uroot -p$1 < /app/schema/backend.sql
STAT $?

Heading "enable and start back-end service"
systemctl enable backend
systemctl start backend
STAT s?

Heading "Deamon Reload"
systemctl daemon-reload
STAT $?
