package controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Lesson;
import DAO.LessonDAO;
import java.io.IOException;
import java.util.List;
import model.Chapter;
import DAO.ChapterDAO;


@WebServlet(name = "LessonController", urlPatterns = {"/LessonURL"})
public class LessonController extends HttpServlet {

    private LessonDAO lessonDAO = new LessonDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {
                case "addForm":
                    request.getRequestDispatcher("lesson/addLesson.jsp").forward(request, response);
                    return;

                case "updateForm":
                    String idStr = request.getParameter("id");
                    if (idStr != null) {
                        int id = Integer.parseInt(idStr);
                        Lesson lesson = lessonDAO.getLessonById(id);
                        if (lesson != null) {
                            request.setAttribute("lesson", lesson);
                            request.getRequestDispatcher("lesson/updateLesson.jsp").forward(request, response);
                            return;
                        } else {
                            request.setAttribute("error", "Không tìm thấy lesson với ID " + id);
                        }
                    } else {
                        request.setAttribute("error", "ID không hợp lệ");
                    }
                    break;

                case "delete":
                    String delIdStr = request.getParameter("id");
                    if (delIdStr != null) {
                        int delId = Integer.parseInt(delIdStr);
                        lessonDAO.deleteLesson(delId);
                        response.sendRedirect("LessonURL");
                        return;
                    } else {
                        request.setAttribute("error", "ID không hợp lệ để xóa");
                    }
                    break;

                default:
                    String name = request.getParameter("name");
                    List<Lesson> lessonList;
                    if (name != null && !name.trim().isEmpty()) {
                        lessonList = lessonDAO.searchByName(name.trim());
                        if (lessonList == null || lessonList.isEmpty()) {
                            request.setAttribute("error", "Không tìm thấy bài học nào với tên: " + name);
                        }
                    } else {
                        lessonList = lessonDAO.getAllLessons();
                    }
                    request.setAttribute("lessonList", lessonList);
                    ChapterDAO chapterdao = new ChapterDAO();
                    
                    List<Chapter> chapter = chapterdao.getChapter("select * from chapter");
                    request.setAttribute("chapter", chapter);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý yêu cầu: " + e.getMessage());
        }

        request.getRequestDispatcher("lesson/lessonList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("insert".equals(action)) {
                String name = request.getParameter("name");
                String content = request.getParameter("content");
                int chapterId = Integer.parseInt(request.getParameter("chapter_id"));

                Lesson lesson = new Lesson(0, name, content, chapterId);
                lessonDAO.addLesson(lesson);
                request.setAttribute("message", "Thêm bài học thành công");

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String content = request.getParameter("content");
                int chapterId = Integer.parseInt(request.getParameter("chapter_id"));

                Lesson lesson = new Lesson(id, name, content, chapterId);
                lessonDAO.updateLesson(lesson);
                request.setAttribute("message", "Cập nhật bài học thành công");

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                lessonDAO.deleteLesson(id);
                request.setAttribute("message", "Xóa bài học thành công");
            }

            List<Lesson> lessonList = lessonDAO.getAllLessons();
            request.setAttribute("lessonList", lessonList);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý POST: " + e.getMessage());
        }

        request.getRequestDispatcher("lesson/lessonList.jsp").forward(request, response);
    }
}
