package controller.test;

import dal.TestDAO;
import dal.CategoryDAO;  // thêm import này
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Test;
import model.Category;  // category model bạn phải có

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import util.AuthUtil;
import util.RoleConstants;

@WebServlet("/test")
public class TestController extends HttpServlet {
    private TestDAO testDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        testDAO = new TestDAO();
        categoryDAO = new CategoryDAO();  // khởi tạo DAO category
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         if (!AuthUtil.hasRole(request, RoleConstants.STUDENT)) {
            response.sendRedirect("/error.jsp");
            return;
        }
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("test");
            return;
        }

        switch (action) {
            case "add":
                addTest(request, response);
                break;
            case "update":
                updateTest(request, response);
                break;
            default:
                response.sendRedirect("test");
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         if (!AuthUtil.hasRole(request, RoleConstants.STUDENT)) {
            response.sendRedirect("/error.jsp");
            return;
        }
        String action = request.getParameter("action");

        if (action == null) {
            listTests(request, response);
        } else {
            switch (action) {
                case "create":
                    showCreateForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteTest(request, response);
                    break;
                case "search":
                    searchTestById(request, response);
                    break;
                default:
                    listTests(request, response);
                    break;
            }
        }
    }

    private void listTests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Test> testList = testDAO.getAllTests();
        Map<Integer, String> categoryMap = getCategoryMap();

        request.setAttribute("testList", testList);
        request.setAttribute("categoryMap", categoryMap); // gửi map category id -> name

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Test/testList.jsp");
        dispatcher.forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("test", new Test());
        Map<Integer, String> categoryMap = getCategoryMap();
        request.setAttribute("categoryMap", categoryMap);  // cần gửi categoryMap để chọn category khi tạo mới

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Test/addTest.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Test test = testDAO.getTestById(id);
            if (test == null) {
                request.setAttribute("error", "Test không tồn tại!");
                listTests(request, response);
                return;
            }
            request.setAttribute("test", test);

            Map<Integer, String> categoryMap = getCategoryMap();
            request.setAttribute("categoryMap", categoryMap);  // gửi categoryMap để chọn category khi sửa

            RequestDispatcher dispatcher = request.getRequestDispatcher("/Test/updateTest.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID không hợp lệ");
            listTests(request, response);
        }
    }

    private void addTest(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        boolean practice = "true".equals(request.getParameter("practice"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        Test test = new Test(0, name, description, practice, categoryId);
        testDAO.addTest(test);
        response.sendRedirect("test");
    }

    private void updateTest(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        boolean practice = "true".equals(request.getParameter("practice"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        Test test = new Test(id, name, description, practice, categoryId);
        testDAO.updateTest(test);
        response.sendRedirect("test");
    }

    private void deleteTest(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        testDAO.deleteTest(id);
        response.sendRedirect("test");
    }

    private void searchTestById(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Test test = testDAO.getTestById(id);
            request.setAttribute("testList", test != null ? List.of(test) : List.of());

            Map<Integer, String> categoryMap = getCategoryMap();
            request.setAttribute("categoryMap", categoryMap);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/Test/testList.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID không hợp lệ");
            listTests(request, response);
        }
    }

    // Hàm lấy map categoryId -> categoryName
    private Map<Integer, String> getCategoryMap() {
        Map<Integer, String> categoryMap = new HashMap<>();
        List<Category> categoryList = categoryDAO.getAllCategories();
        for (Category c : categoryList) {
            categoryMap.put(c.getId(), c.getName());
        }
        return categoryMap;
    }
}
