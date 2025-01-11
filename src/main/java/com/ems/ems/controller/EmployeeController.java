package com.ems.ems.controller;

import com.ems.ems.model.Employee;
import com.ems.ems.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/employees")
public class EmployeeController {

    @Autowired
    private EmployeeService service;

    @GetMapping
    public String getEmployees(Model model,
                               @RequestParam(name = "page", defaultValue = "1") int page,
                               @RequestParam(name = "size", defaultValue = "10") int size) {
        try {
            Page<Employee> employeesPage = service.getEmployees(PageRequest.of(page - 1, size));
            model.addAttribute("employees", employeesPage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", employeesPage.getTotalPages());
            return "employeeList";
        } catch (Exception ex) {
            model.addAttribute("errorMessage", "An error occurred while fetching employees: " + ex.getMessage());
            return "error";
        }
    }

    @GetMapping("/getByName")
    public String getByName(@RequestParam String name, @RequestParam(name = "page", defaultValue = "1") int page,
                            @RequestParam(name = "size", defaultValue = "10") int size,
                            Model model) {
        try {
            Page<Employee> employeePage = service.getByName(name, PageRequest.of(page - 1, size));
            model.addAttribute("employees", employeePage.getContent());
            return "employeeList";
        } catch (Exception ex) {
            model.addAttribute("errorMessage", "An error occurred while fetching employees by name: " + ex.getMessage());
            return "error";
        }
    }

    @GetMapping("/find")
    public String getByDepartment(@RequestParam String department, @RequestParam(name = "page", defaultValue = "1") int page,
                                  @RequestParam(name = "size", defaultValue = "10") int size,
                                  Model model) {
        try {
            Page<Employee> employeePage = service.getByDepartment(department, PageRequest.of(page - 1, size));
            model.addAttribute("employees", employeePage.getContent());
            return "employeeList";
        } catch (Exception ex) {
            model.addAttribute("errorMessage", "An error occurred while fetching employees by department: " + ex.getMessage());
            return "error";
        }
    }

    @PostMapping("/add")
    public String addEmployee(@ModelAttribute Employee employee, Model model) {
        try {
            service.saveEmployee(employee);
            return "redirect:/employees";
        } catch (Exception ex) {
            model.addAttribute("errorMessage", "An error occurred while adding the employee: " + ex.getMessage());
            return "error";
        }
    }

    @PostMapping("/update")
    public String updateEmployee(@ModelAttribute Employee employee, Model model) {
        try {
            service.updateEmployee(employee.getId(), employee);
            return "redirect:/employees";
        } catch (Exception ex) {
            model.addAttribute("errorMessage", "An error occurred while updating the employee: " + ex.getMessage());
            return "error";
        }
    }

    @PostMapping("/delete/{id}")
    public String deleteEmployee(@PathVariable Long id, Model model) {
        try {
            service.deleteEmployee(id);
            return "redirect:/employees";
        } catch (Exception ex) {
            model.addAttribute("errorMessage", "An error occurred while deleting the employee: " + ex.getMessage());
            return "error";
        }
    }

}
