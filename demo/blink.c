#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/gpio.h"

// Define GPIO 0 as LED_PIN
#define LED_PIN 0

// Set delay to 1s
const int delay = 1000;

int main(){
  stdio_init_all();

  // Initialize GPIO
  gpio_init(LED_PIN);
  gpio_set_dir(LED_PIN, GPIO_OUT);

  // Set GPIO HIGH and LOW
  while (true){
    gpio_put(LED_PIN, 1);
    sleep_ms(delay);
    gpio_put(LED_PIN, 0);
    sleep_ms(delay);
  }
}
