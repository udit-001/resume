#import "@preview/basic-resume:0.2.4": *
#let phone = sys.inputs.at("phone", default: none)
#let email = sys.inputs.at("email", default: "contact@uditmittal.com")
#let name = "Udit Mittal"
#let location = "Bangalore, India"
#let github = "github.com/udit-001"
#let linkedin = "linkedin.com/in/uditmittal01"
#let personal-site = "uditmittal.com"

#show: doc => {
  set page(footer: align(center)[#text(fill: rgb("666666"), size: 0.8em)[Last updated: #datetime.today().display("[month repr:long] [day], [year]")]])
  doc
}

#let info = (
  author: name,
  // All the lines below are optional.
  // For example, if you want to to hide your phone number:
  // feel free to comment those lines out and they will not show.
  location: location,
  email: email,
  // github: github,
  linkedin: linkedin,
  // personal-site: personal-site,
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "a4",
  author-position: center,
  personal-info-position: center,
)

#let info = if phone != none {
  info + (phone: link("tel:" + phone, phone))
} else {
  info
}

#show: resume.with(..info)

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
- *Frontend*: React, Next.js, Svelte, Astro, HTMX, Tailwind CSS, DaisyUI, Bootstrap, HTML, CSS
- *Backend*: Django, Django Rest Framework, Flask, FastAPI, Celery, Celery Beat, ORM, Pandas, SocketIO
- *Databases*: PostgreSQL, SQLite, MySQL, Redis, Elasticsearch, Weaviate, BigQuery
- *Cloud & DevOps*: AWS (EC2, S3, RDS, Lambda), GCP (Compute Engine, Cloud Storage, Cloud SQL, Cloud Run, Cloud Functions, Artifact Registry), Azure, Docker, Git, Bitbucket, Gitlab, GitHub Actions, NGINX, Caddy, Linux, Firebase, Cloudflare, Vercel, Netlify, Heroku
- *AI/ML*: OpenAI, LLMs, RAG, Vector Databases, Sarvam AI, Vercel AI SDK, Langfuse


== Work Experience

#work(
  title: "Software Engineer",
  location: "Bangalore, India",
  company: link("https://noorahealth.org", "Noora Health"),
  dates: dates-helper(start-date: "Mar 2022", end-date: "Present"),
)
- Built a RAG-based message classification system using FastAPI, Weaviate, and OpenAI with custom embeddings and hybrid search strategies, processing 2M+ messages for intent classification and routing, reducing agent workload by 40%
- Engineered an automated form digitization system using custom-trained Azure OCR models and validation algorithms, increasing form processing throughput by 350% while maintaining 90% accuracy. Reduced manual data entry time by 75% through robust error handling, automated validation, and comprehensive monitoring using Langfuse for OCR outputs and processing steps
- Developed a RAG app with Next.js and React.js, using Weaviate for vector search to enhance LLMs like OpenAI with external data. Integrated with Vercel AI SDK and integrated real-time monitoring and logging via Langfuse
- Architected a real-time language detection pipeline using FastAPI and Exotel, integrating Sarvam AI's API with IVR system to reduce language selection time by 80%. Implemented robust error handling, fallback mechanisms, and comprehensive monitoring using Langfuse for real-time performance tracking
- Orchestrated cloud deployment using GitHub Actions for builds, Artifact Registry for image storage, Cloud Storage for file uploads, and Cloud SQL for secure data, ensuring performance and reliability.

#work(
  title: "Software Engineer (Backend)",
  location: "Bangalore, India",
  company: link("https://orcablue.ai", "Orcablue.ai"),
  dates: dates-helper(start-date: "Dec 2020", end-date: "Feb 2022"),
)
- Architected and implemented a robust data serialization layer using Django Rest Framework, decoupling it from data models. This improved code maintainability and reduced integration effort by 50% across 10+ frontend components
- Developed comprehensive test suites using PyTest, achieving 85% code coverage and reducing production bugs by 60%. Implemented CI/CD pipelines that automated testing and deployment processes
- Led migration from Bitbucket Pipelines to GitHub Actions, streamlining the development workflow and making code reviews more efficient. Set up automated builds and deployments that reduced deployment time by 40%

#work(
  title: "Software Engineer",
  location: "Delhi, India",
  company: link("https://ezyschooling.com", "Ezyschooling"),
  dates: dates-helper(start-date: "Nov 2019", end-date: "Dec 2020"),
)
- Implemented AWS CloudWatch monitoring for SMS delivery via SNS, reducing incident response time by 60%
- Enhanced search functionality with Elasticsearch, improving user experience through advanced filtering, sorting, and integration of over 10 new searchable fields
- Incorporated object detection models into a Django web application to enable mask detection during the COVID-19 pandemic, leading to the creation of a contactless attendance system.
- Built a personalized newsletter distribution system using Django and Celery, handling 18,000+ subscribers with customized content based on user preferences and behavior. Implemented rate limiting and queue management, reducing server load by 70% and improving delivery success rate
- Developed modules for internal API using Django Rest Framework to support frontend architecture
- Managed primary point-of-sale website's cloud architecture, optimizing performance with AWS services including RDS, EC2, S3, SNS, and SES

== Education

#edu(
  institution: "Vivekananda Instititute of Professional Studies, GGSIPU",
  location: "Delhi, India",
  dates: dates-helper(start-date: "2016", end-date: "2019"),
  degree: "Bachelor of Computer Applications",

  // Uncomment the line below if you want edu formatting to be consistent with everything else
  consistent: true
)