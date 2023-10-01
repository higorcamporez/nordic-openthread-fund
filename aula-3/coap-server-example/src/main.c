/*
 * Copyright (c) 2020 Nordic Semiconductor ASA
 *
 * SPDX-License-Identifier: LicenseRef-Nordic-5-Clause
 */

#include <zephyr/kernel.h>
#include <zephyr/logging/log.h>
#include <zephyr/drivers/uart.h>
#include <zephyr/usb/usb_device.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/net/openthread.h>
#include <openthread/thread.h>
#include <openthread/ip6.h>
#include <stdio.h> 
#include "print_ips.h"

LOG_MODULE_REGISTER(coap_server_example, 3);


#define SW0_NODE	DT_ALIAS(sw0) 
static const struct gpio_dt_spec button = GPIO_DT_SPEC_GET(SW0_NODE, gpios);
static struct gpio_callback button_cb_data;

/* LED0_NODE is the devicetree node identifier for the node with alias "led0". */
#define LED0_NODE	DT_ALIAS(led0)
static const struct gpio_dt_spec led = GPIO_DT_SPEC_GET(LED0_NODE, gpios);
int ledState;

void button_pressed(const struct device *dev, struct gpio_callback *cb, uint32_t pins)
{
   	printOtIps(openthread_get_default_instance());
}

void otStateChanged(otChangedFlags aFlags, void *aContext)
{
	LOG_INF("State chaged to %d", aFlags);
	printOtIps(openthread_get_default_instance());
}

void main(void)
{
	int ret;
	
	if (!device_is_ready(led.port)) {
		return;
	}

	if (!device_is_ready(button.port)) {
		return;
	}

	ret = gpio_pin_configure_dt(&led, GPIO_OUTPUT_ACTIVE);
	if (ret < 0) {
		return;
	}
	ledState = 1;

	ret = gpio_pin_configure_dt(&button, GPIO_INPUT);
	if (ret < 0) {
		return;
	}
	/* STEP 3 - Configure the interrupt on the button's pin */
	ret = gpio_pin_interrupt_configure_dt(&button, GPIO_INT_EDGE_TO_ACTIVE );

	/* STEP 6 - Initialize the static struct gpio_callback variable   */
    gpio_init_callback(&button_cb_data, button_pressed, BIT(button.pin)); 	
	
	/* STEP 7 - Add the callback function by calling gpio_add_callback()   */
	gpio_add_callback(button.port, &button_cb_data);
	
	otInstance *pInstance = openthread_get_default_instance();
	while(pInstance == NULL){
		LOG_INF("Waiting for a not null Thread instance...");
		k_msleep(1000);
		pInstance = openthread_get_default_instance();
	}

	// setting a callback function when openthread changes its state
	otSetStateChangedCallback(openthread_get_default_instance(), otStateChanged, NULL);

}
