<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        /* General Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-top: 30px;
        }
        .container {
            max-width: 1100px;
            margin: 30px auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 20px;
        }
        .form-group input, .form-group select {
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            padding: 10px 15px;
            font-size: 14px;
            border: none;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #eaf4ff;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
        }
        .modal-content form {
            display: flex;
            flex-direction: column;
        }
        .modal-content form input,
        .modal-content form select {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .modal-content form button {
            align-self: flex-end;
        }
        .close-modal {
            cursor: pointer;
            background: none;
            border: none;
            font-size: 1.2rem;
            color: #999;
            position: absolute;
            top: 10px;
            right: 10px;
        }


    </style>
</head>
<body>
    <h1>Employee Management</h1>
    <div class="container">
        <!-- Search and Filter -->
        <div class="form-group">
            <form method="GET" action="/employees/getByName" style="display: flex; align-items: center;">
                <input type="text" name="name" placeholder="Search by Name" />
                <button type="submit"><i class="fas fa-search"></i> Search</button>
            </form>
            <form method="GET" action="/employees/find" style="display: flex; align-items: center; margin-left: 20px;">
                <select name="department">
                    <option value="" disabled selected>Filter by Department</option>
                    <option value="HR">HR</option>
                    <option value="Finance">Finance</option>
                    <option value="Engineering">Engineering</option>
                </select>
                <button type="submit"><i class="fas fa-filter"></i> Filter</button>
            </form>
        </div>

        <!-- Add Employee Button -->
        <button onclick="openAddModal()">Add Employee</button>

        <!-- Employee Table -->
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Department</th>
                    <th>Designation</th>
                    <th>Salary</th>
                    <th>Joining Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="employee" items="${employees}">
                    <tr>
                        <td>${employee.name}</td>
                        <td>${employee.email}</td>
                        <td>${employee.department}</td>
                        <td>${employee.designation}</td>
                        <td>${employee.salary}</td>
                        <td>${employee.joiningDate}</td>
                        <td>
                            <button onclick="openEditModal(
                                ${employee.id},
                                '${employee.name}',
                                '${employee.email}',
                                '${employee.department}',
                                '${employee.designation}',
                                ${employee.salary},
                                '${employee.joiningDate}'
                            )">Edit</button>
                            <form action="/employees/delete/${employee.id}" method="POST" style="display:inline;"
                                <input type="hidden" name="_method" value="DELETE" />
                                <button type="submit">Delete</button>
                            </form>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <!-- Add Employee Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <button class="close-modal" onclick="closeAddModal()">×</button>
            <h3>Add Employee</h3>
            <form name="addEmployeeForm" action="/employees/add" method="POST" onsubmit="return validateAddForm()">
                <input type="text" name="name" placeholder="Name" required />
                <input type="email" name="email" placeholder="Email" required />
                <select name="department" required>
                    <option value="" placeholder="Select Department" disabled selected>Select Department</option>
                    <option value="HR">HR</option>
                    <option value="Finance">Finance</option>
                    <option value="Engineering">Engineering</option>
                </select>
                <input type="text" name="designation" placeholder="Designation" required />
                <input type="number" name="salary" placeholder="Salary" required />
                <input type="date" name="joiningDate" placeholder="Joining Date" required />
                <button type="submit">Add Employee</button>
            </form>
        </div>
    </div>

    <!-- Edit Employee Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <button class="close-modal" onclick="closeEditModal()">×</button>
            <h3>Edit Employee</h3>
            <form name="editEmployeeForm" action="/employees/update" method="POST" onsubmit="return validateEditForm()">
                <input type="hidden" id="editEmployeeId" name="id" />
                <input type="text" id="editName" name="name" placeholder="Name" required />
                <input type="email" id="editEmail" name="email" placeholder="Email" required />
                <select id="editDepartment" name="department" required>
                    <option placeholder="Select Department" value="" disabled>Select Department</option>
                    <option value="HR">HR</option>
                    <option value="Finance">Finance</option>
                    <option value="Engineering">Engineering</option>
                </select>
                <input type="text" id="editDesignation" name="designation" placeholder="Designation" required />
                <input type="number" id="editSalary" name="salary" placeholder="Salary" required />
                <input type="date" id="editJoiningDate" name="joiningDate" placeholder="Joining Date" required />
                <button type="submit">Update Employee</button>
            </form>
        </div>
    </div>

    <!-- Pagination Controls -->
     <div style="text-align: center; margin-top: 0px; margin-botton: 10px;">
         <c:if test="${currentPage > 1}">
             <a style="padding: 13px" href="?page=${currentPage - 1}&size=10">Previous</a>
         </c:if>

         <c:forEach begin="1" end="${totalPages}" var="pageNum">
             <a href="?page=${pageNum}&size=10"
                style=" padding: 13px; ${currentPage == pageNum ? 'font-weight: bold;' : ''}">
                 ${pageNum}
             </a>
         </c:forEach>

         <c:if test="${currentPage < totalPages}">
             <a style="padding: 13px;"href="?page=${currentPage + 1}&size=10">Next</a>
         </c:if>
     </div>

    <script>
       function validateAddForm() {
               const name = document.forms["addEmployeeForm"]["name"].value.trim();
               const email = document.forms["addEmployeeForm"]["email"].value.trim();
               const department = document.forms["addEmployeeForm"]["department"].value;
               const designation = document.forms["addEmployeeForm"]["designation"].value.trim();
               const salary = document.forms["addEmployeeForm"]["salary"].value.trim();
               const joiningDate = document.forms["addEmployeeForm"]["joiningDate"].value;

               if (name === "") {
                   alert("Name is required.");
                   return false;
               }
               if (!validateEmail(email)) {
                   alert("Invalid email format.");
                   return false;
               }
               if (department === "") {
                   alert("Please select a department.");
                   return false;
               }
               if (designation === "") {
                   alert("Designation is required.");
                   return false;
               }
               if (salary === "" || isNaN(salary) || salary <= 0) {
                   alert("Please enter a valid salary.");
                   return false;
               }
               if (joiningDate === "") {
                   alert("Joining date is required.");
                   return false;
               }
               return true;
         }

       function validateEditForm() {
           const name = document.forms["editEmployeeForm"]["name"].value.trim();
           const email = document.forms["editEmployeeForm"]["email"].value.trim();
           const department = document.forms["editEmployeeForm"]["department"].value;
           const designation = document.forms["editEmployeeForm"]["designation"].value.trim();
           const salary = document.forms["editEmployeeForm"]["salary"].value.trim();
           const joiningDate = document.forms["editEmployeeForm"]["joiningDate"].value;

           if (name === "") {
               alert("Name is required.");
               return false;
           }
           if (!validateEmail(email)) {
               alert("Invalid email format.");
               return false;
           }
           if (department === "") {
               alert("Please select a department.");
               return false;
           }
           if (designation === "") {
               alert("Designation is required.");
               return false;
           }
           if (salary === "" || isNaN(salary) || salary <= 0) {
               alert("Please enter a valid salary.");
               return false;
           }
           if (joiningDate === "") {
               alert("Joining date is required.");
               return false;
           }
           return true;
       }



        function validateEmail(email) {
           const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
           return emailRegex.test(email);
        }
        function openAddModal() {
            document.getElementById('addModal').style.display = 'flex';
        }
        function closeAddModal() {
            document.getElementById('addModal').style.display = 'none';
        }
        function openEditModal(id, name, email, department, designation, salary, joiningDate) {
            document.getElementById('editEmployeeId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editEmail').value = email;
            document.getElementById('editDepartment').value = department;
            document.getElementById('editDesignation').value = designation;
            document.getElementById('editSalary').value = salary;
            document.getElementById('editJoiningDate').value = joiningDate;
            document.getElementById('editModal').style.display = 'flex';
        }
        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }
    </script>
</body>
</html>