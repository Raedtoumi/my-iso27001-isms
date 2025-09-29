package technological.access_control

import future.keywords.in

# 8.4 - Access to source code
default source_code_access_compliant = false

# Check repository access controls
repository_access_controlled {
    repo in input.repositories
    repo.private == true
    repo.collaborators > 0
}

# Check branch protection
branch_protection_enabled {
    repo in input.repositories
    repo.branch_protection.enabled == true
}

# Check code review requirements
code_review_required {
    repo in input.repositories
    repo.branch_protection.required_reviews > 0
}

source_code_access_compliant {
    repository_access_controlled
    branch_protection_enabled
    code_review_required
}

violations[violation] {
    repo := input.repositories[_]
    repo.private == false
    violation := {
        "control": "8.4",
        "severity": "high",
        "message": sprintf("Repository %s is public", [repo.name]),
        "remediation": "Make repository private or implement access controls"
    }
}