package model;

import java.util.Date;

public class Blog {
    private int blogId;
    private String title;
    private String alias;
    private int categoryId;
    private String description;
    private String detail;
    private String image;
    private String seoTitle;
    private String seoDescription;
    private String seoKeywords;
    private Date createdDate;
    private String createdBy;
    private Date modifiedDate;
    private String modifiedBy;
    private int accountId;
    private boolean isActive;
    private int dayCreated;
    private String monthCreated;
    private int countView;

    public Blog() {
    }

    public Blog(int blogId, String title, String alias, int categoryId, String description, String detail, String image, String seoTitle, String seoDescription, String seoKeywords, Date createdDate, String createdBy, Date modifiedDate, String modifiedBy, int accountId, boolean isActive, int dayCreated, String monthCreated, int countView) {
        this.blogId = blogId;
        this.title = title;
        this.alias = alias;
        this.categoryId = categoryId;
        this.description = description;
        this.detail = detail;
        this.image = image;
        this.seoTitle = seoTitle;
        this.seoDescription = seoDescription;
        this.seoKeywords = seoKeywords;
        this.createdDate = createdDate;
        this.createdBy = createdBy;
        this.modifiedDate = modifiedDate;
        this.modifiedBy = modifiedBy;
        this.accountId = accountId;
        this.isActive = isActive;
        this.dayCreated = dayCreated;
        this.monthCreated = monthCreated;
        this.countView = countView;
    }

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
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

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
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

    public String getSeoTitle() {
        return seoTitle;
    }

    public void setSeoTitle(String seoTitle) {
        this.seoTitle = seoTitle;
    }

    public String getSeoDescription() {
        return seoDescription;
    }

    public void setSeoDescription(String seoDescription) {
        this.seoDescription = seoDescription;
    }

    public String getSeoKeywords() {
        return seoKeywords;
    }

    public void setSeoKeywords(String seoKeywords) {
        this.seoKeywords = seoKeywords;
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

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public int getDayCreated() {
        return dayCreated;
    }

    public void setDayCreated(int dayCreated) {
        this.dayCreated = dayCreated;
    }

    public String getMonthCreated() {
        return monthCreated;
    }

    public void setMonthCreated(String monthCreated) {
        this.monthCreated = monthCreated;
    }

    public int getCountView() {
        return countView;
    }

    public void setCountView(int countView) {
        this.countView = countView;
    }
}
