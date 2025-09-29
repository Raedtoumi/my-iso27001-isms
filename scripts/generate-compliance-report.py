#!/usr/bin/env python3
import json
import os
from datetime import datetime
import glob

def generate_compliance_report():
    """Generate comprehensive compliance report"""
    report = {
        "generated_at": datetime.now().isoformat(),
        "framework": "ISO27001-2022",
        "compliance_summary": {
            "overall_score": 0,
            "controls_implemented": 0,
            "controls_total": 93,
            "by_domain": {}
        },
        "control_details": {},
        "violations": [],
        "recommendations": []
    }
    
    # Load evidence files
    evidence_files = glob.glob("evidence/github/*.json")
    for evidence_file in evidence_files:
        with open(evidence_file, 'r') as f:
            evidence = json.load(f)
        
        # Extract domain from filename
        domain = os.path.basename(evidence_file).replace('-evidence.json', '')
        report["compliance_summary"]["by_domain"][domain] = {
            "status": "evaluated",
            "evidence_file": evidence_file
        }
    
    # Calculate compliance score (simplified)
    implemented_controls = 15  # This would be calculated from policy evaluations
    report["compliance_summary"]["controls_implemented"] = implemented_controls
    report["compliance_summary"]["overall_score"] = round(
        (implemented_controls / report["compliance_summary"]["controls_total"]) * 100, 1
    )
    
    # Add sample recommendations
    report["recommendations"] = [
        {
            "control": "5.1",
            "priority": "high",
            "description": "Formally approve and communicate all security policies",
            "action": "Update policy approval dates and communication records"
        },
        {
            "control": "8.4",
            "priority": "medium", 
            "description": "Implement branch protection rules for all repositories",
            "action": "Enable branch protection requiring code reviews"
        }
    ]
    
    # Save report
    with open("compliance-report.json", "w") as f:
        json.dump(report, f, indent=2)
    
    print(f"Compliance report generated: {report['compliance_summary']['overall_score']}%")
    return report

if __name__ == "__main__":
    generate_compliance_report()