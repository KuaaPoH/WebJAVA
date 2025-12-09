package model;

public class Slide {
    private int slideID;
    private String title;
    private String alias;
    private String image;
    private boolean isActive;

    public Slide() {
    }

    public Slide(int slideID, String title, String alias, String image, boolean isActive) {
        this.slideID = slideID;
        this.title = title;
        this.alias = alias;
        this.image = image;
        this.isActive = isActive;
    }

    public int getSlideID() {
        return slideID;
    }

    public void setSlideID(int slideID) {
        this.slideID = slideID;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
