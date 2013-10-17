
## Клиентская часть Новостей Общего Заказа

> Внутренняя разработка компании [Стандарт-Н](http://standart-n.ru/)

  - Пример разработки: [http://oz.st-n.ru/publish/](http://oz.st-n.ru/publish/)
  - Проект представляет из себя одностраничный сайт, полностью работающий на ```html``` + ```javascript```
  - Обмен данными между клиентской частью и сервером происходит спомощью [JSONP](http://ru.wikipedia.org/wiki/JSONP) формата


#### Для установки требуется

```
  * GNU Make 3.81 or newer
  * Node.js 0.10.10 or newer
  * NPM.js 1.2.25 or newer
```

#### Установка из исходного кода

скачиваем

```
git clone https://github.com/standart-n/sn-oz-client
```
переходим в папку проекта

```
cd ./sn-oz-client
```
устанавливаем необоходимые пакеты

```
make
```

#### Конфигурация

  - ```/conf/main.json``` - информация о регионе и теме, которая будет отображена

  - ```/conf/server.json``` - адрес сервера 

  - ```/conf/settings.json``` - пути к картинкам и файлам

  - ```/conf/themes.json``` - описание доступных тем



#### Журнал изменений


##### 17 окт 2013г. v0.2.2

 - Улучшение дизайна формы отправки сообщений


##### 16 окт 2013г. v0.2.1

 - Загрузка файлов и картинок на сервер


##### 26 сен 2013г.

 - Переход на сессии

 - Внедрение сокетов 

##### 06 сен 2013г.

 - Синхронизация ленты новостей с сервером. До этого при любом изменении лента новостей польностью перерисовывалась.

 - Оптимизация на уменьшение кол-ва запросов к серверу.

 - Установка большинства библиотек спомощью ```bower```.

 - Механизм для асинхронной отправки файлов на сервер, который может находиться на другом домене.



### License

The MIT License (MIT)

Copyright (c) 2013 Aleksey Nikolaev

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

        

