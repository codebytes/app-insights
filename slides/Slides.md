---
marp: true
theme: custom-default
footer: '@Chris_L_Ayers - https://chris-ayers.com'
---

<!-- _footer: 'https://github.com/codebytes/app-insights' -->

![bg right](img/containers.jpg)
# Enhanced Monitoring and Troubleshooting with Azure Application Insights and .NET Aspire's Open Telemetry Dashboard
### ![w:60px](./img/portrait.png) Chris Ayers

---

![bg left:40%](./img/portrait.png)

## Chris Ayers
### Senior Customer Engineer<br>Microsoft

<i class="fa-brands fa-twitter"></i> Twitter: @Chris\_L\_Ayers
<i class="fa-brands fa-mastodon"></i> Mastodon: @Chrisayers@hachyderm.io
<i class="fa-brands fa-linkedin"></i> LinkedIn: - [chris\-l\-ayers](https://linkedin.com/in/chris-l-ayers/)
<i class="fa fa-window-maximize"></i> Blog: [https://chris-ayers\.com/](https://chris-ayers.com/)
<i class="fa-brands fa-github"></i> GitHub: [Codebytes](https://github.com/codebytes)

---

# Agenda

- Azure Application Insights
- Application Insights SDK
- OpenTelemetry
- .NET Aspire
- DEMO
- Questions
  
---

# What is Application Insights?

![alt text](img/app-insights.png)

---

# Application Insights

<div class="columns">
<div>

## Application Performance Monitoring (APM)

- Traces
- Metrics
- End user Experience
- Errors
- Performance

</div>
<div>

## Features

- Application Map
- Live Metrics
- Smart Detection
- Transaction Search
- Usage
- Sessions

</div>

---

# Auto Instrumentation Support

| Environment / Provider | .NETFramework | .NET |  Java | Node.js | Python |
| --- | --- | --- | --- | --- | --- |
| Azure App Service on Windows  | ✅ | ✅ |  ✅ |  ✅ | ❌ |
| Azure App Service on Linux  | ❌ | ✅ | ✅ | ✅ | ✅ |
| Azure Functions - basic | ✅ | ✅ | ✅ | ✅ | ✅ |
| Azure Functions - dependencies | ❌ | ❌ | ✅ | ❌ | ❌ |
| Azure Kubernetes Service (AKS) | ❌ | ❌ | ✅ | ❌ | ❌ |
| VMs Windows | ✅ | ✅ | ✅ | ❌ | ❌ |
| Standalone agent | ❌ | ❌ | ✅ | ❌ | ❌ |

---

# Supported Languages

<div class="columns">
<div>

## OpenTelemetry Distro

- ASP.NET Core
- .NET
- Java
- Node.js
- Python

</div>
<div>

## SDK (Classic API)

- ASP.NET
- ASP.NET Core
- Java
- Node.js
- Python
- Javascript

</div>

---

# Application map

<div class="columns">
<div>

- Spot performance bottlenecks or failure hotspots across all components of your distributed application.
- Each node on the map represents an application component or its dependencies.

</div>
<div>

![alt text](img/application-map.png)

</div>
</div>

---

# Smart Detection

<div class="columns">
<div>

- Automatic alerts based on your app
- Triggers when outside the usual pattern.
- Alerts on custom or standard metrics.

</div>
<div>

![alt text](img/smart-detection.png)

</div>
</div>

---

# Live Metrics

- Validate a fix while it's released by watching performance and failure counts.
- Watch the effect of test loads and diagnose issues live.
- Get exception traces as they happen.

![bg right fit](img/live-metrics.png)

---

# Transaction Search

- Search in the Portal or Visual Studio
- Filter by Events
- Filter by custom properties
- Filter by exceptions
- Filter by performance
- Filter by dependencies

![bg right fit](img/transaction-search.png)

---

# Usage

- Sessions
- Users
- Page views
- Events
- Cohorts
- Funnels

![bg right fit](img/usage.png)

---

# OpenTelemetry

- **OpenTelemetry** is an open-source observability framework.
- It provides:
  - **Metrics** (Quantitative data on performance)
  - **Logs** (Records of events)
  - **Traces** (Insights into request flows)
- Supports a wide range of programming languages and frameworks.
- Part of the **CNCF** (Cloud Native Computing Foundation).

---

# Why Use OpenTelemetry?

- **Vendor-Neutral**: Collect once, export to any observability platform (e.g., Prometheus, Grafana).
- **Unified Standard**: No need to integrate multiple tools for metrics, logs, and traces.
- **Full Stack Coverage**: From backend services to frontend apps.
- **Improved Monitoring**: Provides deeper insights into distributed systems.
- **Better Root Cause Analysis**: Visualizes the path of a request across services.

---

# Components of OpenTelemetry

- **API**: Defines how applications create and interact with telemetry data.
- **SDK**: Implements the API for different languages.
- **Instrumentation**: Automatically or manually collect data from code.
- **Collectors**: Agent or service that processes and exports telemetry data.
- **Exporters**: Sends data to a monitoring backend like Jaeger, Zipkin, or Prometheus.

---

# OpenTelemetry Collector

![alt text](image.png)

---

# Azure Monitor OpenTelemetry Distro

![alt text](image-1.png)

---

# DEMO TIME

---

![bg](img/questions.jpg)

---

# Resources 

<div class="columns">
<div>

## Links

- [Application Insights overview](https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview)
- [Enable Azure Monitor OpenTelemetry for .NET, Node.js, Python, and Java applications](https://learn.microsoft.com/en-us/azure/azure-monitor/app/opentelemetry-enable?tabs=aspnetcore)


</div>
<div>

## Chris Ayers 

<i class="fa-brands fa-twitter"></i> Twitter: @Chris\_L\_Ayers
<i class="fa-brands fa-mastodon"></i> Mastodon: @Chrisayers@hachyderm.io
<i class="fa-brands fa-linkedin"></i> LinkedIn: - [chris\-l\-ayers](https://linkedin.com/in/chris-l-ayers/)
<i class="fa fa-window-maximize"></i> Blog: [https://chris-ayers\.com/](https://chris-ayers.com/)
<i class="fa-brands fa-github"></i> GitHub: [Codebytes](https://github.com/codebytes)

</div>

</div>
