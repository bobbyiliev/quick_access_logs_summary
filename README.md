# Quick Access Logs Summary

A lightweight shell script that transforms web server access logs into actionable insights.

## 🚀 Overview

This tool rapidly analyzes your Apache/Nginx access logs to provide critical visibility into your web traffic patterns. In seconds, it extracts and presents the most valuable information from your logs, helping you identify:

- 🔍 Traffic patterns and potential security threats
- 📊 Most requested resources and endpoints
- 🌎 Geographic origin of your visitors
- 🔄 Recent activity trends vs. historical patterns

## ✨ Key Features

- Extracts top GET and POST requests with frequency counts
- Identifies top visitor IPs with optional geolocation lookup
- Separate analysis of recent traffic vs. all-time patterns
- Works with standard Unix tools available on virtually any system
- Optimized for quick analysis even with large log files
- Easy-to-read terminal output with intuitive formatting

## 📋 Usage

Download and make the script executable:

```bash
chmod +x spike_check
```

Run it against your access log:

```bash
./spike_check /path/to/your/access_log
```

## 🧪 Development

### Testing

We use [shUnit2](https://github.com/kward/shunit2) for unit testing. To run the tests:

```bash
./tests/run_tests.sh
```

### Code Quality

We use shellcheck to ensure code quality. To run shellcheck locally:

```bash
shellcheck spike_check
```

### Continuous Integration

This repository uses GitHub Actions for continuous integration, which automatically runs:
- Shellcheck on all shell scripts
- Unit tests
- Code formatting checks

## 📚 Learn More

For a detailed walkthrough of how this tool works and how to interpret its results, check out this blog post:
[Bash Script to Summarize Your Nginx and Apache Access Logs](https://devdojo.com/bobbyiliev/bash-script-to-summarize-your-nginx-and-apache-access-logs)

## 🤝 Contributing

Contributions are welcome! Please check out our [contribution guidelines](CONTRIBUTING.md) for details on how to submit changes.
