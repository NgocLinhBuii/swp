/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AccountDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import model.Account;

/**
 *
 * @author BuiNgocLinh
 */
@WebServlet("/accounts")
public class AccountController extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        try {
            List<Account> accountList;
            if (email != null && !email.trim().isEmpty()) {
                accountList = accountDAO.findByEmail(email.trim());
                if (accountList == null || accountList.isEmpty()) {
                    req.setAttribute("error", "Không tìm thấy tài khoản nào với email: " + email.trim());
                }
            } else {
                accountList = accountDAO.findAll();
            }
            req.setAttribute("accountList", accountList);
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Error when retrieving accounts");
        }
        RequestDispatcher dispatcher = req.getRequestDispatcher("accountList.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String status = req.getParameter("status");
        String role = req.getParameter("role");
        String full_name = req.getParameter("full_name");
        Integer sex = (req.getParameter("sex") != null && !req.getParameter("sex").isEmpty()) ? Integer.parseInt(req.getParameter("sex")) : null;
        String dobStr = req.getParameter("dob");
        LocalDate dob = null;

        if (dobStr != null && !dobStr.isEmpty()) {
            dob = LocalDate.parse(dobStr);
        }
        Integer image_id = (req.getParameter("image_id") != null && !req.getParameter("image_id").isEmpty()) ? Integer.parseInt(req.getParameter("image_id")) : null;

        Account account = new Account();
        account.setEmail(email);
        account.setPassword(password);
        account.setStatus(status);
        account.setRole(role);
        account.setFull_name(full_name);
        account.setSex(sex);
        account.setDob(dob);
        account.setImage_id(image_id);

        try {
            boolean inserted = accountDAO.insert(account);
            if (inserted) {
                resp.sendRedirect("accounts?email=" + email);
            } else {
                req.setAttribute("error", "Failed to insert account");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "SQL Error");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }
}
