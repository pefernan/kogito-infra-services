package com.santander.testService;



import com.santander.model.StatusTracker;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.PersistenceException;
import jakarta.transaction.Transactional;
import jakarta.validation.ConstraintViolationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@ApplicationScoped
public class StatusTrackerServiceImpl {

	private static final Logger LOG = LoggerFactory.getLogger(StatusTrackerServiceImpl.class);

	@Inject
	StatusTrackerRepository statusTrackerRepository;


	@Transactional(Transactional.TxType.REQUIRED)
	public final void createStatusTracker(String processId, String caseId, Boolean isFinal,
																				String userId) {

		var entitytoSave = new StatusTracker();
		entitytoSave.setProcessId(Integer.valueOf(processId));
		entitytoSave.setCaseId(Long.valueOf(caseId));
		entitytoSave.setFinal(isFinal);
		entitytoSave.setStartUser(userId);
		entitytoSave.setCenter("center");
		entitytoSave.setEntity("entity");
		entitytoSave.setEndUser(userId);

		try {
			statusTrackerRepository.persist(entitytoSave);
			LOG.info("Created successfully new status tracker for the case id {} and userId {}", caseId, userId);
		} catch (ConstraintViolationException | PersistenceException e) {
			LOG.error(e.getMessage(),e.getCause());

		}
	}

}
