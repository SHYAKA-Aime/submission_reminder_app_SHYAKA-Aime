#!/bin/bash

# Prompt the user for their name
read -p "Enter your name: " name
main_dir="submission_reminder_${name}"

# Create the main application directory
mkdir -p "$main_dir" || { echo "Error creating directory $main_dir"; exit 1; }

# Create the required subdirectories: app, modules, assets, config
mkdir -p "$main_dir/app" "$main_dir/modules" "$main_dir/assets" "$main_dir/config"

# Create config.env in the config directory with the provided content
cat << 'EOF' > "$main_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Create reminder.sh in the app directory with the provided content
cat << 'EOF' > "$main_dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
chmod +x "$main_dir/app/reminder.sh"

# Create functions.sh in the modules directory with the provided content
cat << 'EOF' > "$main_dir/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
chmod +x "$main_dir/modules/functions.sh"

# Create submissions.txt in the assets directory with the provided records plus at least 5 additional student records
cat << 'EOF' > "$main_dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Ngenzi, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Aime, Shell Navigation, not submitted
Frank, Shell Navigation, not submitted
Kalisa, Shell Navigation, not submitted
Henry, Shell Navigation, not submitted
Irene, Shell Navigation, not submitted
Kenny, Shell Navigation, not submitted
Kassim, Shell Navigation, not submitted
Herve, Shell Navigation, not submitted
Willy, Shell Navigation, not submitted
Shema, Shell Navigation, not submitted
EOF

# Create startup.sh in the main directory to start the application
cat << 'EOF' > "$main_dir/startup.sh"
#!/bin/bash
echo "Starting Submission Reminder App..."
./app/reminder.sh
EOF
chmod +x "$main_dir/startup.sh"

echo "Environment setup complete in directory: $main_dir"
