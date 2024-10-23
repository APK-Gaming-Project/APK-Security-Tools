```python
import requests
import os
import sys

# VirusTotal API Key from environment variables
API_KEY = os.getenv('VT_API_KEY')
VIRUSTOTAL_URL = 'https://www.virustotal.com/vtapi/v2/file/scan'

def scan_apk(file_path):
    """Uploads and scans an APK file using the VirusTotal API."""
    if not API_KEY:
        print("Error: VirusTotal API Key not found. Set your API key in the environment variable 'VT_API_KEY'.")
        sys.exit(1)

    if not os.path.exists(file_path):
        print(f"Error: File '{file_path}' not found.")
        sys.exit(1)

    with open(file_path, 'rb') as apk_file:
        print(f"Uploading and scanning '{file_path}' with VirusTotal...")
        params = {'apikey': API_KEY}
        files = {'file': (file_path, apk_file)}
        response = requests.post(VIRUSTOTAL_URL, files=files, params=params)
    
    if response.status_code == 200:
        print("Scan successful!")
        print("Scan Report URL:", response.json().get('permalink'))
    else:
        print(f"Error: Failed to scan APK. Status code: {response.status_code}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python virus_total_scan.py /path/to/apkfile.apk")
        sys.exit(1)

    scan_apk(sys.argv[1])
```

### **Key Features:**
- **VirusTotal API Integration**: Uses the VirusTotal API to scan APK files for malware.
- **Error Handling**: Checks for the presence of the API key and the existence of the file.
- **Simple Execution**: Run the script from the command line, providing the APK file path as an argument.

### **Usage:**
1. Set your **VirusTotal API key** in an environment variable:
   ```bash
   export VT_API_KEY='your-api-key-here'
   ```
2. Run the script to scan your APK file:
   ```bash
   python virus_total_scan.py /path/to/your/apkfile.apk
   ```

Would you like to proceed with the next file? If so, please specify which one!
