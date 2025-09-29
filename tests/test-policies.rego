package test

import data.organizational.policy_management
import data.technological.access_control

# Test data
test_policies = [
    {
        "name": "Information Security Policy",
        "approval_status": "approved",
        "communication_date": "2024-01-01",
        "last_review": "2024-01-01"
    }
]

test_repositories = [
    {
        "name": "test-repo",
        "private": true,
        "collaborators": 2,
        "branch_protection": {
            "enabled": true,
            "required_reviews": 1
        }
    }
]

# Test organizational policies
test_policy_management_compliant {
    policy_management.policy_compliant with input as {"policies": test_policies}
}

test_policy_management_violations {
    violations := policy_management.violations with input as {"policies": []}
    count(violations) > 0
}

# Test technological policies
test_access_control_compliant {
    access_control.source_code_access_compliant with input as {"repositories": test_repositories}
}