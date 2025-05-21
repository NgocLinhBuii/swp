/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.LessonDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Lesson;

/**
 *
 * @author Na
 */
@WebServlet(name = "LessonController", urlPatterns = {"/LessonURL"})
public class LessonController extends HttpServlet {
    
    private LessonDAO lessonDAO;

    @Override
    public void init() throws ServletException {
        lessonDAO = new LessonDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String service = request.getParameter("service");
        if (service == null) {
            service = "";
        }

        switch (service) {
            case "add":
                addLesson(request, response);
                break;
            case "edit":
                editLesson(request, response);
                break;
            case "delete":
                deleteLesson(request, response);
                break;
            default:
                listLesson(request, response);
                break;
        }
    }

    private void listLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Lesson> list = lessonDAO.getAllLessons();
        request.setAttribute("listLesson", list);
        request.getRequestDispatcher("/lesson/listLesson.jsp").forward(request, response);
    }

    private void addLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String content = request.getParameter("content");
        int chapterId = Integer.parseInt(request.getParameter("chapter_id"));

        Lesson lesson = new Lesson(0, name, content, chapterId);
        lessonDAO.insertLesson(lesson);
        response.sendRedirect("LessonURL");
    }

    private void editLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String content = request.getParameter("content");
        int chapterId = Integer.parseInt(request.getParameter("chapter_id"));

        Lesson lesson = new Lesson(id, name, content, chapterId);
        lessonDAO.updateLesson(lesson);
        response.sendRedirect("LessonURL");
    }

    private void deleteLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        lessonDAO.deleteLesson(id);
        response.sendRedirect("LessonURL");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
