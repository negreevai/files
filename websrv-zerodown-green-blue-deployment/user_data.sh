#!/bin/bash
yum -y update
yum -y install httpd


cat <<EOF > /var/www/html/index.html
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Document</title>
  </head>
  <body>
      <header>
      <br>  Owner ${f_name} ${l_name} <br>

%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{endfor ~}


          <div class="mainmenu-area" data-spy="affix" data-offset-top="205">
              <div class="container">
                  <div class="mainmenu-row">
                      <!-- Site-Logo-Start -->
                      <div class="site-logo">
                          <!-- Text-Logo-Markup -->
                          <h2 class="logo-text"><a href="#">NOVACUTAN</a></h2>
                      </div>
                      <!-- Site-Logo-End -->
                      <!-- Primary-Menu-Start -->
                      <nav class="primary-menu" id="mainmenu">
                          <ul class="nav">
                              <!-- <li><a href="#home-section">ГЛАВНАЯ</a></li> -->
                              <li><a href="#tutorial-section">УНИКАЛЬНОСТЬ</a></li>
                              <li><a href="#factors">ФАКТОРЫ СТАРЕНИЯ</a></li>
                              <li><a href="#product-area">ПРОДУКТЫ</a></li>
                              <li><a href="#gallery-section">ГАЛЕРЕЯ</a></li>
                              <!-- <li><a href="#price-section">ЦЕНЫ</a></li> -->
                              <li><a href="#contact-section">КОНТАКТЫ</a></li>
                          </ul>
                      </nav>

                      <!-- Mobile-Menu-Tigger-Button -->
                      <div class="toggle-menu">
                          <button type="button" class="navi-trigger" >
                              <span class="bar"></span>
                              <span class="bar"></span>
                              <span class="bar"></span>
                          </button>
                      </div>
                  </div>
              </div>
          </div>
      </header>
  </body>
  </html>

EOF

sudo service httpd start
chkconfig httpd on
