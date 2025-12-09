package model;

public class AdminUser {
    private int userId;
    private String userName;
    private String email;
    private String password;
    private boolean isActive;

    public AdminUser() {
    }

    public AdminUser(int userId, String userName, String email, String password, boolean isActive) {
        this.userId = userId;
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.isActive = isActive;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
