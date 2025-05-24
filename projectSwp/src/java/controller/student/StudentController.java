/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student;

import DAO.AccountDAO;
import DAO.GradeDAO;
import DAO.ImageDAO;
import DAO.StudentDAO;
import config.FileUploadUlti;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;
import model.Grade;
import model.Image;
import model.Student;

/**
 *
 * @author BuiNgocLinh
 */
@MultipartConfig
@WebServlet(name = "StudentController", urlPatterns = {"/student"})

public class StudentController extends HttpServlet {

    private StudentDAO studentDAO = new StudentDAO();
    private AccountDAO accountDAO = new AccountDAO();
    private GradeDAO gradeDAO = new GradeDAO();
    private ImageDAO ImageDAO = new ImageDAO(accountDAO.getConnection());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "create":
                    showCreateForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                default:
                    listStudents(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "create":
                    insertStudent(request, response);
                    break;
                case "edit":
                    updateStudent(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Account> accList = accountDAO.findAll();
        List<Student> list = studentDAO.findAll();
        List<Grade> gradeList = gradeDAO.findAllFromGrade();
        List<Image> imageList = ImageDAO.findAll();

        request.setAttribute("students", list);
        request.setAttribute("accList", accList);
        request.setAttribute("gradeList", gradeList);
        request.setAttribute("imageList", imageList);
        request.getRequestDispatcher("/student/list.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/student/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.findById(id);
        Image image = ImageDAO.findImageById(student.getImage_id());
        request.setAttribute("student", student);
        request.setAttribute("image", image);
        request.getRequestDispatcher("/student/form.jsp").forward(request, response);
    }

    private void insertStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Student student = getStudentFromRequest(request);
        String avatarName = "avatar_" + System.currentTimeMillis();

        String imgURL = FileUploadUlti.uploadAvatarImage(request, avatarName);

        if (imgURL != null) {
            Image image = new Image();
            image.setImage_data(imgURL);

            ImageDAO imageDAO = new ImageDAO(studentDAO.getConnection());
            int imageId = imageDAO.insertImage(image);
            if (imageId > 0) {
                student.setImage_id(imageId);
            }
        }
        studentDAO.insert(student);
        response.sendRedirect("student");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Student student = getStudentFromRequest(request);
        String avatarName = "avatar_" + System.currentTimeMillis();
        String imgURL = FileUploadUlti.uploadAvatarImage(request, avatarName);

        if (imgURL != null) {
            Image image = new Image();
            image.setImage_data(imgURL);

            ImageDAO imageDAO = new ImageDAO(studentDAO.getConnection());
            int imageId = imageDAO.insertImage(image);
            if (imageId > 0) {
                student.setImage_id(imageId);
            }
        } else {
            Student oldStudent = studentDAO.findById(student.getId());
            student.setImage_id(oldStudent.getImage_id());
        }
        studentDAO.update(student);
        response.sendRedirect("student");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        studentDAO.delete(id);
        response.sendRedirect("student");
    }

    private Student getStudentFromRequest(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        int gradeId = Integer.parseInt(request.getParameter("grade_id"));
        int parentId = Integer.parseInt(request.getParameter("parent_id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("full_name");
        LocalDate dob = LocalDate.parse(request.getParameter("dob"));
        boolean sex = Boolean.parseBoolean(request.getParameter("sex"));

        String imageIdParam = request.getParameter("image_id");
        int imageId = (imageIdParam == null || imageIdParam.isEmpty()) ? 0 : Integer.parseInt(imageIdParam);

        return new Student(id, gradeId, parentId, username, password, fullName, dob, sex, imageId);
    }

}
