package com.haejeong.product.config.p6spy;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class P6spyConfig {

	@Bean
	LogEventListener p6SpyCustomEventListener() {
		return new LogEventListener();
	}

	@Bean
	P6spyFormatter p6SpyCustomFormatter() {
		return new P6spyFormatter();
	}

}
