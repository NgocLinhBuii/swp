package controller.category;

import dal.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import util.AuthUtil;
import util.RoleConstants;

import java.io.IOException;
import java.util.List;

@WebServlet("/category")
public class CategoryController extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // CHỈ CHO ADMIN VÀ TEACHER
        if (!AuthUtil.hasRole(request, RoleConstants.ADMIN) && !AuthUtil.hasRole(request, RoleConstants.TEACHER)) {
            response.sendRedirect("/error.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {
                case "addForm":
                    request.getRequestDispatcher("Category/addCategory.jsp").forward(request, response);
                    return;

                case "updateForm": {
                    String idStr = request.getParameter("id");
                    if (idStr != null) {
                        int id = Integer.parseInt(idStr);
                        Category category = categoryDAO.getCategoryById(id);
                        if (category != null) {
                            request.setAttribute("category", category);
                            request.getRequestDispatcher("Category/updateCategory.jsp").forward(request, response);
                            return;
                        } else {
                            request.setAttribute("error", "Không tìm thấy category với ID " + id);
                        }
                    } else {
                        request.setAttribute("error", "ID không hợp lệ");
                    }
                    break;
                }

                case "delete": {
                    if (!AuthUtil.hasRole(request, RoleConstants.ADMIN)) {
                        response.sendRedirect("/error.jsp");
                        return;
                    }
                    String delIdStr = request.getParameter("id");
                    if (delIdStr != null) {
                        int delId = Integer.parseInt(delIdStr);
                        categoryDAO.deleteCategory(delId);
                        response.sendRedirect("category");
                        return;
                    } else {
                        request.setAttribute("error", "ID không hợp lệ để xóa");
                    }
                    break;
                }

                default: {
                    String name = request.getParameter("name");
                    List<Category> categoryList;
                    if (name != null && !name.trim().isEmpty()) {
                        categoryList = categoryDAO.findByName(name.trim());
                        if (categoryList == null || categoryList.isEmpty()) {
                            request.setAttribute("error", "Không tìm thấy category nào với tên '" + name.trim() + "'");
                        }
                    } else {
                        categoryList = categoryDAO.getAllCategories();
                    }
                    request.setAttribute("categoryList", categoryList);
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý yêu cầu: " + e.getMessage());
        }

        request.getRequestDispatcher("Category/categoryList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // CHỈ CHO ADMIN
        if (!AuthUtil.hasRole(request, RoleConstants.ADMIN)) {
            response.sendRedirect("/error.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("insert".equalsIgnoreCase(action)) {
                String name = request.getParameter("name");
                int numQuestion = Integer.parseInt(request.getParameter("num_question"));
                int duration = Integer.parseInt(request.getParameter("duration"));

                Category category = new Category(0, name, numQuestion, duration);
                categoryDAO.addCategory(category);
                request.setAttribute("message", "Thêm category thành công");

            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                int numQuestion = Integer.parseInt(request.getParameter("num_question"));
                int duration = Integer.parseInt(request.getParameter("duration"));

                Category category = new Category(id, name, numQuestion, duration);
                categoryDAO.updateCategory(category);
                request.setAttribute("message", "Cập nhật category thành công");
            }

            List<Category> categoryList = categoryDAO.getAllCategories();
            request.setAttribute("categoryList", categoryList);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý dữ liệu: " + e.getMessage());
        }

        request.getRequestDispatcher("Category/categoryList.jsp").forward(request, response);
    }
}
