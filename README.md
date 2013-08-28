
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
make install
```
собираем проект 

```
make
```

#### Конфигурация

```/conf/main.json``` - информация о регионе и теме, которая будет отображена

```
	{
		"region": {
			"caption":"Ижевск",
			"name":"izhevsk"
		},
		"theme":{
			"caption":"bootstrap",
			"name":"bootstrap"
		}
	}
```

```/conf/server.json``` - адрес сервера 

```
	{
		"host": "http://dev.st-n.ru"
	}
```

```/conf/settings.json``` - пути к картинкам и файлам

```
	{
		"paths":
		{
			"files":
			{
				"url": "http://oz.st-n.ru/publish/files/"
			},
			"images":
			{
				"url": "http://oz.st-n.ru/publish/photo/"
			},
			"widgets":
			{
				"gismeteo":
				{
					"url": "http://oz.st-n.ru/gismeteo/"
				}
			}

		}

	}
```

```/conf/themes.json``` - описание доступных тем

```
{
	"bootstrap":
	{
		"css": [],
		"js": []
	}
}
```
