source CommonFile.sh

Heading "Installing Ngnix"
dnf install nginx -y
STAT $?

Heading "Enable and start Ngnix"
systemctl enable nginx
systemctl start nginx
STAT $?

Heaing "Copy Expense file"
cp expense.conf /etc/nginx/default.d/expense.conf
STAT $?

Heading "Remove default content"
rm -rf /usr/share/nginx/html/*
STAT $?

Heading "Download Frontend content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
cd /usr/share/nginx/html
STAT $?

Heading "Unzip content"
unzip /tmp/frontend.zip
STAT $?

Heading "Restart Ngnix"
systemctl restart nginx
STAT $?