package controller;

import dal.MenuDAO;
import model.Menu;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "MenuServlet", urlPatterns = {"/admin/quanlymenu"})
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteMenu(request, response);
                break;
            case "toggle":
                toggleMenuStatus(request, response);
                break;
            default:
                listMenus(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "insert":
                insertMenu(request, response);
                break;
            case "update":
                updateMenu(request, response);
                break;
            default:
                listMenus(request, response);
                break;
        }
    }

    private void listMenus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MenuDAO dao = new MenuDAO();
        List<Menu> list = dao.getAllMenus();
        
        // Create a map of MenuId -> Menu Title for easy lookup
        Map<Integer, String> menuMap = new HashMap<>();
        for (Menu m : list) {
            menuMap.put(m.getMenuId(), m.getTitle());
        }
        
        request.setAttribute("listM", list);
        request.setAttribute("menuMap", menuMap);
        request.getRequestDispatcher("/admin/quanlymenu/index.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MenuDAO dao = new MenuDAO();
        List<Menu> allMenus = dao.getAllMenus();
        request.setAttribute("allMenus", allMenus);
        request.getRequestDispatcher("/admin/quanlymenu/add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            MenuDAO dao = new MenuDAO();
            Menu existingMenu = dao.getMenuById(id);
            List<Menu> allMenus = dao.getAllMenus();
            
            request.setAttribute("menu", existingMenu);
            request.setAttribute("allMenus", allMenus);
            request.getRequestDispatcher("/admin/quanlymenu/edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/quanlymenu");
        }
    }

    private void insertMenu(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String title = request.getParameter("title");
            String alias = request.getParameter("alias");
            int position = Integer.parseInt(request.getParameter("position"));
            int parentId = Integer.parseInt(request.getParameter("parentId"));
            int levels = Integer.parseInt(request.getParameter("levels"));
            boolean isActive = "on".equals(request.getParameter("active"));

            Menu menu = new Menu();
            menu.setTitle(title);
            menu.setAlias(alias);
            menu.setPosition(position);
            menu.setParentId(parentId);
            menu.setLevels(levels);
            menu.setActive(isActive);

            MenuDAO dao = new MenuDAO();
            dao.insert(menu);
            response.sendRedirect(request.getContextPath() + "/admin/quanlymenu");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/quanlymenu?action=create&error=true");
        }
    }

    private void updateMenu(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String alias = request.getParameter("alias");
            int position = Integer.parseInt(request.getParameter("position"));
            int parentId = Integer.parseInt(request.getParameter("parentId"));
            int levels = Integer.parseInt(request.getParameter("levels"));
            boolean isActive = "on".equals(request.getParameter("active"));

            Menu menu = new Menu();
            menu.setMenuId(id);
            menu.setTitle(title);
            menu.setAlias(alias);
            menu.setPosition(position);
            menu.setParentId(parentId);
            menu.setLevels(levels);
            menu.setActive(isActive);

            MenuDAO dao = new MenuDAO();
            dao.update(menu);
            response.sendRedirect(request.getContextPath() + "/admin/quanlymenu");
        } catch (NumberFormatException e) {
             response.sendRedirect(request.getContextPath() + "/admin/quanlymenu?action=edit&id=" + request.getParameter("id") + "&error=true");
        }
    }

    private void deleteMenu(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            MenuDAO dao = new MenuDAO();
            dao.delete(id);
        } catch (NumberFormatException e) {
            // Log or handle error
        }
        response.sendRedirect(request.getContextPath() + "/admin/quanlymenu");
    }

    private void toggleMenuStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            MenuDAO dao = new MenuDAO();
            dao.toggleStatus(id);
        } catch (NumberFormatException e) {
            // Log or handle error
        }
        response.sendRedirect(request.getContextPath() + "/admin/quanlymenu");
    }
}
