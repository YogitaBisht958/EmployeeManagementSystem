package com.ems.ems.service;

import com.ems.ems.exception.ResourceNotFoundException;
import com.ems.ems.model.Employee;
import com.ems.ems.repo.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository repository;

    public Page<Employee> getEmployees(Pageable pageable) {
        return repository.findAll(pageable);
    }

    public Employee updateEmployee(Long id, Employee employee) {
        Employee emp = repository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Employee not found with id " + id));

        emp.setName(employee.getName());
        emp.setEmail(employee.getEmail());
        emp.setDepartment(employee.getDepartment());
        emp.setDesignation(employee.getDesignation());
        emp.setJoiningDate(employee.getJoiningDate());
        emp.setSalary(employee.getSalary());
        return repository.save(emp);
    }

    public Employee saveEmployee(Employee employee) {
        return repository.save(employee);
    }

    public Page<Employee> getByName(String name, Pageable pageable) {
        return repository.findByName(name, pageable);
    }

    public Page<Employee> getByDepartment(String department, Pageable pageable) {
        return repository.findByDepartment(department, pageable);
    }

    public void deleteEmployee(Long id) {
        if (!repository.existsById(id)) {
            throw new ResourceNotFoundException("Employee not found with id " + id);
        }
        repository.deleteById(id);
    }
}
