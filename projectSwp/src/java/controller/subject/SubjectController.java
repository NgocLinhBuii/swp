package controller.subject;

import DAO.DAOSubject;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Subject;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/subjects")
public class SubjectController extends HttpServlet {

    private DAOSubject daoSubject = new DAOSubject();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Subject subject = daoSubject.findById(id);
                req.setAttribute("subject", subject);
                req.getRequestDispatcher("Subject/subject.jsp").forward(req, resp);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                daoSubject.delete(id);
                resp.sendRedirect("subjects");
            } else if ("create".equals(action)) {
                Subject newSubject = new Subject();
                req.setAttribute("subject", newSubject);
                req.getRequestDispatcher("Subject/subject.jsp").forward(req, resp);
            } else {
                String name = req.getParameter("name");
                List<Subject> subjectList = (name != null && !name.trim().isEmpty()) ?
                        daoSubject.findByNameOfSubject(name) : daoSubject.findAll();
                req.setAttribute("subjectList", subjectList);
                req.getRequestDispatcher("Subject/subject.jsp").forward(req, resp);
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi xử lý dữ liệu: " + e.getMessage());
            req.getRequestDispatcher("Subject/subject.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idStr = req.getParameter("id");
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            int gradeId = Integer.parseInt(req.getParameter("grade_id"));

            Subject subject = new Subject();
            subject.setName(name);
            subject.setDescription(description);
            subject.setGrade_id(gradeId);

            if (idStr == null || idStr.trim().isEmpty()) {
                daoSubject.insert(subject);
            } else {
                subject.setId(Integer.parseInt(idStr));
                daoSubject.update(subject);
            }
            resp.sendRedirect("subjects");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi lưu môn học: " + e.getMessage());
            req.getRequestDispatcher("Subject/subject.jsp").forward(req, resp);
        }
    }
}
