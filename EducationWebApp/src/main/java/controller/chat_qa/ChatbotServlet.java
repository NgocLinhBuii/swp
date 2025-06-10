package controller.chat_qa;

import dal.ChatQADAO;
import model.ChatQA;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/chatbot-response")
public class ChatbotServlet extends HttpServlet {

    private final ChatQADAO dao = new ChatQADAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
      
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain; charset=UTF-8");

        String query = req.getParameter("query");
        String result = "❗ Xin lỗi, tôi chưa hiểu câu hỏi của bạn.";

        if (query != null && !query.trim().isEmpty()) {
            try {
                List<ChatQA> list = dao.findAll();
                String lowerQuery = query.toLowerCase();

                for (ChatQA qa : list) {
                    String keyword = qa.getKey() != null ? qa.getKey().toLowerCase() : "";
                    if (!keyword.isEmpty() && lowerQuery.contains(keyword)) {
                        result = qa.getAnswer();
                        break;
                    }
                }

            } catch (SQLException e) {
                result = "❌ Đã xảy ra lỗi hệ thống khi tìm câu trả lời.";
                e.printStackTrace();
            }
        }

        resp.getWriter().write(result);
    }
}
