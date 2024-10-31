package com.haejeong.product.modules.pub;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class ViewController {
	
	@GetMapping("/")
	public String index()throws Exception {
		return "/index";
	}
	
	@GetMapping("/main")
	public String main()throws Exception{
		return "/main/main_index";
	}

}
