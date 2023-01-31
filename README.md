# Mobile app developed with Flutter using Firebase to access and display data from Arduino to the app.

I developed this app for a start-up. The app shown here is not the final product.

The application shown here implements the home page for the desired final application and connects the apllication with Firebase Realtime Database to get 
data from Arduino Sensors and perform calculations with this data to be displayed in the application.



To carry out tests for the appication, I set a default barrel maximum capacity of 40,000 ML (40 L). The screenshot below shows what is displayed in the application when the last reading of Volume from the Firebase Realtime Database is 40,000 (Arduino Sensor reads Volume in ML). As it can be seen, it works as expected, as it shows 100% (Maximum Volume) and also shows that there are 80 remaining pints (Each pint is 500 ML, so with 40,000 ML there should be 80 pints remaining):

<img width="333" alt="100%" src="https://user-images.githubusercontent.com/53789337/215844181-9e654f61-19a9-4ce9-b7f7-c7f5bab66603.png">



Screenshot with reading of Volume of 25,000 ML:

<img width="333" alt="63%" src="https://user-images.githubusercontent.com/53789337/215844415-789d0e30-32e3-4ef9-bda2-7601220c2f04.png">



Screenshot with reading of Volume of 0 ML:

<img width="333" alt="0%" src="https://user-images.githubusercontent.com/53789337/215844582-91ee13ab-6ef7-4af4-9725-e312f530dc6b.png">
