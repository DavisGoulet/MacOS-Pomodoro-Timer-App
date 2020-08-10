# Pomodoro Timer MacOS Application

The Pomodoro Technique is a time management / focus method where a large time period is broken down into smaller blocks (called pomodoros) and separated by small (1-2 minute) breaks. After so many breakers occur, a larger (15-20 min) occurs. The goal of the technique is to allow one to focus on a task by reducing internal and external distractions /  interruptions.

Many applications exist based around the Pomodoro technique, however, I have found none that fit all the criteria I am looking for in an application. These criteria are:

- A timer that runs on the same machine I am working on. Many applications exist as phone apps which require another device.
- A timer that can run in the background and does not require a separate UI to work. This removes the need to have another window open that takes up screen space.
 - A timer that is its own application. Many timers exist as web apps. However, this require the user to have a web browser tab dedicated to it. Furthermore, many times in the past, I have accidentally closed the web browser and lost the timer.
 
Because of these reasons, I decided to build my own application. This is a MacOS application that runs in the background. When the application is started, an icon appears in the top task bar (where Wifi, Bluetooth, etc. are located). Clicking this icon opens up the application UI. Clicking anywhere else on the screen (that is not the application) causes the UI to close but still run in the background. This allows for the user to have quick access to the application while not being intrusive.

The application consists of two screens. The first screen allows the user to configure the timer options. This includes setting the lengths for focus sessions and breaks. The second screen is the timer itself. It contains a timer visualization that counts down in real time, as well as options allowing the user to reset the current session, skip to the next session, or cancel the timer all together.
