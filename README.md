# 2-months-journey

red-teaming-security-research/
 01-wgel-ctf-red-team-concepts/
https://medium.com/@darkwalkers/wgel-tryhackme-walk-through-22cc9f49fa0e
├── 02-networking-foundations/
│   ├── medium-writeup-reference.md
│   ├── protocol-notes/
│   │   ├── ip-mac-addressing.md
│   │   ├── tcp-ip-icmp.md
│   │   ├── arp-dhcp.md
│   │   └── subnetting-topologies.md
│   └── security-applications.md
│
├── 03-bluetooth-wireless-rf/
│   ├── case-studies/
│   │   ├── CVE-2023-27349-bluez-avrcp.md
│   │   ├── CVE-2025-27558-fragattacks-mesh.md
│   │   └── CVE-2024-56605-linux-bluetooth-l2cap.md
│   ├── case-study-template.md
│   ├── research-workflow.md
│   ├── hardening-checklist.md
│   └── planned-tools/
│       ├── bluetooth-posture-checker.md
│       ├── cve-patch-tracker.md
│       └── rf-threat-model-toolkit.md
│
├── 04-ai-red-teaming/
│   ├── certification-notes.md
│   ├── owasp-llm-top10-notes.md
│   ├── mitre-atlas-notes.md
│   └── evaluation-harness/
│       ├── DESIGN.md
│       └── planned-test-cases.md
│
├── methodology/
│   ├── research-methodology.md
│   └── patch-validation-workflow.md
│
├── ethics/
│   └── responsible-disclosure.md
│
└── references/
    └── references.md






Red Teaming & Advanced Security Research Portfolio

Learning offensive security concepts → researching vulnerabilities → building defensive patches.

A working record of structured security research across red teaming, networking, wireless/RF, and AI security. Completed work, active learning, and planned research are clearly separated — no inflated claims.

https://img.shields.io/badge/Status-Active%20Learning-blue
https://img.shields.io/badge/Scope-Authorized%20Labs%20Only-green

---

📍 Focus Areas

Area Stage Output
TryHackMe Wgel CTF Foundational study Red team concepts, defensive recommendations
Networking Foundations Documented Public Medium write-up
Bluetooth / Wireless / RF Early research CVE case studies, planned tooling
AI Red Teaming Certification milestone Planned evaluation harness

---

🧭 1. TryHackMe Wgel CTF — Red Teaming Concepts

Studied through the authorized Wgel CTF room to build foundational red team thinking:

· Reconnaissance, enumeration, and attack-surface analysis
· Initial-access concepts in a scoped lab environment
· Linux permissions and privilege boundaries
· Translating individual weaknesses into broader risk
· Defensive recommendations and structured reporting
https://medium.com/@darkwalkers/wgel-tryhackme-walk-through-22cc9f49fa0e

---

🌐 2. Networking Foundations

Documented in my Medium write-up: 1-Networking

Covers IP/MAC addressing, TCP/IP & ICMP, LAN topologies, subnetting, ARP, DHCP, routers/switches, and Linux fundamentals — the base layer for reconnaissance, traffic analysis, and vulnerability assessment.
https://medium.com/@darkwalkers/1-networking-cf5d02e5e39a?sharedUserId=darkwalkers
---

📡 3. Bluetooth, Wireless & RF Vulnerability Research

Early-stage research. Direction is honest: build from public advisories and controlled lab work toward repeatable vulnerability research and patch validation.

Studied public CVEs (sourced, not original discoveries):

· CVE-2023-27349 — BlueZ AVRCP array index validation (NVD)
· CVE-2025-27558 — FragAttacks against Wi-Fi mesh networks (NVD)
· CVE-2024-56605 — Linux Bluetooth L2CAP dangling pointer (MSRC)

Research workflow:
Discover → Verify Advisory → Analyze → Assess Impact → Apply Fix → Validate Patch → Publish

Planned projects (not yet built):

· Bluetooth Security Posture Checker
· Wireless Device Hardening Checklist
· CVE-to-Patch Research Tracker
· RF Threat Modeling Toolkit

All testing limited to owned devices, authorized labs, or explicitly permitted environments.
The session provides an in‑depth exploration of Bluetooth Classic, Bluetooth Low Energy (BLE), and Software Defined Radio (SDR) from a penetration testing perspective. It explains protocol structures, pairing mechanisms, vulnerabilities such as weak or fixed PINs, predictable hopping patterns, insecure profiles, and methods for device discovery even in non‑discoverable mode. Practical attack techniques include PIN brute forcing, LMP denial‑of‑service, headset eavesdropping, BLE service manipulation, replay, fuzzing, and man‑in‑the‑middle using tools like Ubertooth One, Bettercap, Crackle, NRF Connect. The SDR section covers fundamentals, hardware options, spectrum visualization, and real‑world exploits against RF systems including ADS‑B aircraft beacons, pagers, key fobs, and IoT sensors, highlighting both offensive uses and defensive monitoring strategies.
https://youtu.be/azj-p0CAzCI?si=vY9lxZRtCLzx7Mx1
https://cyberanalystacademy.org/blog/4-bluetooth-nfc-rfid-threats

---

🤖 4. AI Red Teaming

Milestone: Completed a two-hour examination for an AI Red Teaming Leader certification.
Issuer / verification: to be added when published.

Studied: prompt injection, sensitive-information exposure, insecure tool use, agent trust boundaries, adversarial robustness, mitigation & regression testing.

Planned project — AI Red Teaming Evaluation Harness (design stage)
Structured test cases · expected-vs-observed behavior · configurable checks · JSON & Markdown reports · regression testing.

Aligned with OWASP LLM Top 10 and MITRE ATLAS.
<img width="1280" height="1074" alt="image" src="https://github.com/user-attachments/assets/a4661541-39dd-4eba-a5ba-ae12711ea84c" />

---

🛡️ Methodology

1. Define scope & authorization
2. Verify from authoritative sources (NVD, MITRE, vendor advisories)
3. Separate observation from inference
4. Preserve reproducibility
5. Prioritize defensive impact
6. State limitations explicitly
7. Follow responsible disclosure

---

🗺️ Roadmap

· Done: Wgel CTF concepts · Networking write-up · AI Red Team cert exam
· Active: Wireless/RF CVE case studies · hardening checklist
· Planned: Posture checker · CVE tracker · AI evaluation harness · patch-validation case studies

---

⚖️ Ethics

Authorized environments only. No third-party wireless interference. Responsible disclosure before publication. No fabricated results, certifications, or findings — completed, active, and planned work are always labeled.

---

📚 Key References

· MITRE CVE · NIST NVD
· NIST SP 800-121 Rev. 2 — Bluetooth Security
· Bluetooth SIG Security
· CISA Advisories

---
[10/28/2026 10:46 PM] Xron: Goal: not to look advanced — to become useful. Understand vulnerabilities deeply enough to explain them clearly, and fix them well enough to matter.
