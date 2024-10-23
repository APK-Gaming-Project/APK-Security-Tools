import subprocess
import sys
import os

def verify_apk_signature(apk_path):
    """Verifies the signature of the APK file using the apksigner tool."""
    apksigner_path = "apksigner"  # Ensure apksigner is in your PATH or provide the full path here

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

**Key Features:**
- **Signature Verification**: Utilizes the `apksigner` tool (part of Android SDK) to check whether an APK’s signature is valid and untampered.
- **Error Handling**: Provides informative error messages when the APK file or `apksigner` tool is missing.
- **Simple Execution**: Verifies an APK’s signature from the command line.

**Usage:**
1. Make sure the **`apksigner`** tool is installed and in your `PATH`. You can install it through the Android SDK:
   ```bash
   sdkmanager --install "build-tools;<version>"
   ```
2. Verify the APK signature by running the script:
   ```bash
   python verify_apk_signature.py /path/to/your/apkfile.apk
   ```
