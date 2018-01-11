require 'capybara'
session = Capybara::Session.new(:selenium)

value=ARGV[0].to_i

for counter in 0..value-1

session.visit "http://post-shift.ru/api.php?action=new"
htmlCode=session.html


htmlCode=~ /(K)(e)(y)(:)( )/
html1=Regexp.last_match.post_match
html1=~/(<)(\/)(p)(r)(e)/
htmlKey=Regexp.last_match.pre_match
#Получаем майл
htmlCode=~ /(a)(i)(l)(:)( )/
html2=Regexp.last_match.post_match
html2=~/(K)(e)(y)(:)( )/
htmlMail=Regexp.last_match.pre_match


name=htmlMail[0,8]+'random'
session.visit "https://dev.by/registration"
session.fill_in(id: 'user_username', with: name)
session.fill_in(id: 'user_email', with: htmlMail)
session.fill_in(id: 'user_password', with: "fggfg19981234")
session.fill_in(id: 'user_password_confirmation', with: "fggfg19981234")
session.check "user_agreement"
session.click_button(class: 'submit')


confirmText=" "
loop do
  url="http://post-shift.ru/api.php?action=getmail&key="+htmlKey+"&id=1"
  session.visit url
  confirmText=session.html
  break if confirmText != "<html><head></head><body>Error: Letter not found.</body></html>"
  sleep 2
end
confirmText=~ /(n)(=)(")(3)(D)/
confirmTmp=Regexp.last_match.post_match
confirmTmp=~/(")(>)(<)(\/)(h)/
confirm=Regexp.last_match.pre_match
sleep 2
url="https://dev.by/confirmation?confirmation_token="+confirm
session.visit url
if session.first('.block-alerts') == nil
  puts "user not registrated"
end


session.visit "http://post-shift.ru/api.php?action=delete&key="+htmlKey
end
char = STDIN.getc