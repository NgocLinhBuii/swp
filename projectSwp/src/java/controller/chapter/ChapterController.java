/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.chapter;

import dal.ChapterDAO;
import dal.DAOSubject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Chapter;
import model.Subject;

/**
 *
 * @author Na
 */
@WebServlet(name = "ChapterController", urlPatterns = {"/chapter"})
public class ChapterController extends HttpServlet {

    private ChapterDAO chapterDAO;
    private DAOSubject subjectDAO;

    @Override
    public void init() throws ServletException {
        chapterDAO = new ChapterDAO();
        subjectDAO = new DAOSubject();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String service = request.getParameter("service");
        if (service == null) {
            service = "";
        }

        try {
            switch (service) {
                case "add":
                    if (request.getMethod().equalsIgnoreCase("GET")) {
                        showAddForm(request, response);
                    } else {
                        addChapter(request, response);
                    }
                    break;
                case "edit":
                    if (request.getMethod().equalsIgnoreCase("GET")) {
                        showEditForm(request, response);
                    } else {
                        editChapter(request, response);
                    }
                    break;
                case "delete":
                    deleteChapter(request, response);
                    break;
                case "search":
                    searchChapter(request, response);
                    break;
                default:
                    listChapter(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.setAttribute("listChapter", List.of());
            request.setAttribute("listSubject", List.of());
            request.setAttribute("subjectMap", new HashMap<Integer, String>());
            try {
                request.getRequestDispatcher("/chapter/listChapter.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể hiển thị trang: " + ex.getMessage());
            }
        }
    }

    private Map<Integer, String> loadSubjectMap() {
        Map<Integer, String> subjectMap = new HashMap<>();
        try {
            List<Subject> listSubject = subjectDAO.findAll();
            if (listSubject != null) {
                for (Subject subject : listSubject) {
                    subjectMap.put(subject.getId(), subject.getName());
                }
            }
        } catch (Exception e) {
            // Log lỗi nếu cần
        }
        return subjectMap;
    }

    private void listChapter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        List<Chapter> listChapter = chapterDAO.getChapter("SELECT * FROM chapter");
        List<Subject> listSubject = subjectDAO.findAll();
        Map<Integer, String> subjectMap = loadSubjectMap();

        request.setAttribute("listChapter", listChapter != null ? listChapter : List.of());
        request.setAttribute("listSubject", listSubject != null ? listSubject : List.of());
        request.setAttribute("subjectMap", subjectMap != null ? subjectMap : new HashMap<Integer, String>());
        request.getRequestDispatcher("/chapter/listChapter.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        List<Subject> listSubject = subjectDAO.findAll();
        request.setAttribute("listSubject", listSubject != null ? listSubject : List.of());
        request.getRequestDispatcher("/chapter/chapterForm.jsp").forward(request, response);
    }

    private void addChapter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            int subjectId = Integer.parseInt(request.getParameter("subject_id"));

            Chapter chapter = new Chapter(id, name, description, subjectId);
            int result = chapterDAO.addChapter(chapter);
            if (result > 0) {
                request.setAttribute("message", "Thêm chapter thành công!");
                response.sendRedirect("chapter");
            } else {
                request.setAttribute("errorMessage", "Không thể thêm chapter!");
                showAddForm(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID hoặc Subject ID không hợp lệ!");
            showAddForm(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int editId = Integer.parseInt(request.getParameter("editId"));
        Chapter chapter = chapterDAO.findChapterById(editId);
        List<Subject> listSubject = subjectDAO.findAll();
        if (chapter != null) {
            request.setAttribute("chapterToEdit", chapter);
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy chapter với ID: " + editId);
        }
        request.setAttribute("listSubject", listSubject != null ? listSubject : List.of());
        request.getRequestDispatcher("/chapter/chapterForm.jsp").forward(request, response);
    }

    private void editChapter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            int subjectId = Integer.parseInt(request.getParameter("subject_id"));

            Chapter chapter = new Chapter(id, name, description, subjectId);
            int result = chapterDAO.editChapter(chapter);
            if (result > 0) {
                request.setAttribute("message", "Cập nhật chapter thành công!");
                response.sendRedirect("chapter");
            } else {
                request.setAttribute("errorMessage", "Không thể cập nhật chapter!");
                showEditForm(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID hoặc Subject ID không hợp lệ!");
            showEditForm(request, response);
        }
    }

    private void deleteChapter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int result = chapterDAO.deleteChapter(id);
            if (result > 0) {
                request.setAttribute("message", "Xóa chapter thành công!");
            } else {
                request.setAttribute("errorMessage", "Không thể xóa chapter!");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Định dạng ID không hợp lệ!");
        }
        listChapter(request, response);
    }

    private void searchChapter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String idParam = request.getParameter("id");
        String nameParam = request.getParameter("name");
        String subjectIdParam = request.getParameter("subject_id");
        List<Subject> listSubject = subjectDAO.findAll();
        Map<Integer, String> subjectMap = loadSubjectMap();

        List<Chapter> listChapter;
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Chapter chapter = chapterDAO.findChapterById(id);
                listChapter = (chapter != null) ? List.of(chapter) : List.of();
                if (chapter == null) {
                    request.setAttribute("message", "Không tìm thấy chapter với id = " + id);
                }
            } catch (NumberFormatException e) {
                listChapter = List.of();
                request.setAttribute("message", "Định dạng id không hợp lệ!");
            }
        } else if (nameParam != null && !nameParam.isEmpty()) {
            listChapter = chapterDAO.findChapterByName(nameParam);
            if (listChapter.isEmpty()) {
                request.setAttribute("message", "Không tìm thấy chapter với tên chứa: " + nameParam);
            }
        } else if (subjectIdParam != null && !subjectIdParam.isEmpty()) {
            try {
                int subjectId = Integer.parseInt(subjectIdParam);
                listChapter = chapterDAO.findChapterBySubjectId(subjectId);
                if (listChapter.isEmpty()) {
                    request.setAttribute("message", "Không tìm thấy chapter với subject_id = " + subjectId);
                }
            } catch (NumberFormatException e) {
                listChapter = List.of();
                request.setAttribute("message", "Định dạng subject_id không hợp lệ!");
            }
        } else {
            listChapter = List.of();
            request.setAttribute("message", "Không có tìm kiếm");
        }

        request.setAttribute("listChapter", listChapter);
        request.setAttribute("listSubject", listSubject != null ? listSubject : List.of());
        request.setAttribute("subjectMap", subjectMap != null ? subjectMap : new HashMap<Integer, String>());
        request.getRequestDispatcher("/chapter/listChapter.jsp").forward(request, response);
    }

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
