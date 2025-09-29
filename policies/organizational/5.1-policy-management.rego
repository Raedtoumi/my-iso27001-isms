package organizational.policy_management

import future.keywords.in

# 5.1 - Information security policies
default policy_compliant = false

# Check if policies exist and are documented
policies_exist {
    count(input.policies) > 0
}

policies_approved {
    policy in input.policies
    policy.approval_status == "approved"
}

policies_communicated {
    policy in input.policies
    policy.communication_date != ""
}

policies_reviewed {
    policy in input.policies
    time.now_ns() - policy.last_review < 31536000000000000  # 1 year
}

policy_compliant {
    policies_exist
    policies_approved
    policies_communicated
    policies_reviewed
}

violations[violation] {
    not policies_exist
    violation := {
        "control": "5.1",
        "severity": "high",
        "message": "Information security policies not defined",
        "remediation": "Create and document information security policies"
    }
}