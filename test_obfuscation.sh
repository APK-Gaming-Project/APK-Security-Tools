### **File 13: `test_obfuscation.sh`**

```bash
#!/bin/bash

# Test script for obfuscation using ProGuard

# Test: Check if the obfuscation script runs successfully with a valid APK file
test_valid_apk() {
    # Simulate a valid APK file path
    APK_FILE="test_apk.apk"

    # Create a mock APK file for testing
    touch $APK_FILE

    # Run the obfuscation script
    ./obfuscate_apk.sh $APK_FILE

    # Check if the obfuscated APK file was created
    if [ -f "${APK_FILE%.*}-obfuscated.apk" ]; then
        echo "Test passed: Obfuscation successful for valid APK"
        rm "${APK_FILE%.*}-obfuscated.apk" # Cleanup
    else
        echo "Test failed: Obfuscated APK not created"
    fi

    # Cleanup mock APK file
    rm $APK_FILE
}

# Test: Check if the script fails gracefully when the APK file is missing
test_missing_apk() {
    # Simulate a non-existent APK file path
    NON_EXISTENT_APK="nonexistent.apk"

    # Run the obfuscation script and expect it to fail
    ./obfuscate_apk.sh $NON_EXISTENT_APK

    if [ $? -ne 0 ]; then
        echo "Test passed: Script failed gracefully for missing APK"
    else
        echo "Test failed: Script did not handle missing APK"
    fi
}

# Test: Check if the script fails when ProGuard is not installed
test_missing_proguard() {
    # Backup the existing ProGuard command path
    ORIGINAL_PATH=$(which proguard)

    # Temporarily remove ProGuard from the PATH
    export PATH=""

    # Simulate a valid APK file path
    APK_FILE="test_apk.apk"
    touch $APK_FILE

    # Run the obfuscation script and expect it to fail due to missing ProGuard
    ./obfuscate_apk.sh $APK_FILE

    if [ $? -ne 0 ]; then
        echo "Test passed: Script failed gracefully due to missing ProGuard"
    else
        echo "Test failed: Script did not handle missing ProGuard"
    fi

    # Restore ProGuard to the PATH and clean up
    export PATH=$ORIGINAL_PATH
    rm $APK_FILE
}

# Run all tests
echo "Running tests for obfuscation script..."

test_valid_apk
test_missing_apk
test_missing_proguard

echo "Tests completed."
```

### **Key Features:**
- **Bash Script for Testing**: This script performs basic tests on the `obfuscate_apk.sh` script, ensuring it behaves as expected.
- **Test Cases**:
  - **Valid APK Test**: Simulates a valid APK file, ensuring the obfuscation script creates an obfuscated APK.
  - **Missing APK Test**: Ensures the script handles the case where the APK file is missing and fails gracefully.
  - **Missing ProGuard Test**: Simulates the absence of ProGuard by temporarily removing it from the `PATH`, testing the script’s error handling.

### **How to Run the Tests:**
1. Ensure the `obfuscate_apk.sh` script and a valid ProGuard installation are present.
2. Run the test script using the following command:
   ```bash
   ./test_obfuscation.sh
   ```

The script will print the results of each test case.
