# Firebase App Distribution Guide

This document explains how to configure and use Firebase App Distribution with Flutter DevOps Kit (`fkit`).

---

# Overview

FKIT supports automated Firebase App Distribution uploads directly from CLI.

This allows teams to:

* distribute QA builds quickly
* automate tester workflows
* attach release notes
* avoid manual Firebase Console uploads

---

# Requirements

Before using Firebase distribution:

## 1. Install Firebase CLI

Install globally:

```bash id="v0u4l8"
npm install -g firebase-tools
```

---

## 2. Login To Firebase

```bash id="5jwzsm"
firebase login
```

Verify:

```bash id="ywqxvl"
firebase projects:list
```

---

# Configure Firebase In FKIT

Inside:

```bash id="x1fjlwm"
fkit.yaml
```

---

# Example Configuration

```yaml id="btjlwm"
firebase:
  enabled: true
  tester_group: internal-testers
  configurations:
    production:
      android:
        app_id: 1:1234567890:android:abcdef123456
        options: lib/firebase_options_production.dart
      ios:
        app_id: 1:1234567890:ios:abcdef123456
        options: lib/firebase_options_production.dart
      web:
        app_id: 1:1234567890:web:abcdef123456
        options: lib/firebase_options_production.dart
```

---

# Firebase App Distribution ID

## Where To Find It

Open:

```text id="k1jlwm"
Firebase Console
→ Project Settings
→ General
→ Your Apps
```

Example:

```text id="r1jlwm"
1:1234567890:android:abcdef123456
```

---

# Tester Groups

## Default Group

Configured globally:

```yaml id="m1jlwm"
firebase:
  tester_group: internal-testers
```

Used automatically during uploads.

---

# Create Tester Groups

Inside Firebase Console:

```text id="t1jlwm"
App Distribution
→ Testers & Groups
```

Examples:

* internal-testers
* qa-team
* beta-users

---

# Upload APK To Firebase

## Basic Upload

```bash id="y1jlwm"
fkit firebase production
```

FKIT automatically:

1. builds APK
2. resolves artifact path
3. uploads to Firebase
4. distributes to tester group

---

# Upload With Release Notes

```bash id="6hjlwm"
fkit firebase production --notes="QA smoke test build"
```

Recommended for:

* QA testing
* regression testing
* release candidates

---

# Build Flow

Internally FKIT runs:

```bash id="3xjlwm"
flutter build apk
```

then:

```bash id="8xjlwm"
firebase appdistribution:distribute
```

automatically.

---

# Flavor Support

## Flavored Projects

```yaml id="jlwm0bd"
flavoring:
  enabled: true
```

FKIT uses:

```bash id="jlwm0be"
--flavor production
```

during build.

---

# Non-Flavored Projects

```yaml id="jlwm0bf"
flavoring:
  enabled: false
```

FKIT automatically skips Flutter flavor arguments.

Useful for:

* web projects
* simple apps
* dart-define-based apps

---

# Firebase Options Validation

FKIT validates Firebase option files before builds.

Example:

```yaml id="jlwm0bg"
options:
  android: lib/firebase_options_production.dart
```

Validation checks:

* file existence
* flavor consistency

---

# Common Workflows

## QA Build

```bash id="jlwm0bh"
fkit firebase staging --notes="QA build"
```

---

## Internal Testing

```bash id="’winiiii332"
fkit firebase development --notes="Internal smoke test"
```

---

## Production Candidate

```bash id="’winiiii333"
fkit firebase production --notes="Release candidate"
```

---

# Common Errors

## Firebase CLI Missing

Error:

```text id="’winiiii334"
Firebase CLI missing
```

Solution:

```bash id="’winiiii335"
npm install -g firebase-tools
```

---

## Not Logged In

Error:

```text id="’winiiii336"
Failed to authenticate
```

Solution:

```bash id="’winiiii337"
firebase login
```

---

## Invalid App ID

Error:

```text id="’winiiii338"
Requested entity was not found
```

Usually caused by:

* incorrect App Distribution ID
* wrong Firebase project
* deleted app

Verify App ID in Firebase Console.

---

## APK Not Found

Error:

```text id="’winiiii339"
Artifact not found
```

Usually caused by:

* build failure
* incorrect artifact path
* flavor mismatch

---

# Best Practices

## Recommended

* Use separate Firebase projects per environment
* Use release notes for every upload
* Keep tester groups organized
* Validate builds before distribution
* Separate staging and production apps

---

## Avoid

* Uploading debug APKs
* Sharing production builds accidentally
* Mixing staging & production Firebase projects
* Using same App ID across environments

---

# Future Scope

Planned Firebase automation:

* iOS Firebase distribution
* automated tester assignment
* release channels
* CI/CD integration
* build history
* Slack notifications
* Discord notifications
* crashlytics symbol upload

---

# Recommended Workflow

```bash id="’winiiii340"
fkit validate
fkit build apk staging
fkit firebase staging --notes="Regression build"
```

---

# Security Recommendations

## Never Commit

Do NOT commit:

```text id="’winiiii341"
android/key.properties
android/app/*.jks
```

---

## Keep Firebase Projects Separate

Recommended:

| Environment | Firebase Project |
| ----------- | ---------------- |
| Development | separate         |
| Staging     | separate         |
| Production  | separate         |

This prevents accidental production data access.

---

# Related Documentation

* `configuration.md`
* `commands.md`
* `signing.md`
