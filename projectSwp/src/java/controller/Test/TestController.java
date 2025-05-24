package controller.Test;

import DAO.TestDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Test;

import java.io.IOException;
import java.util.List;

@WebServlet("/test")
public class TestController extends HttpServlet {
    private TestDAO testDAO;

    @Override
    public void init() {
        testDAO = new TestDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        request.setAttribute("testList", testList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Test/Test.jsp");
        dispatcher.forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("test", new Test());
        request.setAttribute("editMode", false);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Test/Test.jsp");
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
            request.setAttribute("editMode", true);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Test/Test.jsp");
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
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Test/Test.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID không hợp lệ");
            listTests(request, response);
        }
    }
}
