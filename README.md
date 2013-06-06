## Установка

Добавляем в Gemfile

    gem 'smsru'

Выполняем:

    $ bundle

или устанавливаем как:

    $ gem install smsru

## Использование
Для сервиса Sms.ru вам необходимо сконфигурировать его

например так
Smsru.configure do |conf|
  conf.mail = 'blablabla@email.com'
  conf.api_id = "e7f6f922-838e-c924-79f9-3c4314f63zbd"
  conf.from = 'foo'
end

mail - Ваш Email
api_id - спец. токен для сервиса
from - строка отправителя (номер или согласованное название)

Метод отправки сообщения
Smsru::Sender.single_sms('79539136846', 'test gem')

Пример отправки сообщения
Smsru::Sender.single_sms('79539136846', 'test gem')

Пример для тестового сообщения
Smsru::Sender.test_sms('79539136846', 'test gem')

Групповая рассылка (пока не протестировано на людях :))

Smsru::Sender.group_send(to, text, from)

to - массив произвольного размера, функция отправляет запросы по 100 штук
остальные параметры те же

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
