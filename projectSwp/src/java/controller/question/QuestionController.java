package controller.question;

import dal.ImageDAO;
import dal.QuestionDAO;
import dal.LessonDAO;
import model.Question;
import model.Lesson;
import model.Image;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.List;
import util.AuthUtil;
import util.RoleConstants;

@MultipartConfig
@WebServlet(name = "QuestionController", urlPatterns = {"/Question"})
public class QuestionController extends HttpServlet {

    private QuestionDAO questionDAO = new QuestionDAO();
    private ImageDAO imageDAO = new ImageDAO(questionDAO.getDBConnection());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.hasRole(request, RoleConstants.ADMIN) && !AuthUtil.hasRole(request, RoleConstants.TEACHER)&& !AuthUtil.hasRole(request, RoleConstants.STUDENT)) {
            response.sendRedirect("/error.jsp");
            return;
        }
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

                default:
                    String keyword = request.getParameter("question");
                    List<Question> list;
                    if (keyword != null && !keyword.trim().isEmpty()) {
                        list = questionDAO.findByQuestion(keyword.trim());
                    } else {
                        list = questionDAO.findAllQuestion();
                    }

                    LessonDAO dao = new LessonDAO();
                    List<Lesson> les = dao.getAllLessons();
                    request.setAttribute("les", les);
                    request.setAttribute("questionList", list);

                    try {
                        List<Image> images = imageDAO.findAll();
                        request.setAttribute("images", images);
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
       if (!AuthUtil.hasRole(request, RoleConstants.ADMIN) && !AuthUtil.hasRole(request, RoleConstants.TEACHER)&& !AuthUtil.hasRole(request, RoleConstants.STUDENT)) {
            response.sendRedirect("/error.jsp");
            return;
        }
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            String questionText = request.getParameter("question");
            int lesson_id = 0;
            String lessonIdStr = request.getParameter("lesson_id");
            if (lessonIdStr != null && !lessonIdStr.isEmpty()) {
                lesson_id = Integer.parseInt(lessonIdStr);
            }

            int image_id = 0;
            Part imagePart = request.getPart("image_file");
            if (imagePart != null && imagePart.getSize() > 0) {
                InputStream inputStream = imagePart.getInputStream();
                byte[] imageBytes = inputStream.readAllBytes();
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                Image img = new Image();
                img.setImage_data(base64Image);
                image_id = imageDAO.insertImage(img);
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
