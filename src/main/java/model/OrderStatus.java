package model;

public class OrderStatus {
    private int orderStatusId;
    private String name;
    private String description;

    public OrderStatus() {
    }

    public OrderStatus(int orderStatusId, String name, String description) {
        this.orderStatusId = orderStatusId;
        this.name = name;
        this.description = description;
    }

    public int getOrderStatusId() {
        return orderStatusId;
    }

    public void setOrderStatusId(int orderStatusId) {
        this.orderStatusId = orderStatusId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
