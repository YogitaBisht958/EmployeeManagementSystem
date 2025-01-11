package com.ems.ems.repo;

import com.ems.ems.model.Employee;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;


public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    Page<Employee> findByName(String name, Pageable pageable);

    Page<Employee> findByDepartment(String department, Pageable pageable);
    Page<Employee> findAll(Pageable pageable);
}