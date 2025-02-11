# Submission Reminder App

This project is a shell script-based application that helps students track their assignment submission deadlines by setting up an automated reminder system.

## Steps to Run and Execute

### 1. Make `create_environment.sh` Executable
Before running the script, you need to grant it execution permissions.

```bash
chmod +x create_environment.sh
```

### 2. Run `create_environment.sh`
Execute the script to set up the environment. It will prompt you to enter your name, then create a directory named `submission_reminder_{yourName}` containing all necessary files and directories.

```bash
./create_environment.sh
```

### 3. Run the Submission Reminder App
After running `create_environment.sh`, navigate to the newly created directory and execute the `startup.sh` script.

```bash
cd submission_reminder_{yourName}
./startup.sh
```

This will start the submission reminder app, check for upcoming assignment deadlines, and display reminders accordingly.
