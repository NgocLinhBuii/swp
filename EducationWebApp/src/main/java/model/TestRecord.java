/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;

/**
 *
 * @author BuiNgocLinh
 */
public class TestRecord {

    private int id;
    private int student_id;
    private int test_id;
    private LocalDate started_at;
    private LocalDate finish_at;
    private double score;

    public TestRecord() {
    }

    public TestRecord(int id, int student_id, int test_id, LocalDate started_at, LocalDate finish_at, double score) {
        this.id = id;
        this.student_id = student_id;
        this.test_id = test_id;
        this.started_at = started_at;
        this.finish_at = finish_at;
        this.score = score;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStudent_id() {
        return student_id;
    }

    public void setStudent_id(int student_id) {
        this.student_id = student_id;
    }

    public int getTest_id() {
        return test_id;
    }

    public void setTest_id(int test_id) {
        this.test_id = test_id;
    }

    public LocalDate getStarted_at() {
        return started_at;
    }

    public void setStarted_at(LocalDate started_at) {
        this.started_at = started_at;
    }

    public LocalDate getFinish_at() {
        return finish_at;
    }

    public void setFinish_at(LocalDate finish_at) {
        this.finish_at = finish_at;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }
    
    
}
