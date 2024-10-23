### **File 12: `test_signature_verifier.py`**

```python
import unittest
from unittest.mock import patch, MagicMock
import sys
import os

# Import the verify_apk_signature function from the verify_apk_signature script
from verify_apk_signature import verify_apk_signature

class TestAPKSignatureVerifier(unittest.TestCase):

    @patch("subprocess.run")
    def test_verify_apk_signature_success(self, mock_subprocess):
        """Test that the APK signature verification succeeds with a valid signature."""
        # Simulate a successful subprocess run (exit code 0)
        mock_subprocess.return_value = MagicMock(returncode=0)

        with self.assertLogs(level="INFO") as log:
            verify_apk_signature("/path/to/test.apk")
            mock_subprocess.assert_called_once_with(["apksigner", "verify", "/path/to/test.apk"], capture_output=True, text=True)
            self.assertIn("Signature verification successful", log.output[0])

    @patch("subprocess.run")
    def test_verify_apk_signature_failure(self, mock_subprocess):
        """Test that the APK signature verification fails with an invalid signature."""
        # Simulate a failed subprocess run (non-zero exit code)
        mock_subprocess.return_value = MagicMock(returncode=1, stderr="Verification failed")

        with self.assertRaises(SystemExit) as cm:
            verify_apk_signature("/path/to/test.apk")
            self.assertEqual(cm.exception.code, 1)
            mock_subprocess.assert_called_once_with(["apksigner", "verify", "/path/to/test.apk"], capture_output=True, text=True)

    def test_missing_apk_file(self):
        """Test that the script fails when the APK file is not found."""
        # Patch os.path.exists to return False, simulating a missing APK file
        with patch("os.path.exists", return_value=False):
            with self.assertRaises(SystemExit) as cm:
                verify_apk_signature("/nonexistent/path/to/test.apk")
                self.assertEqual(cm.exception.code, 1)

if __name__ == "__main__":
    unittest.main()
```

### **Key Features:**
- **Mocking the `subprocess.run`**: Simulates the execution of the `apksigner` command, allowing the tests to run without actually invoking the `apksigner` tool.
- **Test Cases**:
  - **Successful Verification**: Simulates a successful APK signature verification (exit code 0).
  - **Failed Verification**: Tests how the script handles a failed signature verification (non-zero exit code).
  - **Missing APK File**: Ensures the script exits with an error if the APK file does not exist.

### **How to Run the Tests:**
To run the tests, use the following command:
```bash
python -m unittest test_signature_verifier.py
```
