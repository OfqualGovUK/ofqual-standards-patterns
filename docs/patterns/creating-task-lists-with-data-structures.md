---
layout: pattern
order: 1
title: Creating Task Lists With Data Structures
date: 2023-12-31 # this should be the date that the content was most recently amended or formally reviewed
# use `tags: []` for no tags 
# Check https://ho-cto.github.io/engineering-guidance-and-standards/tags/ for existing tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Data
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related standards
      items:
        - text: Data Driven Architecture
          href: /standards/data-driven-architecture/ # Note: use an absolute link from the site home page
---

<!-- Pattern description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

This pattern outlines a method of handling task list based services using a data driven architecture, as can be found in the Recognition Service and in most Government Citizen Services.

The task list component referred to can be found at [https://design-system.service.gov.uk/components/task-list/](https://design-system.service.gov.uk/components/task-list/), with most systems also breaking a list down into different sections to complete

---

## Database Tables

### Introduction

- A task list based system can be broken down into three layers to define its content:
  - Sections, which are used to organise tasks together into manageable chunks
  - Tasks, which are used to organise sets of questions into manageable chunks
  - Questions, which are used to collect data from users
- There are then two main additional tables that are needed to collect and store this data:
  - TaskStatus, which tracks when tasks are marked as completed
  - ApplicationAnswer, which tracks the actual answers that are submitted
- There is one table that supports both content and answers:
  - QuestionTypes, which are used to store what types of questions users are asked; this is needed as the content for the questions is stored as flexible JSON, and this informs the frontend of how to interpret and render that JSON appropriately, as well as to facilitate data intepretation by data engineers for a given answer


### Sections

- This is a simple definition table that establishes the names and orders of the different system sections

```sql

CREATE TABLE example.Section (
    SectionId UNIQUEIDENTIFIER NOT NULL,
    SectionName VARCHAR(200) NOT NULL,
    OrderNumber INT NOT NULL, -- Used to determine in which order the sections appear in the task list
    CreatedDate DATETIME2 NOT NULL,
    ModifiedDate DATETIME2 NOT NULL,
    CreatedByUpn NVARCHAR(255) NOT NULL,
    ModifiedByUpn NVARCHAR(255) NULL,
    CONSTRAINT [PK_Section] PRIMARY KEY NONCLUSTERED (
        [SectionId] ASC
    ) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]; --TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [example].[Section]
ADD CONSTRAINT [DF_Section_SectionId] DEFAULT (newsequentialid()) FOR [SectionId];

GO

ALTER TABLE [example].[Section]
ADD CONSTRAINT [DF_Section_CreatedDate] DEFAULT (getdate()) FOR [CreatedDate];

GO

ALTER TABLE [example].[Section]
ADD CONSTRAINT [DF_Section_ModifiedDate] DEFAULT (getdate()) FOR [ModifiedDate];

GO

ALTER TABLE [example].[Section]
ADD CONSTRAINT [DF_Section_CreatedByUpn] DEFAULT (suser_sname()) FOR [CreatedByUpn];

GO

ALTER TABLE [example].[Section]
ADD CONSTRAINT [DF_Section_ModifiedByUpn] DEFAULT (suser_sname()) FOR [ModifiedByUpn];

GO

```

### Tasks

- This is a definition for the tasks that appear under each section
- Each task must have a relatonship to another section
- There is also an implicit relationship with Questions through the TaskNameUrl as this defines the page that users are taken to when they click on the task

```sql
CREATE TABLE example.Task (
    TaskId UNIQUEIDENTIFIER NOT NULL,
    TaskName NVARCHAR(200) NOT NULL,
    SectionId UNIQUEIDENTIFIER NOT NULL, -- All tasks must be assigned a section
    OrderNumber INT NOT NULL, -- The order in which the tasks appear
    TaskNameUrl NVARCHAR(100) NULL, -- The URL Slug of the first question to navigate to
    ReviewFlag BIT NOT NULL, -- This is used to indicate whether the task should appear in the end-of-task list review task. Remove if this is not used
    HintText NVARCHAR(500) NULL, -- This appears as additional descriptions under the task
    CreatedDate DATETIME2 NOT NULL,
    ModifiedDate DATETIME2 NOT NULL,
    CreatedByUpn NVARCHAR(255) NOT NULL,
    ModifiedByUpn NVARCHAR(255) NULL,
    CONSTRAINT [PK_Task] PRIMARY KEY NONCLUSTERED (
        [TaskId] ASC
    ) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]; --TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [example].[Task]
ADD CONSTRAINT [DF_Task_TaskId] DEFAULT (newsequentialid()) FOR [TaskId];

GO

ALTER TABLE [example].[Task]
ADD CONSTRAINT [DF_Task_ReviewFlag] DEFAULT (0) FOR [ReviewFlag];

GO

ALTER TABLE [example].[Task]
ADD CONSTRAINT [DF_Task_CreatedDate] DEFAULT (getdate()) FOR [CreatedDate];

GO

ALTER TABLE [example].[Task]
ADD CONSTRAINT [DF_Task_ModifiedDate] DEFAULT (getdate()) FOR [ModifiedDate];

GO

ALTER TABLE [example].[Task]
ADD CONSTRAINT [DF_Task_CreatedByUpn] DEFAULT (suser_sname()) FOR [CreatedByUpn];

GO

ALTER TABLE [example].[Task]
ADD CONSTRAINT [DF_Task_ModifiedByUpn] DEFAULT (suser_sname()) FOR [ModifiedByUpn];

GO

ALTER TABLE [example].[Task]
WITH CHECK ADD CONSTRAINT [FK_Section_Task] FOREIGN KEY([SectionId])
REFERENCES [example].[Section] ([SectionId]);

GO

ALTER TABLE [example].[Task]
CHECK CONSTRAINT [FK_Section_Task];

GO
```

### Questions

- This table defines each individual question page
- Currently questions are mapped to singular tasks
- This table could be used with only a QuestionType table for services that do not require a task list

```sql

CREATE TABLE example.Question (
    QuestionId UNIQUEIDENTIFIER NOT NULL,
    TaskId UNIQUEIDENTIFIER NOT NULL, -- The task associated with this question
    OrderNumber INT NOT NULL, -- Defines which order the questions are shown in, with "1" being the first question
    QuestionTypeId UNIQUEIDENTIFIER NOT NULL, -- Defines the type of question this is
    QuestionContent NVARCHAR(MAX) NOT NULL, -- This is a *JSON* object that defines the actual content of the question
    QuestionNameUrl NVARCHAR(100), -- The Page URL for this question
    CreatedDate DATETIME2 NOT NULL,
    ModifiedDate DATETIME2 NOT NULL,
    CreatedByUpn NVARCHAR(255) NOT NULL,
    ModifiedByUpn NVARCHAR(255) NULL,
    CONSTRAINT [PK_Question] PRIMARY KEY NONCLUSTERED (
        [QuestionId] ASC
    ) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]; --TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [example].[Question]
ADD CONSTRAINT [DF_Question_QuestionId] DEFAULT (newsequentialid()) FOR [QuestionId];

GO

ALTER TABLE [example].[Question]
ADD CONSTRAINT [DF_Question_CreatedDate] DEFAULT (getdate()) FOR [CreatedDate];

GO

ALTER TABLE [example].[Question]
ADD CONSTRAINT [DF_Question_ModifiedDate] DEFAULT (getdate()) FOR [ModifiedDate];

GO

ALTER TABLE [example].[Question]
ADD CONSTRAINT [DF_Question_CreatedByUpn] DEFAULT (suser_sname()) FOR [CreatedByUpn];

GO

ALTER TABLE [example].[Question]
ADD CONSTRAINT [DF_Question_ModifiedByUpn] DEFAULT (suser_sname()) FOR [ModifiedByUpn];

GO

ALTER TABLE [example].[Question]
WITH CHECK ADD CONSTRAINT [FK_QuestionType_Question] FOREIGN KEY([QuestionTypeId])
REFERENCES [example].[QuestionType] ([QuestionTypeId]);

GO

ALTER TABLE [example].[Question]
CHECK CONSTRAINT [FK_QuestionType_Question];

GO

ALTER TABLE [example].[Question]
WITH CHECK ADD CONSTRAINT [FK_Task_Question] FOREIGN KEY([TaskId])
REFERENCES [example].[Task] ([TaskId]);

GO

ALTER TABLE [example].[Question]
CHECK CONSTRAINT [FK_Task_Question];

GO

ALTER TABLE [example].[Question]  
WITH CHECK ADD CONSTRAINT [DF_Question_QuestionContent] CHECK  ((isjson([QuestionContent])>(0)))
GO

ALTER TABLE [example].[Question] 
CHECK CONSTRAINT [DF_Question_QuestionContent]
GO

```

### QuestionTypes

- This table is effectively a simple reference data table
- Each service _should have its own table_ rather than reference a Reference Data API; this is so that different systems can have flexibility in their requirements for different types of questions, without having to worry too much about impact on other systems

```sql

CREATE TABLE example.QuestionType (
    QuestionTypeId UNIQUEIDENTIFIER NOT NULL,
    QuestionTypeName NVARCHAR(50) NOT NULL,
    CreatedDate DATETIME2 NOT NULL,
    ModifiedDate DATETIME2 NOT NULL,
    CreatedByUpn NVARCHAR(255) NOT NULL,
    ModifiedByUpn NVARCHAR(255) NULL,
    CONSTRAINT [PK_QuestionType] PRIMARY KEY NONCLUSTERED
    (
        [QuestionTypeId] ASC
    ) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]; --TEXTIMAGE_ON [PRIMARY]

GO 

ALTER TABLE [example].[QuestionType]
ADD CONSTRAINT [DF_QuestionType_QuestionTypeId] DEFAULT (newsequentialid()) FOR [QuestionTypeId];

GO

ALTER TABLE [example].[QuestionType]
ADD CONSTRAINT [DF_QuestionType_CreatedDate] DEFAULT (getdate()) FOR [CreatedDate];

GO

ALTER TABLE [example].[QuestionType]
ADD CONSTRAINT [DF_QuestionType_ModifiedDate] DEFAULT (getdate()) FOR [ModifiedDate];

GO

ALTER TABLE [example].[QuestionType]
ADD CONSTRAINT [DF_QuestionType_CreatedByUpn] DEFAULT (suser_sname()) FOR [CreatedByUpn];

GO

ALTER TABLE [example].[QuestionType]
ADD CONSTRAINT [DF_QuestionType_ModifiedByUpn] DEFAULT (suser_sname()) FOR [ModifiedByUpn];

GO

```

### TaskStatus

- Used to track when task statuses are changed and completed for a given application and task

```sql

CREATE TABLE example.TaskStatus (
    TaskStatusId UNIQUEIDENTIFIER NOT NULL,
    ApplicationId UNIQUEIDENTIFIER NOT NULL,
    TaskId UNIQUEIDENTIFIER NOT NULL,
    Status NVARCHAR(255) NOT NULL, -- Recorded as a VARCHAR for flexibility; see https://design-system.service.gov.uk/patterns/complete-multiple-tasks/ for help on defining appropriate statuses
    CreatedDate DATETIME2 NOT NULL,
    ModifiedDate DATETIME2 NOT NULL,
    CreatedByUpn NVARCHAR(255) NOT NULL,
    ModifiedByUpn NVARCHAR(255) NULL,
    CONSTRAINT [PK_TaskStatus] PRIMARY KEY NONCLUSTERED (
        [TaskStatusId] ASC
    ) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]; --TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [example].[TaskStatus]
ADD CONSTRAINT [DF_TaskStatus_TaskStatusId] DEFAULT (newsequentialid()) FOR [TaskStatusId];

GO

ALTER TABLE [example].[TaskStatus]
ADD CONSTRAINT [DF_TaskStatus_CreatedDate] DEFAULT (getdate()) FOR [CreatedDate];

GO

ALTER TABLE [example].[TaskStatus]
ADD CONSTRAINT [DF_TaskStatus_ModifiedDate] DEFAULT (getdate()) FOR [ModifiedDate];

GO

ALTER TABLE [example].[TaskStatus]
ADD CONSTRAINT [DF_TaskStatus_CreatedByUpn] DEFAULT (suser_sname()) FOR [CreatedByUpn];

GO

ALTER TABLE [example].[TaskStatus]
ADD CONSTRAINT [DF_TaskStatus_ModifiedByUpn] DEFAULT (suser_sname()) FOR [ModifiedByUpn];

GO

ALTER TABLE [example].[TaskStatus]
WITH CHECK ADD CONSTRAINT [FK_Application_TaskStatus] FOREIGN KEY([ApplicationId])
REFERENCES [example].[Application] ([ApplicationId]);

GO

ALTER TABLE [example].[TaskStatus]
CHECK CONSTRAINT [FK_Application_TaskStatus];

GO

ALTER TABLE [example].[TaskStatus]
WITH CHECK ADD CONSTRAINT [FK_Task_TaskStatus] FOREIGN KEY([TaskId])
REFERENCES [example].[Task] ([TaskId]);

GO

ALTER TABLE [example].[TaskStatus]
CHECK CONSTRAINT [FK_Task_TaskStatus];

GO

```

### ApplicationAnswers

- Used to track answers for a given application and question
- Answers are always stored as JSON to account for the differences in the types of questions we get answers for

```sql

CREATE TABLE recognitionCitizen.ApplicationAnswers (
    ApplicationAnswersId UNIQUEIDENTIFIER NOT NULL,
    ApplicationId UNIQUEIDENTIFIER NOT NULL,
    QuestionId UNIQUEIDENTIFIER NOT NULL,
    Answer NVARCHAR(MAX) NOT NULL, -- Answers are stored as JSON objects
    CreatedDate DATETIME2 NOT NULL,
    ModifiedDate DATETIME2 NOT NULL,
    CreatedByUpn NVARCHAR(255) NOT NULL,
    ModifiedByUpn NVARCHAR(255) NULL,
    CONSTRAINT [PK_ApplicationAnswers] PRIMARY KEY NONCLUSTERED (
        [ApplicationAnswersId] ASC
    ) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]; --TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers]
ADD CONSTRAINT [DF_ApplicationAnswers_ApplicationAnswersId] DEFAULT (newsequentialid()) FOR [ApplicationAnswersId];
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers]
ADD CONSTRAINT [DF_ApplicationAnswers_CreatedDate] DEFAULT (getdate()) FOR [CreatedDate];
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers]
ADD CONSTRAINT [DF_ApplicationAnswers_ModifiedDate] DEFAULT (getdate()) FOR [ModifiedDate];
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers]
ADD CONSTRAINT [DF_ApplicationAnswers_CreatedByUpn] DEFAULT (suser_sname()) FOR [CreatedByUpn];
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers]
ADD CONSTRAINT [DF_ApplicationAnswers_ModifiedByUpn] DEFAULT (suser_sname()) FOR [ModifiedByUpn];
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers]
WITH CHECK ADD CONSTRAINT [FK_Application_ApplicationAnswers] FOREIGN KEY([ApplicationId])
REFERENCES [recognitionCitizen].[Application] ([ApplicationId]);
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers]
CHECK CONSTRAINT [FK_Application_ApplicationAnswers];
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers]
WITH CHECK ADD CONSTRAINT [FK_Question_ApplicationAnswers] FOREIGN KEY([QuestionId])
REFERENCES [recognitionCitizen].[Question] ([QuestionId]);
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers]
CHECK CONSTRAINT [FK_Question_ApplicationAnswers];
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers]  
WITH CHECK ADD  CONSTRAINT [DF_ApplicationAnswers_Answers] CHECK  ((isjson([Answer])>(0)))
GO

ALTER TABLE [recognitionCitizen].[ApplicationAnswers] 
CHECK CONSTRAINT [DF_ApplicationAnswers_Answers]
GO

```

---
