#import "@preview/basic-resume:0.2.4": *

// Put your personal information here, replacing mine
#let name = "Udit Mittal"
#let location = "San Diego, CA"
#let email = "contact@uditmittal.com"
#let github = "github.com/udit-001"
#let linkedin = "linkedin.com/in/stuxf"
#let phone = "+91 28912 81922"
#let personal-site = "uditmittal.com"

#show: resume.with(
  author: name,
  // All the lines below are optional.
  // For example, if you want to to hide your phone number:
  // feel free to comment those lines out and they will not show.
  // location: location,
  email: email,
  github: github,
  // linkedin: linkedin,
  // phone: phone,
  personal-site: personal-site,
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "a4",
  author-position: center,
  personal-info-position: center,
)

/*
* Lines that start with == are formatted into section headings
* You can use the specific formatting functions if needed
* The following formatting functions are listed below
* #edu(dates: "", degree: "", gpa: "", institution: "", location: "", consistent: false)
* #work(company: "", dates: "", location: "", title: "")
* #project(dates: "", name: "", role: "", url: "")
* certificates(name: "", issuer: "", url: "", date: "")
* #extracurriculars(activity: "", dates: "")
* There are also the following generic functions that don't apply any formatting
* #generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "")
* #generic-one-by-two(left: "", right: "")
*/
== Skills
- *Languages*: Python, Javascript
- *Frontend*: React, Astro, Svelte, NextJs, Tailwind CSS, Boostrap, HTML, CSS
- *Backend*: Django, Django Rest Framework, Flask, FastAPI, Celery, Celery Beat, ORM, Pandas, SocketIO
- *Datastores*: PostgreSQL, SQLite, MySQL, Redis, Elasticsearch, Weaviate
- *Server*: Linux, Amazon Web Services (AWS), Google Cloud Platform (GCP), Azure, NGINX, Caddy, Docker, Cloudflare, Firebase


== Work Experience

#work(
  title: "Software Engineer",
  location: "Bangalore, India",
  company: "Noora Health",
  dates: dates-helper(start-date: "Mar 2022", end-date: "Present"),
)
- Optimized SurveyCTO data collection using a custom plugin made using JavaScript reducing user-reported errors by 25% and enhancing user experience. Developed a one-click user onboarding plugin boosting conversion rates by 30%
- Developed a central datastore application using Django and Celery that aggregated data from various sources, including REST APIs from government partners and different applications. The application streamlined the process by consolidating the data into a single, efficient PostgreSQL database, resulting in an 85% reduction in reporting time for both external and internal stakeholders
- Developed a RAG app with Next.js and React.js, enhancing LLMs with external data. Integrated ML with Vercel AI SDK  and ensured reliability using Langfuse for monitoring and logging.
- Engineered Django-based backend for an icon library to streamline icon management by automating color transformation and format conversion. Reduced designer workload by 40% and enhanced brand consistency with tag-based search
- Created Google Cloud Functions for real-time data sync between Firebase Datastore and Google Sheets, cutting reporting time by 40%. Boosted data analysis efficiency, enriched insights, and accelerated reporting.
- Orchestrated cloud deployment for applications, enhancing performance and reliability using GCP services such as Cloud Object Storage for efficient file uploads, Cloud SQL for data security,and Docker for streamlined deployment

#work(
  title: "Software Engineer (Backend)",
  location: "Bangalore, India",
  company: "Orcablue.ai",
  dates: dates-helper(start-date: "Dec 2020", end-date: "Feb 2022"),
)
- Revamped existing ad-hoc data serialization with Django Rest Framework, decoupling it from data models for improved code maintainability, robustness, and reduced integration effort across 10+ frontend components
- Improved code quality by writing a robust test suite using the Python library, PyTest to ensure stability and marketability of critical modules
- Led a successful migration of CI/CD pipelines from Bitbucket Pipelines to GitHub Actions, optimizing deployment efficiency. Additionally, established a streamlined CI pipeline for frontend integration testing, resulting in a 20% reduction in integration time.

#work(
  title: "Software Engineer",
  location: "Delhi, India",
  company: "Ezyschooling",
  dates: dates-helper(start-date: "Nov 2019", end-date: "Dec 2020"),
)
- Implemented logging and metric generation with AWS CloudWatch to enhance visibility and facilitate triage for deliverability reports related to AWS SNS SMS.
- Enhanced search functionality with Elasticsearch, improving user experience through advanced filtering, sorting, and integration of over 10 new searchable fields
- Incorporated object detection models into a Django web application to enable mask detection during the COVID-19 pandemic, leading to the creation of a contactless attendance system.
- Designed a custom dashboard in Django to efficiently send newsletters to a subscriber base exceeding 18,000, leveraging Celery for background task management
- Developed modules for internal API using Django Rest Framework to support frontend architecture
- Managed primary point-of-sale website’s cloud architecture, optimizing performance with AWS services including RDS, EC2, S3, SNS, and SES

== Education

#edu(
  institution: "Vivekananda Instititute of Professional Studies, GGSIPU",
  location: "Delhi, India",
  dates: dates-helper(start-date: "2016", end-date: "2019"),
  degree: "Bachelor's of Computer Applications",

  // Uncomment the line below if you want edu formatting to be consistent with everything else
  consistent: true
)