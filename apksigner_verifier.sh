```bash
#!/bin/bash

# Check if the APK file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: ./apksigner_verifier.sh /path/to/your/apkfile.apk"
    exit 1
fi

APK_FILE=$1

# Check if the APK file exists
if [ ! -f "$APK_FILE" ]; then
    echo "Error: APK file '$APK_FILE' not found!"
    exit 1
fi

# Check if apksigner tool is installed
if ! command -v apksigner &> /dev/null
then
    echo "Error: apksigner tool not found. Please install Android SDK build-tools and ensure apksigner is in your PATH."
    exit 1
fi

# Verify the APK signature
echo "Verifying APK signature for $APK_FILE..."
apksigner verify --verbose "$APK_FILE"

if [ $? -eq 0 ]; then
    echo "APK signature verification successful!"
else
    echo "APK signature verification failed!"
    exit 1
fi
```

### **Key Features:**
- **APK Signature Verification**: This shell script uses the `apksigner` tool (part of Android SDK) to verify the integrity of APK files.
- **Error Handling**: Checks if the APK file and the `apksigner` tool are available, providing appropriate error messages if something is missing.
- **Simple Command-line Usage**: Run the script with an APK file path to check its signature.

### **Usage:**
1. Ensure **`apksigner`** is installed as part of the Android SDK build-tools and is available in your system's `PATH`.
2. Run the script to verify the APK signature:
   ```bash
   ./apksigner_verifier.sh /path/to/your/apkfile.apk
   ```

The script will print whether the APK’s signature is valid or not.
