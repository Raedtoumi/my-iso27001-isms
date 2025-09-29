package technological.secure_coding

import future.keywords.in

# 8.28 - Secure coding
default secure_coding_compliant = false

# Check for code scanning
code_scanning_enabled {
    input.code_scanning.enabled == true
}

# Check for dependency scanning
dependency_scanning_enabled {
    input.dependency_scanning.enabled == true
}

# Check for secret scanning
secret_scanning_enabled {
    input.secret_scanning.enabled == true
}

# Check for critical vulnerabilities
no_critical_vulnerabilities {
    count(input.vulnerabilities.critical) == 0
}

secure_coding_compliant {
    code_scanning_enabled
    dependency_scanning_enabled
    secret_scanning_enabled
    no_critical_vulnerabilities
}

violations[violation] {
    not code_scanning_enabled
    violation := {
        "control": "8.28",
        "severity": "medium",
        "message": "Code scanning not enabled",
        "remediation": "Enable GitHub code scanning"
    }
}

violations[violation] {
    vuln := input.vulnerabilities.critical[_]
    violation := {
        "control": "8.28",
        "severity": "critical",
        "message": sprintf("Critical vulnerability: %s", [vuln.name]),
        "remediation": "Fix critical vulnerability immediately"
    }
}