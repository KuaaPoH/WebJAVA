package model;

import java.util.Date;

public class Customer {
    private int customerId;
    private String username;
    private String password;
    private Date birthday;
    private String avatar;
    private String phone;
    private String email;
    private int locationId;
    private Date lastLogin;
    private boolean isActive;

    public Customer() {
    }

    public Customer(int customerId, String username, String password, Date birthday, String avatar, String phone, String email, int locationId, Date lastLogin, boolean isActive) {
        this.customerId = customerId;
        this.username = username;
        this.password = password;
        this.birthday = birthday;
        this.avatar = avatar;
        this.phone = phone;
        this.email = email;
        this.locationId = locationId;
        this.lastLogin = lastLogin;
        this.isActive = isActive;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public Date getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }

    public boolean isActive() {
        return isActive;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
