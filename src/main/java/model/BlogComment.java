package model;

import java.util.Date;

public class BlogComment {
    private int commentId;
    private String name;
    private String phone;
    private String email;
    private Date createdDate;
    private String detail;
    private int blogId;
    private boolean isActive;
    private String image;

    public BlogComment() {
    }

    public BlogComment(int commentId, String name, String phone, String email, Date createdDate, String detail, int blogId, boolean isActive, String image) {
        this.commentId = commentId;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.createdDate = createdDate;
        this.detail = detail;
        this.blogId = blogId;
        this.isActive = isActive;
        this.image = image;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
