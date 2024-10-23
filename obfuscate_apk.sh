```bash
#!/bin/bash

# Ensure that ProGuard is installed and configured properly.
# Set the path to your ProGuard installation
PROGUARD_HOME="/path/to/proguard"

# The APK file to be obfuscated
APK_FILE=$1

# The location where the obfuscated APK will be stored
OUTPUT_DIR="./obfuscated_apk"
OUTPUT_APK="${OUTPUT_DIR}/$(basename ${APK_FILE})"

# ProGuard configuration file (usually named proguard-rules.pro)
PROGUARD_CONFIG="proguard-rules.pro"

# Ensure ProGuard exists
if [ ! -d "$PROGUARD_HOME" ]; then
    echo "ProGuard not found at $PROGUARD_HOME. Please install ProGuard and update the path."
    exit 1
fi

# Check if APK file is provided
if [ -z "$APK_FILE" ]; then
    echo "Usage: $0 /path/to/apkfile.apk"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Run ProGuard to obfuscate the APK
echo "Obfuscating APK using ProGuard..."
"$PROGUARD_HOME/bin/proguard.sh" \
    -injars "$APK_FILE" \
    -outjars "$OUTPUT_APK" \
    -libraryjars "$ANDROID_HOME/platforms/android-30/android.jar" \
    -include "$PROGUARD_CONFIG"

if [ $? -eq 0 ]; then
    echo "Obfuscation successful! Obfuscated APK saved to: $OUTPUT_APK"
else
    echo "Error: Obfuscation failed."
    exit 1
fi
```

### **Key Features:**
- **Obfuscation Using ProGuard**: The script uses ProGuard to obfuscate the APK file, making it harder to reverse engineer.
- **Simple Execution**: Just run the script with the path to the APK file to obfuscate.
- **Customizable Configuration**: The script uses a ProGuard configuration file (`proguard-rules.pro`) to control the obfuscation process.

### **Usage:**
1. Ensure ProGuard is installed and set the correct path to **ProGuard** in the script (`PROGUARD_HOME`).
2. Make the script executable:
   ```bash
   chmod +x obfuscate_apk.sh
   ```
3. Run the script with the APK file path as an argument:
   ```bash
   ./obfuscate_apk.sh /path/to/your/apkfile.apk
   ```
