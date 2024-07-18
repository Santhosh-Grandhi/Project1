source CommonFile.sh
rm -f /tmp/expense.log

Heading "Installing Ngnix"
dnf install nginx -y &>> /tmp/expense.log
STAT $?

Heading "Enable and start Ngnix"
systemctl enable nginx &>> /tmp/expense.log
systemctl start nginx &>> /tmp/expense.log
STAT $?

Heading "Copy Expense file"
cp expense.conf /etc/nginx/default.d/expense.conf &>> /tmp/expense.log
STAT $?

Heading "Remove default content"
rm -rf /usr/share/nginx/html/* &>> /tmp/expense.log
STAT $?

Heading "Download Frontend content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>> /tmp/expense.log
cd /usr/share/nginx/html &>> /tmp/expense.log
STAT $?

Heading "Unzip content"
unzip /tmp/frontend.zip &>> /tmp/expense.log
STAT $?

Heading "Restart Ngnix"
systemctl restart nginx &>> /tmp/expense.log
STAT $?