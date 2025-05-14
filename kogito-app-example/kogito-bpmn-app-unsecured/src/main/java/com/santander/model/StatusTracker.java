package com.santander.model;


import com.santander.model.primarykey.StatusTrackerId;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;

import java.util.Date;

;

/**
 * Entity class for status tracker table.
 */
@Entity
@Table(name = "PR_PAAS_CASE_STATUS_TRACKER")
@IdClass(StatusTrackerId.class)
public class StatusTracker {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "status_tracker_seq")
	@SequenceGenerator(name = "status_tracker_seq", sequenceName = "pr_paas_case_status_tracker_sq", allocationSize = 1)
	@Column(name = "STATUS_TRACKER_ID")
	private Long id;

	@Id
	@Column(name = "PR_ENTITY")
	private String entity;

	@Id
	@Column(name = "ID_CENTER")
	private String center;

	@Id
	@Column(name = "PR_CASE")
	private Long caseId;

	@Column(name = "PR_STATUS")
	private Integer statusId;

	@Column(name = "PR_STATUS_START_TS")
	private Date startDate;

	@Column(name = "PR_STATUS_START_USER")
	private String startUser;

	@Column(name = "PR_STATUS_END_TS")
	private Date endDate;

	@Column(name = "PR_STATUS_END_USER")
	private String endUser;

	@Column(name = "PR_STATUS_ACCESSPOINT_START")
	private Integer startAccessPointId;

	@Column(name = "PR_AP_DEVICE_START")
	private String startAPDevice;

	@Column(name = "PR_AP_OS_START")
	private String startAPOS;

	@Column(name = "PR_AP_TYPE_USER_START")
	private String startApTypeUser;

	@Column(name = "PR_AP_APP_START")
	private String startApApp;

	@Column(name = "PR_STATUS_ACCESSPOINT_END")
	private Integer endAccessPointId;

	@Column(name = "PR_AP_DEVICE_END")
	private String endApDevice;

	@Column(name = "PR_AP_OS_END")
	private String endApOS;

	@Column(name = "PR_AP_TYPE_USER_END")
	private String endApTypeUser;

	@Column(name = "PR_AP_APP_END")
	private String endApApp;

	@Column(name = "IS_FINAL")
	private Boolean isFinal;

	@Column(name = "ID_PROCESS")
	private Integer processId;

	public StatusTracker() {
	}

	public StatusTracker(Long id, String entity, String center, Long caseId, Integer statusId, Date startDate,
                         String startUser, Date endDate, String endUser, Integer startAccessPointId, String startAPDevice, String startAPOS, String startApTypeUser, String startApApp, Integer endAccessPointId, String endApDevice, String endApOS, String endApTypeUser, String endApApp, Boolean isFinal, Integer processId) {
		this.id = id;
		this.entity = entity;
		this.center = center;
		this.caseId = caseId;
		this.statusId = statusId;
		this.startDate = startDate;
		this.startUser = startUser;
		this.endDate = endDate;
		this.endUser = endUser;
		this.startAccessPointId = startAccessPointId;
		this.startAPDevice = startAPDevice;
		this.startAPOS = startAPOS;
		this.startApTypeUser = startApTypeUser;
		this.startApApp = startApApp;
		this.endAccessPointId = endAccessPointId;
		this.endApDevice = endApDevice;
		this.endApOS = endApOS;
		this.endApTypeUser = endApTypeUser;
		this.endApApp = endApApp;
		this.isFinal = isFinal;
		this.processId = processId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public String getCenter() {
		return center;
	}

	public void setCenter(String center) {
		this.center = center;
	}

	public Long getCaseId() {
		return caseId;
	}

	public void setCaseId(Long caseId) {
		this.caseId = caseId;
	}

	public Integer getStatusId() {
		return statusId;
	}

	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public String getStartUser() {
		return startUser;
	}

	public void setStartUser(String startUser) {
		this.startUser = startUser;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getEndUser() {
		return endUser;
	}

	public void setEndUser(String endUser) {
		this.endUser = endUser;
	}

	public Integer getStartAccessPointId() {
		return startAccessPointId;
	}

	public void setStartAccessPointId(Integer startAccessPointId) {
		this.startAccessPointId = startAccessPointId;
	}

	public String getStartAPDevice() {
		return startAPDevice;
	}

	public void setStartAPDevice(String startAPDevice) {
		this.startAPDevice = startAPDevice;
	}

	public String getStartAPOS() {
		return startAPOS;
	}

	public void setStartAPOS(String startAPOS) {
		this.startAPOS = startAPOS;
	}

	public String getStartApTypeUser() {
		return startApTypeUser;
	}

	public void setStartApTypeUser(String startApTypeUser) {
		this.startApTypeUser = startApTypeUser;
	}

	public String getStartApApp() {
		return startApApp;
	}

	public void setStartApApp(String startApApp) {
		this.startApApp = startApApp;
	}

	public Integer getEndAccessPointId() {
		return endAccessPointId;
	}

	public void setEndAccessPointId(Integer endAccessPointId) {
		this.endAccessPointId = endAccessPointId;
	}

	public String getEndApDevice() {
		return endApDevice;
	}

	public void setEndApDevice(String endApDevice) {
		this.endApDevice = endApDevice;
	}

	public String getEndApOS() {
		return endApOS;
	}

	public void setEndApOS(String endApOS) {
		this.endApOS = endApOS;
	}

	public String getEndApTypeUser() {
		return endApTypeUser;
	}

	public void setEndApTypeUser(String endApTypeUser) {
		this.endApTypeUser = endApTypeUser;
	}

	public String getEndApApp() {
		return endApApp;
	}

	public void setEndApApp(String endApApp) {
		this.endApApp = endApApp;
	}

	public Boolean getFinal() {
		return isFinal;
	}

	public void setFinal(Boolean aFinal) {
		isFinal = aFinal;
	}

	public Integer getProcessId() {
		return processId;
	}

	public void setProcessId(Integer processId) {
		this.processId = processId;
	}

	@Override
	public String toString() {
		return "StatusTracker{" +
						"id=" + id +
						", entity='" + entity + '\'' +
						", center='" + center + '\'' +
						", caseId=" + caseId +
						", statusId=" + statusId +
						", startDate=" + startDate +
						", startUser='" + startUser + '\'' +
						", endDate=" + endDate +
						", endUser='" + endUser + '\'' +
						", startAccessPointId=" + startAccessPointId +
						", startAPDevice='" + startAPDevice + '\'' +
						", startAPOS='" + startAPOS + '\'' +
						", startApTypeUser='" + startApTypeUser + '\'' +
						", startApApp='" + startApApp + '\'' +
						", endAccessPointId=" + endAccessPointId +
						", endApDevice='" + endApDevice + '\'' +
						", endApOS='" + endApOS + '\'' +
						", endApTypeUser='" + endApTypeUser + '\'' +
						", endApApp='" + endApApp + '\'' +
						", isFinal=" + isFinal +
						", processId=" + processId +
						'}';
	}
}
