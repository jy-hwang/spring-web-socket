package com.owl.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import org.springframework.stereotype.Controller;

@Controller
@ServerEndpoint("/EchoServer")
public class WebSocketChat {

  private static final List<Session> sessionList = new ArrayList<Session>();

  public WebSocketChat() {
    System.out.println("웹 소켓(서버) 객체 생성");
  }

  @OnOpen
  public void onOpen(Session session) {
    System.out.println("새로운 session id = " + session.getId());

    try {
      final Basic basic = session.getBasicRemote();
      System.out.println("새로운 session getBasicRemote = " + basic);

      basic.sendText("대화방에 연결 되었습니다.");
    } catch (IOException e) {
      System.out.println(e.getMessage());
    }
    sessionList.add(session);
  }

}
