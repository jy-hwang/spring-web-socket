package com.owl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/noti/")
public class NotificationController {

  @GetMapping("webNoti")
  public String webNoti() {
    return "webNoti";
  }

  @GetMapping("webSocket")
  public String webSocket() {
    return "webSocket";
  }

  @GetMapping("webChat")
  public String webChat() {
    return "webChat";
  }

  @GetMapping("webChatUI")
  public String webChatUI() {
    return "webChatUI";
  }

  @GetMapping("sendMain")
  public String sendMain() {
    return "sendMain";
  }

}
