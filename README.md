# PROBLEM SETS

---

## 🌐 Live Site

You can access the running web application and its problem sets via the following links:

- **Main Page / Homepage:** [http://web06.cs.ait.ac.th](http://web06.cs.ait.ac.th)
- **Problem Set 1:** [http://web06.cs.ait.ac.th/ps1](http://web06.cs.ait.ac.th/ps1)
- **Problem Set 2:** [http://web06.cs.ait.ac.th/ps2](http://web06.cs.ait.ac.th/ps2)
- **Problem Set 3:** [http://web06.cs.ait.ac.th/ps3](http://web06.cs.ait.ac.th/ps2)

<details>

<summary><strong>🧠 Problem Set 1 (click to expand)<strong></summary>

# AI News Aggregator

A Ruby on Rails web application that aggregates the latest Artificial Intelligence news from [MIT Technology Review – AI](https://www.technologyreview.com/topic/artificial-intelligence/) and [VentureBeat – AI](https://venturebeat.com/category/ai/).

This project is developed as part of **Problem Set 1: Basics** (Sept 2025).  
The goal is to set up a production-ready environment with Rails, PostgreSQL, and Docker.

---

## Features

Rails application served through Docker + Docker Compose
PostgreSQL as the database
Footer with:

- Page generation timestamp (server time)
- Current Rails environment
- Live UTC clock (auto-refresh every second with JavaScript)
  Error logging & stack trace output (intentional divide-by-zero test)
  Server-side news scraping from:
- MIT Technology Review (AI section)
- VentureBeat (AI section)

---

## Getting Started

### Prerequisites

[Docker](https://docs.docker.com/get-docker/) installed
[Docker Compose](https://docs.docker.com/compose/install/) installed

### Setup Instructions

1. Clone the repository:

bash
git clone git@gitlab.com:ait-fsad-2025/yolanda_sake/ai_news_aggregator.git
cd ai_news_aggregator

2. Build and start the services:

bash
docker-compose build
docker-compose up

3. Create and migrate the database:

bash
docker-compose run --rm web bin/rails db:create
docker-compose run --rm web bin/rails db:migrate

4. Visit the app at:

   http://localhost:3000

---

## Running Tests

Run the Rails test suite inside Docker:

bash
docker-compose run --rm web bundle exec rails test

---

## Deployment

The application can be deployed on any server that supports Docker and Docker Compose.  
For the assignment, the live version is hosted at:

[http://web06.cs.ait.ac.th/basics](http://web06.cs.ait.ac.th/basics)

---

## Credits

Assignment inspired by Software Engineering for Internet Applications (Andersson, Greenspun, Grumet)  
Adapted from FSAD’s 2022 by Dr. Matt Dailey  
Developed by: Team Yolanda Sake

---

</details>
<details>

<summary><strong>🧠 Problem Set 2 (click to expand)<strong></summary>

## 🧠 Tech Jokes Web App Exercises (1–5)

A simple yet powerful **Rails-based web application** that stores, manages, and personalizes a collection of technology-related jokes.
This project demonstrates **database-driven web development**, **MVC design**, and **user personalization via cookies**.

---

### 📁 Project Structure

```
ai_news_aggregator/
├── README.md
├── app/
│   ├── controllers/
│   │   ├── main_controller.rb      # Homepage with PS1 + PS2 links
│   │   ├── basics_controller.rb    # Problem Set 1
│   │   └── jokes_controller.rb     # Problem Set 2 (Tech Jokes)
│   ├── models/
│   │   └── joke.rb                 # Joke model with validations
│   └── views/
│       └── jokes/                  # Templates for index, form, search, etc.
├── db/
│   └── schema.rb                   # PostgreSQL schema
├── config/routes.rb                # Route definitions
└── docker-compose.yml              # Containerized Rails + Postgres setup
```

---

### 🧩 Features Implemented

#### 1️⃣ Joke Management

- Add new jokes via a **web form** (Joke text, Author, Category)
- Categories handled dynamically: select existing or define a new one
- Auto-incrementing joke IDs via ActiveRecord’s sequence objects

#### 2️⃣ Search Functionality

- Case-insensitive search using **PostgreSQL ILIKE**
- Searches both _joke text_ and _author name_
- Displays matching results with highlighted search term

#### 3️⃣ Personalization (Cookies)

- Users can “**kill**” a joke using a ✖ button
- Killed jokes **never reappear**, even after browser restart
- “Erase My Personalization” link appears only when active
- Cookie-based storage using **space-separated IDs**
- Cookie expiration: **1 year**
- Implemented using Rails controller + helper methods
- Efficient filtering with SQL `NOT IN (...)` query

#### 4️⃣ Export & Import

- Export jokes in **XML** and **JSON** formats
- Import jokes from another server’s XML export endpoint
- Demonstrates RESTful integration and external data handling

#### 5️⃣ Pagination

- Implemented for large joke lists
- Works seamlessly with search and personalization features

---

### 🧠 Technical Highlights

| Feature            | Description                                                           |
| ------------------ | --------------------------------------------------------------------- |
| **SQL Efficiency** | Filters jokes at DB-level using `NOT IN`, avoiding extra memory usage |
| **Cookie Logic**   | Space-separated list of joke IDs stored client-side                   |
| **Rails ORM**      | ActiveRecord automatically manages primary key sequences              |
| **Search**         | Uses `ILIKE` for case-insensitive matching across multiple fields     |
| **UI/UX**          | Clean, responsive interface with consistent styling                   |
| **Code Quality**   | Clear controller logic, minimal redundancy, and modular helpers       |

---

### 🧪 Implementation Evidence

#### A. Search Functionality

- ![alt text](images/image.png)
- ![alt text](images/image15.png)
- ![alt text](images/image16.png)
- ![alt text](images/image17.png)

#### B. Personalization Feature

- ![alt text](images/image18.png)
- ![alt text](images/image19.png)
- ![alt text](images/image-34.png)
- ![alt text](images/image20.png)
- ![alt text](images/image-35.png)

#### C. Technical Implementation

> 💡 ![alt text](images/image22.png) ![alt text](images/image23.png) ![alt text](images/image-32.png) ![alt text](images/image24.png) ![alt text](images/image25.png) ![alt text](images/image26.png)

---

### ⚙️ Setup Instructions

#### Using Docker

```bash
docker-compose up --build
```

App will run on `http://localhost:3000`

#### Without Docker

```bash
bundle install
rails db:create db:migrate
rails s
```

Then visit:
👉 `http://localhost:3000`

---

### 🧾 Bonus Section

- ![alt text](images/image-29.png)
- ![alt text](images/image-28.png)
- ![alt text](images/image-30.png)
- ![alt text](images/image-31.png)
- ![alt text](images/image21.png)

---

### 📎 Additional Notes

- Cookies are stored per browser — each user’s personalization is independent.
- Deleting browser cookies resets personalization.
- Data model allows expansion with more joke attributes in the future.

---

### 🖼️ Screenshots & Evidence

> 📸 _Insert screenshots and code evidence below as captured during testing. You may combine code and results in the same image where appropriate._

## 🧠 Database Systems Assignment — SQL Exercises (6–12)

### **Environment Setup**

- **Database:** PostgreSQL 16 (Dockerized)
- **Management Tool:** pgAdmin 4 (via container)
- **Host Machine:** macOS
- **Connection:**
  `psql -h localhost -p 5432 -U postgres -d postgres`

---

### **Exercise 6 — Creating and Loading `my_stocks`**

> Create a text file containing stock data (symbol, number of shares, and date acquired).
> Load the data into a `my_stocks` table using the `\copy` command.

- Data loaded successfully using a **tab-delimited text file**.
- Verified table contents after import.

📸 _Screenshot(s):_
![alt text](images/image14.png)

---

### **Exercise 7 — Creating `stock_prices` in One Statement**

> Using only one SQL statement, create a table `stock_prices` with columns:
> `symbol`, `quote_date`, and `price`.
> The data should come from `my_stocks`, with the date as current date and a nominal price.

📸 _Screenshot(s):_
![alt text](images/image-1.png)

---

### **Exercise 8 — Adding Value Column to `stock_prices`**

> Extend `stock_prices` with a new `value` column.
> Populate it with calculated values based on your chosen logic (e.g., ASCII sum).

📸 _Screenshot(s):_
![alt text](images/image-2.png)

---

### **Exercise 9 — Writing a Function `stock_value(symbol)`**

> Create a SQL function that computes a stock’s value
> as the **sum of ASCII codes of its letters**.

📸 _Screenshot(s):_
![alt text](images/image-3.png)
![alt text](images/image-4.png)

---

### **Exercise 10 — Updating `stock_prices` and Creating `portfolio_value()`**

> Use `stock_value()` to update existing rows in `stock_prices`.
> Then create another function `portfolio_value()` that returns the total value of the portfolio.

📸 _Screenshot(s):_
![alt text](images/image-5.png)
![alt text](images/image-6.png)
![alt text](images/image-7.png)

---

### **Exercise 11 — Identifying “Winner” Stocks**

> Insert a new row into `my_stocks` for each stock
> whose price is above the average price.
> New entries should have today’s date as acquisition date.

📸 _Screenshot(s):_
![alt text](images/image-8.png)
![alt text](images/image-9.png)
![alt text](images/image-10.png)
![alt text](images/image-11.png)

---

### **Exercise 12 — Creating the `stocks_i_like` View**

> Create a view named `stocks_i_like` based on your final query from Exercise 11.
> The view should show symbols, total shares, and total value
> for all stocks appearing more than once (i.e., the “winners”).

📸 _Screenshot(s):_
![alt text](images/image-12.png)
![alt text](images/image-13.png)

---

### **Reflection**

This exercise series covered:

- Data import using `\copy`
- Table creation and population via SQL-only methods
- Defining and using SQL functions
- Performing aggregate calculations
- Creating reusable views for reporting

Each step reinforced practical SQL concepts in a realistic workflow.

---

### **Files Included**

- [`my_stocks.txt`](./my_stocks.txt) — Source data file
- [`sql_commands.sql`](./sql_commands.sql) — SQL statements used

</details>

<details>

<summary><strong>🧠 Problem Set 3 (click to expand)<strong></summary>

## Project Tracker

A Rails-based project management application with user authentication and many-to-many relationships between projects and students.

---

### Features

- **User Authentication**: Secure login and registration system using Devise
- **Project Management**: Create, read, update, and delete projects with name and URL attributes
- **Student Management**: Manage student records with student ID and name
- **Team Assignment**: Add students to projects with many-to-many relationship support
- **BDD Testing**: Comprehensive test coverage using Cucumber with passing scenarios
- **Responsive UI**: Professional interface with consistent styling across all pages

---

### Technical Stack

- **Framework**: Ruby on Rails 7.1.5
- **Database**: PostgreSQL 15
- **Authentication**: Devise 4.9.4
- **Testing**: Cucumber, RSpec, FactoryBot, Launchy, database_cleaner
- **Deployment**: Docker + Docker Compose

---

### Database Schema

**Projects Table** (`ps3_projects`)

- name (string)
- url (string)

**Students Table** (`ps3_students`)

- studentid (string)
- name (string)

**Join Table** (`ps3_project_students`)

- ps3_project_id (references)
- ps3_student_id (references)

**Users Table** (`users`)

- Managed by Devise with standard authentication fields

---

### Access

The application is protected by authentication. Users must sign up or log in to access project and student management features.

**Routes:**

- Main application: `http://localhost:3000/ps3`
- Projects index: `http://localhost:3000/ps3/ps3_projects`
- Students index: `http://localhost:3000/ps3/ps3_students`

---

### Testing

#### Behavior-Driven Development (BDD) with Cucumber

Run Cucumber tests:

```bash
docker-compose exec web bundle exec cucumber
```

All BDD scenarios pass with complete test coverage for authentication and student assignment workflows.

#### Unit Testing with Minitest

Following Test-Driven Development (TDD) practices, we implemented comprehensive unit tests for models and controllers.

**Model Requirements & Validations:**

1. **Projects (`ps3_projects`)**

   - Name cannot be null (validates presence)
   - Name must be unique (validates uniqueness)

2. **Students (`ps3_students`)**

   - Name cannot be null (validates presence)
   - Student ID cannot be null (validates presence)
   - Name must be unique (validates uniqueness)

3. **Access Control**
   - Anyone can view student list or individual students
   - Only logged-in users can create/edit/delete students
   - Only logged-in users can perform any project operations

**Test Coverage:**

We achieved **100% line coverage** for all PS3 (Problem Set 3) code using SimpleCov:

```ruby
# test/test_helper.rb configuration
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'app/channels'
  add_filter 'app/jobs'
  # Exclude PS1 (basics/news) functionality
  add_filter 'app/controllers/basics_controller.rb'
  add_filter 'app/controllers/main_controller.rb'
  # Exclude PS2 (jokes) functionality
  add_filter 'app/controllers/jokes_controller.rb'
  add_filter 'app/models/joke.rb'
  # Exclude base classes
  add_filter 'app/controllers/application_controller.rb'
  add_filter 'app/models/application_record.rb'
end
```

**Running Unit Tests:**

```bash
docker-compose exec web rails test
```

**Test Results:**

- ✅ **132 tests passing**
- ✅ **282 assertions**
- ✅ **100.0% line coverage** (114 relevant lines out of 114 covered)
- ✅ **3.08 average hits per line**
- ✅ **0 failures, 0 errors, 0 skips**
- 📊 **14 files** included in coverage analysis

**Test Structure:**

```
test/
├── controllers/
│   ├── ps3_projects_controller_test.rb  # CRUD + authentication tests
│   ├── ps3_students_controller_test.rb  # CRUD + nested route tests
│   └── projects_controller_test.rb      # Basic controller tests
├── models/
│   ├── ps3_project_test.rb              # Validation tests
│   ├── ps3_student_test.rb              # Validation + association tests
│   ├── ps3_project_student_test.rb      # Join model tests
│   └── user_test.rb                     # Devise authentication tests
├── fixtures/
│   ├── ps3_projects.yml                 # Test data for projects
│   ├── ps3_students.yml                 # Test data for students
│   └── users.yml                        # Test data for authentication
└── helpers/
    └── helpers_test.rb                  # Helper module tests
```

**Key Testing Features:**

1. **Model Validations**: Tests for presence, uniqueness, and associations
2. **Controller Actions**: Full CRUD operations with authentication checks
3. **Access Control**: Devise integration with `before_action :authenticate_user!`
4. **Nested Routes**: Student assignment to projects via nested resources
5. **JSON/HTML Formats**: Comprehensive format response testing
6. **Error Handling**: Validation failure paths and error messages
7. **Edge Cases**: Boundary conditions and failure scenarios

**Example Test Cases:**

```ruby
# Model validation test
test "should validate presence of name" do
  project = Ps3Project.new
  assert_not project.valid?
  assert_includes project.errors[:name], "can't be blank"
end

# Controller authentication test
test "should require authentication for create" do
  assert_no_difference('Ps3Project.count') do
    post ps3_projects_url, params: { ps3_project: { name: "Test" } }
  end
  assert_redirected_to new_user_session_path
end
```

**Coverage Report:**

View detailed coverage report at `coverage/index.html` after running tests.

**Summary: 14 files with 100% coverage**

| File                         | Lines | Relevant | Covered | Coverage   | Hits/Line |
| ---------------------------- | ----- | -------- | ------- | ---------- | --------- |
| **Controllers**              |       |          |         | **100.0%** | **3.66**  |
| `ps3_projects_controller.rb` | 85    | 41       | 41      | 100%       | 2.80      |
| `ps3_students_controller.rb` | 90    | 45       | 45      | 100%       | 4.62      |
| `projects_controller.rb`     | 7     | 3        | 3       | 100%       | 1.00      |
| **Models**                   |       |          |         | **100.0%** | **1.00**  |
| `ps3_project.rb`             | 7     | 5        | 5       | 100%       | 1.00      |
| `ps3_student.rb`             | 8     | 6        | 6       | 100%       | 1.00      |
| `ps3_project_student.rb`     | 4     | 3        | 3       | 100%       | 1.00      |
| `project.rb`                 | 2     | 1        | 1       | 100%       | 1.00      |
| `user.rb`                    | 6     | 2        | 2       | 100%       | 1.00      |
| **Helpers**                  |       |          |         | **100.0%** | **1.00**  |
| `application_helper.rb`      | 2     | 1        | 1       | 100%       | 1.00      |
| `ps3_projects_helper.rb`     | 2     | 1        | 1       | 100%       | 1.00      |
| `ps3_students_helper.rb`     | 2     | 1        | 1       | 100%       | 1.00      |
| `projects_helper.rb`         | 2     | 1        | 1       | 100%       | 1.00      |
| `jokes_helper.rb`            | 2     | 1        | 1       | 100%       | 1.00      |
| **Mailers**                  |       |          |         | **100.0%** | **1.00**  |
| `application_mailer.rb`      | 4     | 3        | 3       | 100%       | 1.00      |

**Overall Statistics:**

- 📊 Total Files: **14**
- 📄 Total Lines: **223**
- 🎯 Relevant Lines: **114**
- ✅ Lines Covered: **114** (100.0%)
- ❌ Lines Missed: **0**
- 📈 Average Hits/Line: **3.08**

---

</details>

## 👥 Team Members

- **Aye Khin Khin Hpone (Yolanda Lim)** – Student ID: 125970
- **Saugat Shakya** – Student ID: 125986

---

## License

This project is for educational purposes only. [Go to License](./LICENSE)

---

## 🤝 Contributing

Want to contribute? We love collaboration! Please read our guidelines:  
[Contributing Guidelines](./CONTRIBUTING.md)
