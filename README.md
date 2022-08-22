# GuessTheNumber
## Основная информация
### Обоснование выбора архитектурного подхода
Для создания данного приложения целесообразно использовать MVC паттерн, т.к. в данном проекте view довольно простые и не имеют большого количества интерактивных элементов вызывающих свои методы, то использование MVP и тем более VIPER, как мне кажется, излишне, т.к. перенос логики из ViewController в Presenter увеличит количество кода и усложнит логику приложения (больше шансов ошибиться и оставить баг =)). Но, если усложнять view, добавлять элементы и методы для реагирования на действия пользователя, то можно столкнуться с проблемой Massive View Controller. 
Для разделения ответственности слоев приложения в нашем случае достаточно одной модели, которая будет отвечать за логику игры, и одной, которая сохраняла бы настройки окна помощи; GameViewController обрабатывает события из View, передает информацию в модель и получает уведомление об изменениях в модели; View отображает данные которые ей передает ViewController.
### Дополнительные возможности
- Адаптация UI под темное/светлое оформление
- Выбор уровня сложности
- Подсказки на экранах
### Правила игры
Пользователь загадывает любое целочисленное число (от 1 до 100). Отгадывающий(компьютер) должен отгадать число, ориентируясь на подсказки загадывающего.
Загадывающий может отвечать только «больше», «меньше» или «равно».
Раунд заканчивается когда число было угадано, в процессе ведётся подсчёт попыток.
После отгадывания игроки меняются местами, и пользователь должен отгадать загаданное компьютером число.
Побеждает игрок, отгадавший число соперника за наименьше кол-во ходов.
### Требования к приложению
- Приложение должно состоять из нескольких экранов: 
• Экран старта игры
• Экран загадывания числа
• Экран отгадывания числа компьютером
• Экран отгадывания числа игроком 
• Экран с результатом игры.
- Для реализации интерфейса пользователя необходимо использовать стандартные элементы UIKit.
- Приложение должно поддерживать как горизонтальную так и вертикальную ориентацию экрана. 
- При автоповороте UI должен обновляться.
### Требования
iOS 13+

---

## Basic information
### Reason for choosing an architectural approach
To create this application, it is advisable to use the MVC pattern, because in this project, the views are quite simple and do not have a large number of interactive elements that call their methods, then the use of MVP, and even more so VIPER, it seems to me, is unnecessary, because transferring logic from ViewController to Presenter will increase the amount of code and complicate the application logic (more likely to make mistakes and leave a bug =)). But, if you complicate the view, add elements and methods to respond to user actions, then you may encounter the Massive View Controller problem. To separate the responsibility of the application layers, in our case, one model is enough, which will be responsible for the game logic, and one that would save the settings of the help window; The GameViewController handles events from the View, passes information to the model, and receives notification of changes from the model; The View displays the data that the ViewController passes to it.
### Features
- Adaptation of UI for dark/light design
- Choice of difficulty level
- Hints on the screens
### Rules of the game
The user guesses any integer number (from 1 to 100). The guesser (computer) must guess the number, focusing on the hints of the guesser.
The guesser can only answer "greater than", "less than" or "equal to".
The round ends when the number has been guessed, in the process, attempts are counted.
After guessing, the players change places, and the user must guess the number guessed by the computer.
The player who guesses the opponent's number in the least number of moves wins.
### Application Requirements
- The application must consist of several screens:
• Game start screen
• Number guess screen
• Computer guessing screen
• Player guessing screen
• Screen with the result of the game.
- To implement the user interface, you must use standard UIKit elements.
- The application must support both horizontal and vertical screen orientation.
- When auto-rotating, the UI should be updated.
### Requirements
iOS 13+
