package controller.chat_qa;

import dal.ChatQADAO;
import model.ChatQA;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/manage-qa")
public class chat_qaController extends HttpServlet {
    private final ChatQADAO dao = new ChatQADAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    ChatQA qa = dao.findById(id);
                    request.setAttribute("qa", qa);
                    request.getRequestDispatcher("qa/edit.jsp").forward(request, response);
                    break;
                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    dao.delete(deleteId);
                    response.sendRedirect("manage-qa");
                    break;
                default:
                    List<ChatQA> list = dao.findAll();
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("qa/list.jsp").forward(request, response);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi khi xử lý dữ liệu");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String idRaw = request.getParameter("id");
        String question = request.getParameter("question");
        String key = request.getParameter("key");
        String answer = request.getParameter("answer");

        ChatQA qa = new ChatQA();
        qa.setQuestion(question);
        qa.setKey(key);
        qa.setAnswer(answer);

        try {
            if (idRaw == null || idRaw.isEmpty()) {
                dao.insert(qa);
            } else {
                int id = Integer.parseInt(idRaw);
                qa.setId(id);
                dao.update(qa);
            }
            response.sendRedirect("manage-qa");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lưu dữ liệu");
        }
    }
}
