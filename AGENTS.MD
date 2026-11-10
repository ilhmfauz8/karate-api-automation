---

# Karate API Automation Rules

This repository uses Karate for API test automation.

Prefer native Karate capabilities before introducing Java code,
custom helpers, wrappers, or additional libraries.

The goal is to keep API automation simple, readable, deterministic,
and maintainable.

---

## Default API Automation Flow

For normal API automation work:

requirement
→ inspect API specification
→ inspect existing test coverage
→ inspect reusable Karate configuration/features
→ implement the minimum necessary scenario
→ run the relevant scenario
→ verify response and business behavior

Do not introduce framework abstractions before there is a demonstrated need.

---

## Karate Native First

Prefer Karate's native capabilities for:

- HTTP requests
- headers
- authentication
- path parameters
- query parameters
- request bodies
- response assertions
- JSON matching
- schema validation
- variable handling
- data-driven testing
- reusable feature calls
- environment configuration
- retry/polling when appropriate

Do not create Java wrappers around functionality that Karate already provides.

Java interoperability is allowed only when native Karate functionality is
insufficient or there is a clear maintainability benefit.

---

## Feature Structure

Use Karate's native Gherkin-style structure:

- Feature
- Background
- Scenario
- Scenario Outline
- Given
- When
- Then
- And

Scenario names should describe business behavior.

Prefer:

Scenario: Retrieve an existing pet by valid pet ID

Avoid:

Scenario: Send GET request and validate status 200

The scenario name should explain intent, while the implementation contains
the HTTP details.

---

## API Test Design

For each scenario, validate only behavior relevant to the requirement.

When applicable, consider:

- HTTP status
- response body
- response schema
- required fields
- business rules
- authentication
- authorization
- invalid input
- missing input
- boundary values
- resource not found
- duplicate requests
- state changes
- error handling

Do not generate every theoretical negative combination.

Prefer meaningful risk-based coverage over test case quantity.

---

## Assertions

Prefer Karate native matching.

Examples:

match response.id == petId
match response.name == petName
match response.status == 'available'

Use partial matching when only part of the response is relevant:

match response contains { status: 'available' }

Do not assert volatile or irrelevant fields.

Do not weaken assertions just to make a failing test pass.

---

## Test Data

Prefer scenario-owned or dynamically generated data.

Tests should:

- be independently executable
- avoid relying on scenario execution order
- avoid shared mutable state
- avoid collisions with other tests
- clean up created data when cleanup is necessary

Do not create centralized test-data abstractions until real duplication
demonstrates the need.

---

## Reuse

Use Background only when setup is genuinely shared by scenarios in the same
feature.

Use reusable feature calls only when the same API workflow is actually reused
across multiple scenarios or features.

Do not extract trivial request logic merely to reduce line count.

Avoid deep chains of reusable features that make tests harder to understand.

---

## Configuration

Keep environment-specific configuration in karate-config.js or the existing
repository configuration mechanism.

Examples:

- base URL
- environment
- credentials
- authentication settings

Do not hardcode environment URLs inside feature files when they belong in
configuration.

Never commit:

- passwords
- API keys
- authentication tokens
- secrets

---

## Scenario Independence

Each scenario should run independently unless the API itself requires a
multi-step business flow.

If a scenario requires a resource, prefer creating that resource within the
scenario or via reusable setup.

Do not depend on another scenario having executed first.

---

## Project Structure

Keep the initial project structure minimal.

Do not automatically create:

- helpers
- utils
- clients
- services
- models
- builders
- factories

Create additional layers only after actual duplication or complexity
demonstrates a need.

Feature files should remain readable without navigating through unnecessary
abstraction layers.

---

## Tags

Use tags only when they serve an execution purpose.

Examples:

@smoke
@regression
@negative

Do not create excessive tagging conventions before they are needed.

---

## Verification

After implementing a Karate test:

1. run the specific scenario or feature first
2. verify HTTP result and business assertions
3. investigate failures before modifying implementation
4. run broader regression only when justified

Do not claim a scenario passes without executing it.

Do not change expected behavior solely to make the test green.