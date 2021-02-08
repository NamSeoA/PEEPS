package com.gnjk.peeps.auth.Controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.gnjk.peeps.auth.Service.GoogleService;
import com.gnjk.peeps.auth.domain.GoogleRequest;
import com.gnjk.peeps.auth.domain.GoogleResponse;
import com.gnjk.peeps.domain.RegRequest;

@Controller
@RequestMapping("/glogin")
public class GoogleController {

	@Autowired
	private GoogleService googleService;

	final static String GOOGLE_AUTH_BASE_URL = "https://accounts.google.com/o/oauth2/v2/auth";
	final static String GOOGLE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/token";

	private String clientId = "932809958130-576t52vbv3m0dq8ei051noieo4lhauc1.apps.googleusercontent.com";
	private String clientSecret = "7wyexcIGQj61JPsW2xNG5mXo";

	@RequestMapping(method = RequestMethod.GET)
	public String googleAuth(Model model, @RequestParam(value = "code") String authCode)
			throws JsonProcessingException {

		// HTTP Request를 위한 RestTemplate
		RestTemplate restTemplate = new RestTemplate();

		// Google OAuth Access Token 요청을 위한 파라미터 세팅
		GoogleRequest googleOAuthRequestParam = GoogleRequest.builder().clientId(clientId).clientSecret(clientSecret)
				.code(authCode).redirectUri("http://localhost:8080/peeps/glogin").grantType("authorization_code")
				.build();

		// JSON 파싱을 위한 기본값 세팅
		// 요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
		ObjectMapper mapper = new ObjectMapper();
		mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
		mapper.setSerializationInclusion(Include.NON_NULL);

		// AccessToken 발급 요청
		ResponseEntity<String> resultEntity = restTemplate.postForEntity(GOOGLE_TOKEN_BASE_URL, googleOAuthRequestParam,
				String.class);

		// Token Request
		GoogleResponse result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleResponse>() {
		});

		// ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다)
		// resttemplate의 경우 String으로 값이 들어오면 알아서 encode를 해준다.
		String jwtToken = result.getIdToken();
		String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
				.queryParam("id_token", jwtToken).toUriString();

		String resultJson = restTemplate.getForObject(requestUrl, String.class);

		Map<String, String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>() {
		});

		model.addAttribute("email", userInfo.get("email"));
		model.addAttribute("name", userInfo.get("name"));
		model.addAttribute("m_photo", userInfo.get("picture"));
		model.addAttribute("token", result.getAccessToken());

		System.out.println(userInfo);
		System.out.println(userInfo.get("email"));
		System.out.println(userInfo.get("name"));
		System.out.println(userInfo.get("picture"));

		return "member/TimeLine";

	}

	@RequestMapping(method = RequestMethod.POST)
	public String memberReg(@ModelAttribute("regData") RegRequest regRequest, HttpServletRequest request, Model model) {

		System.out.println(regRequest);
		int result = googleService.memberReg(regRequest, request);

		model.addAttribute("result", result);

		return "member/RegView";
	}

}