package com.santander.testService;



import com.santander.model.StatusTracker;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

/**
 * JPA repository connection for {@link StatusTracker} entity.
 */
@ApplicationScoped
public class StatusTrackerRepository implements PanacheRepository<StatusTracker> {

}
