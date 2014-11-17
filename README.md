## Установка

Добавляем в Gemfile

    gem 'smsru', github: 'alekseenkoss77/smsru'

Выполняем:

    $ bundle

## Использование
Для сервиса Sms.ru вам необходимо сконфигурировать его.

    Smsru.configure do |conf|
      conf.mail = 'your-mail'
      conf.api_id = 'your-api-id'
      conf.from = 'sender-name'
      conf.test = false
      conf.format = false
    end

api_id - Спец. токен для сервиса<br>
from - Строка отправителя (номер или согласованное название)<br>
mail - Необязательный параметр, Ваш Email<br>
test -  Необязательный параметр, необязательный параметр, указывающий на то, что сообщение - тестовое (по-умолчанию false)<br>
format - Необязательный параметр, если true, возвращает ответ в объекте Smsru::Response,
если false в исходном виде, пример: "100\n0000-0000".<br>

<h4>Отправка сообщения для одного адресата</h4>

    Smsru::API.send_sms(to, text, api_id, from, test)

to - номер телефона получателя;<br>
text - текст сообщения в кодировке UTF-8;<br>
api_id и from - необязательные параметры, если модуль был сконфигурирован ранее;<br>
test - необязательный параметр, указывающий на то, что сообщение - тестовое (по-умолчанию false)

<h4>Групповая рассылка</h4>

    Smsru::API.group_send(to, text, api_id, from, test)

to - массив с номерами телефонов; функция отправляет запросы по 100 штук

<h4>Запрос баланса</h4>

    Smsru::API.balance(api_id)

<h4>Обработка ответа</h4>

    Smsru::Response

## Методы

success? - сообщение принято к отправке;<br>
fail? - сообщение было отклонено;<br>
to_h - ответ в виде: {:code, :status, :message, :balance, :message, :raw}.<br>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
