### 📋 **CONTRIBUTING.md — How to Contribute to Problem Sets**

Thank you for your interest in contributing to **Problem Sets**! We love collaboration, but before you start, read this carefully — it’s for your own good.

---

## 1️⃣ Types of Contributions

You can contribute in many ways:

* **Bug reports**: Found something that breaks or behaves unexpectedly? Open an issue!
* **Feature requests**: Have a brilliant idea? Share it. We can argue later.
* **Code improvements**: Spot messy or redundant code? Submit a pull request.
* **Documentation**: Screenshots, README improvements, tutorial tips, jokes about tech — yes, all valid!

---

## 2️⃣ How to Submit

1. **Fork the repository**. Don’t just clone it and start committing — we see you.
2. **Create a new branch** for your work:

   ```bash
   git checkout -b feature/my-awesome-change
   ```
3. **Make your changes**. Keep commits clean, descriptive, and avoid “magic fixes” that nobody can understand.
4. **Run tests** (if applicable). If you break everything, be prepared for blame.
5. **Push your branch** to your fork and open a pull request.

---

## 3️⃣ Code Style

We try to keep the code **clean, consistent, and readable**:

* Ruby / Rails: Follow standard [Ruby Style Guide](https://rubystyle.guide/)
* SQL: Use uppercase for keywords (`SELECT`, `FROM`, `WHERE`), lowercase for identifiers is okay
* Indentation: 2 spaces (because 4 is too mainstream)
* Comments: Explain “why,” not “what” — code already tells the “what”

---

## 4️⃣ Commit Messages

Commit messages should be **clear, short, and meaningful**:

```
[PS2] Fix cookie expiration logic for personalization
[SQL6] Load stock data from tab-delimited file
```

Pro tip: Don’t write “fixed stuff” or “changes” — future-you will hate past-you.

---

## 5️⃣ Code of Conduct

* Be **respectful**. Sarcasm is allowed, toxicity is not.
* Discuss ideas **politely** — we love debates, but keep it professional.
* Credit contributors properly. Yes, even the weird ones.

---

## 6️⃣ Testing Your Changes

* For Rails features:

  ```bash
  rails db:migrate
  rails s
  ```

  Check your forms, exports, search, and personalization.
* For SQL exercises: run your queries in `psql` or `pgAdmin` and ensure they work as expected.

---

## 7️⃣ Pull Request Checklist

Before submitting a PR:

* [ ] Code is formatted properly and passes linter checks
* [ ] Changes have been tested locally
* [ ] Documentation (README, comments) updated if applicable
* [ ] Screenshots added for UI changes or SQL outputs
* [ ] Humor included where appropriate 😎

---

## 8️⃣ “Fun” Clause

* Contributions with witty comments, jokes, or fun error messages are welcome.
* Contributions that break the sarcasm-to-logic ratio will be sent back with a strongly-worded emoji.