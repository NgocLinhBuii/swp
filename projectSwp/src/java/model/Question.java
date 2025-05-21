package model;

public class Question {
    private int id;
    private String question; // Trước đây là name
    private int image_id;
    private int lesson_id;

    public Question() {
    }

    public Question(int id, String question, int image_id, int lesson_id) {
        this.id = id;
        this.question = question;
        this.image_id = image_id;
        this.lesson_id = lesson_id;
    }

    public int getId() {
        return id;
    }

    public String getQuestion() {
        return question;
    }

    public int getImage_id() {
        return image_id;
    }

    public int getLesson_id() {
        return lesson_id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public void setImage_id(int image_id) {
        this.image_id = image_id;
    }

    public void setLesson_id(int lesson_id) {
        this.lesson_id = lesson_id;
    }
}
