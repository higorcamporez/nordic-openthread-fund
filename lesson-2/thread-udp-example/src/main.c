/*
 * Copyright (c) 2016 Intel Corporation
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr/kernel.h>
#include <zephyr/drivers/gpio.h>
#include "print_ips.h"

#define SW0_NODE	DT_ALIAS(sw0) 
static const struct gpio_dt_spec button = GPIO_DT_SPEC_GET(SW0_NODE, gpios);
static struct gpio_callback button_cb_data;

void button_pressed(const struct device *dev, struct gpio_callback *cb, uint32_t pins)
{
   	printk("seding....");
}

void otStateChanged(otChangedFlags aFlags, void *aContext)
{
	printk("State chaged to %d", aFlags);
	printOtIps(openthread_get_default_instance());
}

int main(void)
{
	int ret;
	
	otInstance *pInstance = openthread_get_default_instance();
	while(pInstance == NULL){
		printk("Waiting for a not null Thread instance...");
		k_msleep(1000);
		pInstance = openthread_get_default_instance();
	}

	// setting a callback function when openthread changes its state
	otSetStateChangedCallback(openthread_get_default_instance(), otStateChanged, NULL);

	if (!device_is_ready(button.port)) {
		return 0;
	}

	ret = gpio_pin_configure_dt(&button, GPIO_INPUT);
	if (ret < 0) {
		return 0;
	}
	/* Configure the interrupt on the button's pin */
	ret = gpio_pin_interrupt_configure_dt(&button, GPIO_INT_EDGE_TO_ACTIVE );

	/* Initialize the static struct gpio_callback variable   */
    gpio_init_callback(&button_cb_data, button_pressed, BIT(button.pin)); 	
	
	/* Add the callback function by calling gpio_add_callback()   */
	 gpio_add_callback(button.port, &button_cb_data);

	return 0;
}
