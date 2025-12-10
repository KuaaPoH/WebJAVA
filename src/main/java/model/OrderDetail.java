package model;

import java.util.Date;

public class OrderDetail {
    private int orderDetailId;
    private int orderId;
    private int tourId;
    private double price; // decimal(18, 0) fits in double
    private int quantity;
    private Date departureDate;

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailId, int orderId, int tourId, double price, int quantity, Date departureDate) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.tourId = tourId;
        this.price = price;
        this.quantity = quantity;
        this.departureDate = departureDate;
    }

    public Date getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(Date departureDate) {
        this.departureDate = departureDate;
    }

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    private String tourName;
    private String image;
    
    public String getTourName() { return tourName; }
    public void setTourName(String tourName) { this.tourName = tourName; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}
