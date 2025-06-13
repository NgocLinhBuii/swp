package controller.Test;

import dal.TestDAO;
import dal.CategoryDAO;
import dal.QuestionDAO;
import dal.TestQuestionDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Test;
import model.Category;
import model.Question;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import util.AuthUtil;
import util.RoleConstants;

@WebServlet("/test")
public class TestController extends HttpServlet {
    private TestDAO testDAO;
    private CategoryDAO categoryDAO;
    private QuestionDAO questionDAO;
    private TestQuestionDAO testQuestionDAO;

    @Override
    public void init() {
        testDAO = new TestDAO();
        categoryDAO = new CategoryDAO();
        questionDAO = new QuestionDAO();
        testQuestionDAO = new TestQuestionDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.hasRole(request, RoleConstants.STUDENT)
                && !AuthUtil.hasRole(request, RoleConstants.TEACHER)
                && !AuthUtil.hasRole(request, RoleConstants.ADMIN)) {
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
        if (!AuthUtil.hasRole(request, RoleConstants.STUDENT)
                && !AuthUtil.hasRole(request, RoleConstants.TEACHER)
                && !AuthUtil.hasRole(request, RoleConstants.ADMIN)) {
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
        request.setAttribute("categoryMap", categoryMap);
        if (AuthUtil.hasRole(request, RoleConstants.TEACHER)) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/teacher/manageTests.jsp");
            dispatcher.forward(request, response);
        } else if (AuthUtil.hasRole(request, RoleConstants.ADMIN)) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/manageTests.jsp");
            dispatcher.forward(request, response);
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Test/testList.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("test", new Test());
        Map<Integer, String> categoryMap = getCategoryMap();
        request.setAttribute("categoryMap", categoryMap);
        
        // Lấy danh sách câu hỏi cho form tạo test
        try {
            System.out.println("Đang lấy danh sách câu hỏi cho form tạo test");
            List<Question> questionList = questionDAO.findAllQuestion();
            System.out.println("Đã lấy được " + questionList.size() + " câu hỏi");
            request.setAttribute("questionList", questionList);
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy danh sách câu hỏi: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Không thể lấy danh sách câu hỏi: " + e.getMessage());
            request.setAttribute("questionList", new ArrayList<Question>());
        }
        
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
            request.setAttribute("categoryMap", categoryMap);

            // Lấy danh sách tất cả câu hỏi
            try {
                List<Question> questionList = questionDAO.findAllQuestion();
                request.setAttribute("questionList", questionList);

                // Lấy danh sách ID câu hỏi đã chọn cho test này
                List<Integer> selectedQuestionIds = testQuestionDAO.getQuestionIdsByTest(id);
                request.setAttribute("selectedQuestionIds", selectedQuestionIds);
            } catch (Exception e) {
                e.printStackTrace();
            }

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

        // Tạo và lưu test mới
        Test test = new Test(0, name, description, practice, categoryId);
        int testId = testDAO.addTest(test);
        
        // Lấy danh sách câu hỏi được chọn
        String[] questionIds = request.getParameterValues("questionIds");
        if (questionIds != null && questionIds.length > 0) {
            // Lưu các câu hỏi vào bảng test_question
            for (String questionIdStr : questionIds) {
                try {
                    int questionId = Integer.parseInt(questionIdStr);
                    testQuestionDAO.addTestQuestion(testId, questionId);
                } catch (NumberFormatException e) {
                    // Bỏ qua nếu không phải số
                }
            }
        }
        
        response.sendRedirect("test");
    }

    private void updateTest(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        boolean practice = "true".equals(request.getParameter("practice"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        // Cập nhật thông tin test
        Test test = new Test(id, name, description, practice, categoryId);
        testDAO.updateTest(test);
        
        // Xóa tất cả câu hỏi cũ của test
        testQuestionDAO.removeAllQuestionsFromTest(id);
        
        // Thêm lại các câu hỏi mới được chọn
        String[] questionIds = request.getParameterValues("questionIds");
        if (questionIds != null && questionIds.length > 0) {
            for (String questionIdStr : questionIds) {
                try {
                    int questionId = Integer.parseInt(questionIdStr);
                    testQuestionDAO.addTestQuestion(id, questionId);
                } catch (NumberFormatException e) {
                    // Bỏ qua nếu không phải số
                }
            }
        }
        
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
