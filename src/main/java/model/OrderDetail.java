package model;

public class OrderDetail {
    private int orderDetailId;
    private int orderId;
    private int tourId;
    private double price; // decimal(18, 0) fits in double
    private int quantity;

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailId, int orderId, int tourId, double price, int quantity) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.tourId = tourId;
        this.price = price;
        this.quantity = quantity;
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
}
