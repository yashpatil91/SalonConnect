package com.model;

import java.sql.Timestamp;

public class Therapist {

	// ===== Primary Keys =====
	private int id;
	private int userId;
	private Integer salonId;
	private String salonName;


	// ===== Profile =====
	private String name;
	private String specialization;
	private int experience;
	private String phone;
	private double rating;
	private String imageUrl;

	// ===== Status =====
	private String status; // PENDING / APPROVED / REJECTED

	// ===== Meta =====
	private String email;
	public String getSalonName() {
		return salonName;
	}

	public void setSalonName(String salonName) {
		this.salonName = salonName;
	}

	private Timestamp createdAt;

	public Therapist() {
	}

	// ===== Getters & Setters =====

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Integer getSalonId() {
		return salonId;
	}

	public void setSalonId(Integer salonId) {
		this.salonId = salonId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSpecialization() {
		return specialization;
	}

	public void setSpecialization(String specialization) {
		this.specialization = specialization;
	}

	public int getExperience() {
		return experience;
	}

	public void setExperience(int experience) {
		this.experience = experience;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
}
