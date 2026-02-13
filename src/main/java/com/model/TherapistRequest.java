package com.model;

import java.sql.Timestamp;

public class TherapistRequest {

	private int id;
	private int therapistId;
	private int salonId;
	private String status;
	private Timestamp createdAt;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTherapistId() {
		return therapistId;
	}

	public void setTherapistId(int therapistId) {
		this.therapistId = therapistId;
	}

	public int getSalonId() {
		return salonId;
	}

	public void setSalonId(int salonId) {
		this.salonId = salonId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
}
