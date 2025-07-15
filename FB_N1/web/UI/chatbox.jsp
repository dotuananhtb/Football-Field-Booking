<%-- 
    Document   : chatbox.jsp
    Created on : Jul 14, 2025, 9:58:50 PM
    Author     : VAN NGUYEN
--%>

<%@page import="dao.ChatBoxDAO"%>
<%@page import="model.ChatBox"%>
<%@page import="java.util.List"%>
<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <base href="${pageContext.request.contextPath}/UI/">
        <title>Chat Bot AI</title>
        <<link rel="stylesheet" href="app/css/chatbot.css"/>
    </head>
    <body>
        
        
        <%
    Account acc = (Account) session.getAttribute("account");
    List<ChatBox> history = null;
    if (acc != null) {
        ChatBoxDAO dao = new ChatBoxDAO();
        history = dao.getHistoryByAccountId(acc.getAccountId());
    }
%>

<div id="chatbot-container">
    <div id="chatbot-button">💬</div>
    <div id="chatbot-popup" class="hidden">
        <div id="chatbot-header">
            <span> Trợ lý ảo</span>
            <a id="close-chat">×</a>
        </div>
        <div id="chatbot-body">
            <div id="chat-log">
                <% if (history != null) {
                    for (ChatBox chat : history) { %>
                        <div class="message user">🙋: <%= chat.getUser_input() %></div>
                        <div class="message bot">🤖: <%= chat.getBot_response() %></div>
                <%  }
                } %>
            </div>
            <form id="chat-form">
                <input type="text" id="user-input" placeholder="Nhập tin nhắn..." autocomplete="off" />
                <button type="submit">Gửi</button>
            </form>
        </div>
    </div>
</div>




        <script>
            // Lấy context path từ JSP
            const contextPath = "${pageContext.request.contextPath}";
            const chatLog = document.getElementById('chat-log');
            chatLog.scrollTop = chatLog.scrollHeight;
            document.addEventListener("DOMContentLoaded", function () {
                const chatbotButton = document.getElementById("chatbot-button");
                const chatbotPopup = document.getElementById("chatbot-popup");
                const closeButton = document.getElementById("close-chat");
                const chatForm = document.getElementById("chat-form");
                const userInput = document.getElementById("user-input");
                const chatLog = document.getElementById("chat-log");

                // Mở popup
                chatbotButton.addEventListener("click", () => {
                    chatbotPopup.classList.toggle("hidden");
                });

                // Đóng popup
                closeButton.addEventListener("click", () => {
                    chatbotPopup.classList.add("hidden");
                });

                // Gửi tin nhắn
                chatForm.addEventListener("submit", function (e) {
                    e.preventDefault();
                    const message = userInput.value.trim();
                    if (!message)
                        return;

                    appendMessage("user", message);
                    userInput.value = "";

                    fetch(contextPath + "/chat-bot-servlet", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded",
                        },
                        body: "prompt=" + encodeURIComponent(message)
                    })
                            .then((res) => res.text())
                            .then((data) => {
                                appendMessage("bot", data);
                            })
                            .catch((err) => {
                                appendMessage("bot", "Lỗi máy chủ hoặc mạng.");
                                console.error(err);
                            });
                });

                function appendMessage(sender, message) {
                    const msgDiv = document.createElement("div");
                    msgDiv.classList.add("message", sender);
                    msgDiv.textContent = (sender === "bot" ? "🤖: " : "🙋: ") + message;
                    chatLog.appendChild(msgDiv);
                    chatLog.scrollTop = chatLog.scrollHeight;
                }
            });



        </script>


    </body>



</html>
