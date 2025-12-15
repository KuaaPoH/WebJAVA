package model;

import java.util.Date;

public class TourReview {
    private int productReviewId;
    private String name;
    private String phone;
    private String email;
    private Date createdDate;
    private String detail;
    private int star;
    private int productId;
    private boolean isActive;
    private String image;
    private String tourName;

    public TourReview() {
    }

    public TourReview(int productReviewId, String name, String phone, String email, Date createdDate, String detail, int star, int productId, boolean isActive, String image) {
        this.productReviewId = productReviewId;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.createdDate = createdDate;
        this.detail = detail;
        this.star = star;
        this.productId = productId;
        this.isActive = isActive;
        this.image = image;
    }

    public int getProductReviewId() {
        return productReviewId;
    }

    public void setProductReviewId(int productReviewId) {
        this.productReviewId = productReviewId;
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

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTourName() {
        return tourName;
    }

    public void setTourName(String tourName) {
        this.tourName = tourName;
    }
}
