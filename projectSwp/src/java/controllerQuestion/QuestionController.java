package controllerQuestion;

import DAO.QuestionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Question;

@WebServlet(name = "QuestionController", urlPatterns = {"/Question"})
public class QuestionController extends HttpServlet {

    private QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "addForm":
                    request.getRequestDispatcher("question/addQuestion.jsp").forward(request, response);
                    return;

                case "updateForm":
                    String idStr = request.getParameter("id");
                    if (idStr != null) {
                        int id = Integer.parseInt(idStr);
                        Question question = questionDAO.getQuestionById(id);
                        request.setAttribute("question", question);
                        request.getRequestDispatcher("question/updateQuestion.jsp").forward(request, response);
                        return;
                    }
                    break;

                case "delete":
                    int delId = Integer.parseInt(request.getParameter("id"));
                    questionDAO.delete(delId);
                    response.sendRedirect("Question");
                    return;

                default:
                    String keyword = request.getParameter("question");
                    List<Question> list;
                    if (keyword != null) {
                        keyword = keyword.trim(); // loại bỏ khoảng trắng đầu cuối
                    }
                    if (keyword != null && !keyword.isEmpty()) {
                        list = questionDAO.findByQuestion(keyword);
                    } else {
                        list = questionDAO.findAllQuestion();
                    }
                    request.setAttribute("questionList", list);
                    break;

            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
        }

        request.getRequestDispatcher("question/questionList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String questionText = request.getParameter("question");
            int image_id = Integer.parseInt(request.getParameter("image_id"));
            int lesson_id = Integer.parseInt(request.getParameter("lesson_id"));
            Question q = new Question(id, questionText, image_id, lesson_id);

            if ("insert".equals(action)) {
                questionDAO.insert(q);
            } else if ("update".equals(action)) {
                questionDAO.update(q);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error while processing request: " + e.getMessage());
        }

        response.sendRedirect("Question");
    }

}
