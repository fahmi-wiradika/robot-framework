# Robot Framework - Saucedemo Test Automation

Project automation testing untuk website [Sauce Demo](https://www.saucedemo.com) menggunakan Robot Framework dengan Selenium Library.

## Struktur Proyek

```
robot-framework/
├── README.md                 # Dokumentasi proyek
├── requirements.txt          # Dependency Python
├── resources/                # Resource files untuk test
│   └── saucedemo/
│       ├── keywords/         # Custom keywords
│       │   ├── cart_keywords.robot
│       │   ├── checkout_keywords.robot
│       │   ├── common_keywords.robot
│       │   ├── login_keywords.robot
│       │   └── product_keywords.robot
│       ├── locators/         # Element locators
│       │   ├── cart_locators.robot
│       │   ├── checkout_locators.robot
│       │   ├── login_locators.robot
│       │   └── product_locators.robot
│       └── variables/        # Test variables
│           └── common_variables.robot
├── tests/                    # Test files
│   └── saucedemo/
│       ├── cart_tests.robot
│       ├── checkout_tests.robot
│       ├── login_tests.robot
│       └── product_tests.robot
└── results/                  # Test hasil eksekusi
    ├── log.html
    ├── output.xml
    └── report.html
```

### Penjelasan Direktori

- **resources/**: Berisi resource files yang digunakan oleh test cases
  - **keywords/**: Bersisi custom keywords yang mengkombinasikan library functions untuk business logic
  - **locators/**: Berisi definisi xpath/selector untuk setiap elemen di website
  - **variables/**: Berisi variabel test data seperti username, password, dll

- **tests/**: Berisi test cases yang diorganisir berdasarkan module/feature (login, product, cart, checkout)

- **results/**: Berisi output dari robot framework setelah menjalankan test
  - `log.html`: Detail log dari setiap test step
  - `report.html`: Summary report dari test execution
  - `output.xml`: XML output untuk integrasi dengan tools lain

## Setup Awal

### Prerequisites
- Python 3.7 atau lebih tinggi
- Git (untuk clone repository)

### 1. Clone Repository

```bash
git clone <repository-url>
cd robot-framework
```

### 2. Setup Python Virtual Environment

**Untuk Windows (PowerShell):**
```powershell
# Create virtual environment
python -m venv .venv

# Activate virtual environment
.\.venv\Scripts\Activate.ps1
```

**Untuk Windows (Command Prompt):**
```cmd
# Create virtual environment
python -m venv .venv

# Activate virtual environment
.venv\Scripts\activate.bat
```

**Untuk macOS/Linux:**
```bash
# Create virtual environment
python3 -m venv .venv

# Activate virtual environment
source .venv/bin/activate
```

### 3. Install Dependencies

Setelah virtual environment activated, install semua dependencies:

```bash
pip install -r requirements.txt
```

### 4. Verifikasi Instalasi

```bash
robot --version
```

## Menjalankan Test

### 1. Jalankan Semua Test

```bash
robot --outputdir results tests/
```

Perintah ini akan:
- Menjalankan semua test files di direktori `tests/`
- Menyimpan output di direktori `results/`
- Generate 3 file output: `log.html`, `report.html`, dan `output.xml`

### 2. Jalankan Test Berdasarkan Modul

```bash
# Test login
robot --outputdir results tests/saucedemo/login_tests.robot

# Test product
robot --outputdir results tests/saucedemo/product_tests.robot

# Test cart
robot --outputdir results tests/saucedemo/cart_tests.robot

# Test checkout
robot --outputdir results tests/saucedemo/checkout_tests.robot
```

### 3. Jalankan Test dengan Tag Tertentu

```bash
# Jalankan test dengan tag 'smoke'
robot --include smoke --outputdir results tests/

# Jalankan test dengan tag 'regression'
robot --include regression --outputdir results tests/

# Exclude test dengan tag 'skip'
robot --exclude skip --outputdir results tests/
```

### 4. Jalankan Test Secara Parallel (Menggunakan Pabot)

```bash
pabot --processes auto --outputdir results tests/
```

### 5. Melihat Test Report

Setelah test selesai dijalankan, buka `results/report.html` di browser untuk melihat hasil test:

```bash
start results/report.html   # Windows
open results/report.html    # macOS
xdg-open results/report.html # Linux
```

## Dependencies

- **robotframework**: Framework untuk automation testing
- **robotframework-seleniumlibrary**: Library untuk web automation menggunakan Selenium
- **webdriver-manager**: Automatic WebDriver management
- **robotframework-pabot**: Plugin untuk parallel test execution

## Troubleshooting

### Virtual Environment Tidak Activate
Pastikan menggunakan path yang benar sesuai OS Anda.

### Module Not Found Error
Pastikan:
1. Virtual environment sudah di-activate
2. Sudah menjalankan `pip install -r requirements.txt`

### Test Failed
1. Cek `results/log.html` untuk detail error
2. Verifikasi username/password di `resources/saucedemo/variables/common_variables.robot`
3. Pastikan koneksi internet stabil (test menggunakan live website)
