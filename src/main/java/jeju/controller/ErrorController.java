package jeju.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "/error")
public class ErrorController {
	
	@GetMapping("/server-error")
	public String serverError() {
		return "error/serverError";
	}
	
	@GetMapping("/method-error")
	public String methodError() {
		return "error/methodError";
	}

	@GetMapping("/no-resource")
	public String noResource() {
		return "error/noResource";
	}
	
}
