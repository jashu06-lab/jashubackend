# Cab System SMS - Docker Deployment Guide

## 🚨 Current Issue: "src directory not found"

The error you're seeing occurs because the `src` directory is not included in the Docker build context during deployment to Render.

## ✅ Solutions

### Solution 1: Use Simple Dockerfile (Recommended for Render)

1. **Rename the Dockerfile**:
   ```bash
   mv Dockerfile Dockerfile.multi
   mv Dockerfile.simple Dockerfile
   ```

2. **Update .dockerignore** (remove the line that excludes Dockerfile):
   ```dockerignore
   # Remove this line:
   # Dockerfile
   ```

### Solution 2: Fix Build Context (Advanced)

If you want to keep the multi-stage build, ensure your Render deployment settings have:
- **Build Context**: `.` (root directory)
- **Dockerfile Path**: `./Dockerfile`

### Solution 3: GitHub Repository Check

1. **Verify your GitHub repository** contains the `src` directory:
   ```bash
   # Check if src exists in your repo
   git ls-tree -r HEAD | grep src
   ```

2. **Ensure all files are committed**:
   ```bash
   git add .
   git commit -m "Add complete project structure"
   git push origin main
   ```

## 🔧 Quick Fix for Render Deployment

1. **Switch to simple Dockerfile**:
   ```bash
   # In your project directory
   cp Dockerfile.simple Dockerfile
   ```

2. **Update .dockerignore** to not exclude src:
   ```dockerignore
   # Make sure src/ is NOT in .dockerignore
   # Remove any line that says: src/
   ```

3. **Commit and push**:
   ```bash
   git add .
   git commit -m "Fix Docker build for Render deployment"
   git push origin main
   ```

4. **Redeploy on Render** - it should work now!

## 📋 Render Deployment Checklist

- [ ] Repository: `https://github.com/jashu06-lab/jashubackend`
- [ ] Branch: `main`
- [ ] Build Command: (leave default)
- [ ] Start Command: (leave default or use `java -jar target/*.jar`)
- [ ] Build Context: `.`
- [ ] Dockerfile Path: `./Dockerfile`

## 🐛 Debugging Commands

If you still get errors, add these to your Dockerfile temporarily:

```dockerfile
# Add after WORKDIR /app
RUN echo "Current directory:" && pwd
RUN echo "Files in directory:" && ls -la
RUN echo "Does src exist?" && ls -la src/ || echo "src not found"
```

## 🚀 Alternative Deployment Options

### Option A: Use render.yaml
```yaml
services:
  - type: web
    name: jashu-backend
    runtime: docker
    buildCommand: "docker build -t jashu-backend ."
    startCommand: "docker run -p $PORT:8080 jashu-backend"
```

### Option B: Use Maven Wrapper
```dockerfile
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests
EXPOSE 8080
CMD ["java", "-jar", "target/*.jar"]
```

## 📞 Need Help?

If you're still getting the error, please check:
1. Does your GitHub repo have a `src` folder?
2. Is the `src` folder committed to git?
3. Are you using the correct Dockerfile?

The most common cause is that the `src` directory is not in your GitHub repository!