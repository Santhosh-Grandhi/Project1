source CommonFile.sh

Heading "Installing Ngnix"
dnf install nginx -y

Heading "Enable and start Ngnix"
systemctl enable nginx
systemctl start nginx

Heaing "Copy Expense file"
cp expense.conf /etc/nginx/default.d/expense.conf

Heading "Remove default content"
rm -rf /usr/share/nginx/html/*

Heading "Download Frontend content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
cd /usr/share/nginx/html

Heading "Unzip content"
unzip /tmp/frontend.zip

Heading "Restart Ngnix"
systemctl restart nginx