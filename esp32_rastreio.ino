#include <WiFi.h> /*Wifi library included*/
hw_timer_t * timer = NULL;
volatile SemaphoreHandle_t timerSemaphore;
portMUX_TYPE timerMux = portMUX_INITIALIZER_UNLOCKED;

volatile uint32_t isrCounter = 0;
volatile uint32_t lastIsrAt = 0;
volatile long controle=0;
const char* ssid     = "ESP32";    /*SSID defined for AP*/
const char* password = "123456789"; /*Password defined, removed for an open network*/
WiFiServer server(80); /*Web Server Port 80*/
String identifica="bebe achado";
String header; /*variable stores HTTP request*/

String OutputGPIO25 = "OFF"; /*variable to store current Output*/
const int Output_25 = 25;   /*GPIO pin 25 assigned to variable*/
void ARDUINO_ISR_ATTR onTimer(){
  if(controle==0){
       Serial.println("procurando bebe"); 
     //digitalWrite(aciona,HIGH);
    // delay(200);
    // digitalWrite(aciona,LOW);
    // delay(500);
    //tone(Output_25,262,500); 
     digitalWrite(Output_25,HIGH);
    

    }
    else{
       digitalWrite(Output_25,LOW);
      Serial.println("bebe achado");
    }
controle=0;
identifica="procurando bebe";
}
void setup() {
  Serial.begin(115200);
  pinMode(Output_25, OUTPUT); /*variable initialize for output*/
  digitalWrite(Output_25, LOW);   /*Output set to low*/
// Create semaphore to inform us when the timer has fired
  timerSemaphore = xSemaphoreCreateBinary();

  // Use 1st timer of 4 (counted from zero).
  // Set 80 divider for prescaler (see ESP32 Technical Reference Manual for more
  // info).
  timer = timerBegin(0, 80, true);

  // Attach onTimer function to our timer.
  timerAttachInterrupt(timer, &onTimer, true);

  // Set alarm to call onTimer function every second (value in microseconds).
  // Repeat the alarm (third parameter)
  timerAlarmWrite(timer, 3000000, true);

  // Start an alarm
  timerAlarmEnable(timer);
  Serial.print("Setting AP (Access Point)…");
  WiFi.softAP(ssid, password);    /*ESP32 wifi set in Access Point mode*/

  IPAddress IP = WiFi.softAPIP();  /*IP address is initialized*/
  Serial.print("AP IP address: ");
  Serial.println(IP);  /*Print IP address*/
  server.begin();
}
void loop(){
WiFiClient client = server.available(); /*check for clients request*/

if (client) {                      /*Condition to check for new client*/
Serial.println("New Client.");          
String currentLine = "";           /*string to hold data*/
while (client.connected()) {       /*loop for client connection check*/
if (client.available()) {          /*read if data available*/
char c = client.read();            
Serial.write(c);                    
header += c;
if (c == '\n') {                    /*if byte is newline character*/
/*in case if current line is blank two new line characters will be available*/
/*end of client hTTP request*/
if (currentLine.length() == 0) {
/* HTTP start with a response code HTTP/1.1 200 OK */
/* and content-type so client knows what's coming, then a blank line:*/
client.println("HTTP/1.1 200 OK");
client.println("Content-type:text/html");
client.println("Connection: close");
client.println();            
/*turns the GPIOs 25 ON and OFF*/
if (header.indexOf("GET /25/ON") >= 0) {
Serial.println("GPIO 25 ON");
Serial.println("cutucou on");
    controle=1;
 Serial.println("bebe achado"); 
 identifica="bebe achado";
//digitalWrite(Output_25, HIGH);
}


if (header.indexOf("GET /25/procurar") >= 0) {
Serial.println("procurando bebe");
    controle=0;
    identifica="procurando bebe";

//digitalWrite(Output_25, LOW);
}
/*HTML code for server*/
client.println("");
client.println("");
client.println("");
/*including CSS to customize button*/
client.println("<style>html { background-color: #c4ccc8; font-family: Fantasy; display: inline-block; margin: 0px auto; text-align: center;}");
client.println(".button { background-color: #000000; display: inline-block;  border-radius: 30px;border: 2px solid gray; color: white; padding: 16px 40px;");
client.println("text-decoration: none; font-size: 30px; margin: 2px; cursor: pointer;}");
client.println(".button2 {background-color: #f70d05;}</style>");

/*Web page headings*/
client.println("<h1>Web Server ESP32</h1>");
client.println("<h1>Linuxhint.com</h1>");

// Display current state, and ON/OFF buttons for GPIO 25  
client.println("<p>GPIO 25 LED situacao " + identifica+ "</p>");
client.println("<p><a href='/25/ON'><button class='button'>ON</button></a></p>");
client.println("<br><br><br>");
client.println("<p><a href='/25/procurar'><button class='button'>procurar</button></a></p>");
// If the OutputGPIO25 is OFF, it displays the ON button      
          
client.println("");            
/*HTTP response end with blank line*/
client.println();

/*while loop break*/
break;
} else { /*in new line clear current line*/
currentLine = "";
}
} else if (c != '\r') {  /*a carriage return character*/
currentLine += c;      /*add to the end of currentLine*/
}
}
}
/*clear header*/
header = "";
client.stop();    /*client disconnected*/
//Serial.println("Client disconnected.");
Serial.println("");
}
}
