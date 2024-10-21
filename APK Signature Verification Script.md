
### **APK Signature Verification Script**

This script verifies the signature of an APK file to ensure it hasn't been tampered with. It requires the `apksigner` tool from the Android SDK to check the APK signature.

**File Name:** `verify_apk_signature.py`

```python
import subprocess
import sys
import os

def verify_apk_signature(apk_path):
    """Verifies the signature of the APK file using apksigner tool."""
    apksigner_path = "apksigner"  # Ensure apksigner is in your PATH or provide full path here

    if not os.path.exists(apk_path):
        print(f"Error: APK file '{apk_path}' not found.")
        sys.exit(1)

    try:
        result = subprocess.run([apksigner_path, "verify", apk_path], capture_output=True, text=True)
        if result.returncode == 0:
            print(f"Signature verification successful for '{apk_path}'!")
        else:
            print(f"Error: Signature verification failed for '{apk_path}'.")
            print(result.stderr)
    except FileNotFoundError:
        print(f"Error: apksigner tool not found. Make sure it's installed and available in your PATH.")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python verify_apk_signature.py /path/to/your/apkfile.apk")
        sys.exit(1)

    verify_apk_signature(sys.argv[1])
```

### Usage:
1. Make sure the `apksigner` tool from the Android SDK is installed and available in your system's `PATH`.
2. Run the script to verify the APK signature:
   ```bash
   python verify_apk_signature.py /path/to/your/apkfile.apk
   ```

### Example Output:
```bash
Signature verification successful for 'your-apkfile.apk'!
```

---
