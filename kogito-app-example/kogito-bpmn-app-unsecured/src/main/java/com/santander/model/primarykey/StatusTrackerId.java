package com.santander.model.primarykey;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

/**
 * The embedded id of the {@link StatusTracker} entity.
 */
@Embeddable
public class StatusTrackerId implements Serializable {
	private Long id;
	private String center;
	private String entity;
	private Long caseId;

	public StatusTrackerId() {
	}

	public StatusTrackerId(Long id, String center, String entity, Long caseId) {
		this.id = id;
		this.center = center;
		this.entity = entity;
		this.caseId = caseId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCenter() {
		return center;
	}

	public void setCenter(String center) {
		this.center = center;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public Long getCaseId() {
		return caseId;
	}

	public void setCaseId(Long caseId) {
		this.caseId = caseId;
	}

	@Override
	public String toString() {
		return "StatusTrackerId{" +
						"id=" + id +
						", center='" + center + '\'' +
						", entity='" + entity + '\'' +
						", caseId=" + caseId +
						'}';
	}
}
