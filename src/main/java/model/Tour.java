package model;

import java.util.Date;

public class Tour {
    private int tourId;
    private String title;
    private String alias;
    private int categoryTourId;
    private String description;
    private String detail;
    private String image;
    private int price;
    private int priceSale;
    private Date createdDate;
    private String createdBy;
    private Date modifiedDate;
    private String modifiedBy;
    private boolean isActive;
    private int star;
    private String location;
    private int timeTravel;

    public Tour() {
    }

    public Tour(int tourId, String title, String alias, int categoryTourId, String description, String detail, String image, int price, int priceSale, Date createdDate, String createdBy, Date modifiedDate, String modifiedBy, boolean isActive, int star, String location, int timeTravel) {
        this.tourId = tourId;
        this.title = title;
        this.alias = alias;
        this.categoryTourId = categoryTourId;
        this.description = description;
        this.detail = detail;
        this.image = image;
        this.price = price;
        this.priceSale = priceSale;
        this.createdDate = createdDate;
        this.createdBy = createdBy;
        this.modifiedDate = modifiedDate;
        this.modifiedBy = modifiedBy;
        this.isActive = isActive;
        this.star = star;
        this.location = location;
        this.timeTravel = timeTravel;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public int getCategoryTourId() {
        return categoryTourId;
    }

    public void setCategoryTourId(int categoryTourId) {
        this.categoryTourId = categoryTourId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getPriceSale() {
        return priceSale;
    }

    public void setPriceSale(int priceSale) {
        this.priceSale = priceSale;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getTimeTravel() {
        return timeTravel;
    }

    public void setTimeTravel(int timeTravel) {
        this.timeTravel = timeTravel;
    }
}
