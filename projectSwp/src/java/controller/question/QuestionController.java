package controller.question;

import dal.ImageDAO;
import dal.QuestionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Question;
import model.Lesson;
import dal.LessonDAO;
import model.Image;

@WebServlet(name = "QuestionController", urlPatterns = {"/Question"})
public class QuestionController extends HttpServlet {

    private QuestionDAO questionDAO = new QuestionDAO();
    private ImageDAO imageDAO = new ImageDAO(questionDAO.getDBConnection());

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
                    LessonDAO lessonDAO = new LessonDAO();
                    List<Lesson> lessonList = lessonDAO.getAllLessons();
                    request.setAttribute("les", lessonList);
                    request.getRequestDispatcher("question/addQuestion.jsp").forward(request, response);
                    return;

                case "updateForm":
                    String idStr = request.getParameter("id");
                    if (idStr != null) {
                        int id = Integer.parseInt(idStr);
                        Question question = questionDAO.getQuestionById(id);

                        LessonDAO lessonDAO2 = new LessonDAO();
                        List<Lesson> lessonList2 = lessonDAO2.getAllLessons();

                        request.setAttribute("question", question);
                        request.setAttribute("les", lessonList2);
                        request.getRequestDispatcher("question/updateQuestion.jsp").forward(request, response);
                        return;
                    }
                    break;

                case "delete":
                    int delId = Integer.parseInt(request.getParameter("id"));
                    questionDAO.delete(delId);
                    response.sendRedirect("Question");
                    return;

                // Thay đoạn code hiện tại trong case default bằng:
                default:
                    String keyword = request.getParameter("question");
                    List<Question> list;
                    if (keyword != null) {
                        keyword = keyword.trim();
                    }
                    if (keyword != null && !keyword.isEmpty()) {
                        list = questionDAO.findByQuestion(keyword);
                    } else {
                        list = questionDAO.findAllQuestion();
                    }

                    LessonDAO dao = new LessonDAO();
                    List<Lesson> les = dao.getAllLessons();
                    request.setAttribute("les", les);
                    request.setAttribute("questionList", list);

                    // Xử lý image 
                    try {
                        List<Image> images = imageDAO.findAll();
                        if (images != null && !images.isEmpty()) {
                            request.setAttribute("images", images);
                        } else {
                            request.setAttribute("imageError", "Không tìm thấy dữ liệu ảnh");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        request.setAttribute("imageError", "Lỗi khi tải dữ liệu ảnh: " + e.getMessage());
                    }
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
            String questionText = request.getParameter("question");

            int image_id = 0;
            int lesson_id = 0;

            String imageIdStr = request.getParameter("image_id");
            String lessonIdStr = request.getParameter("lesson_id");

            if (imageIdStr != null && !imageIdStr.isEmpty()) {
                image_id = Integer.parseInt(imageIdStr);
            }
            if (lessonIdStr != null && !lessonIdStr.isEmpty()) {
                lesson_id = Integer.parseInt(lessonIdStr);
            }

            if ("insert".equals(action)) {
                Question q = new Question(questionText, image_id, lesson_id);
                questionDAO.insert(q);
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Question q = new Question(id, questionText, image_id, lesson_id);
                questionDAO.update(q);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error while processing request: " + e.getMessage());
        }

        response.sendRedirect("Question");
    }

}
