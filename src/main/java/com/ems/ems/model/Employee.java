package com.ems.ems.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;


import java.time.LocalDate;

@Entity
@Table(name = "employees")
@Getter
@Setter
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @NotBlank
    @Column(name = "name", nullable = false)
    private String name;

    @Email
    @NotBlank
    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @NotBlank
    @Column(name = "department", nullable = false)
    private String department;

    @NotBlank
    @Column(name = "designation", nullable = false)
    private String designation;

    @Column(name = "joining_date")
    private LocalDate joiningDate;

    @NotNull
    @Column(name = "salary", nullable = false)
    private Double salary;
}
