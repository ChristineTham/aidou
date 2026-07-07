# Agentic AI Identity and Access Management: A New Approach — Cloud Security Alliance

> [!NOTE]
> Source: [csa-agentic-ai-iam.md](../../sources/ai-governance/csa-agentic-ai-iam.md) — Cloud Security Alliance, *Agentic AI Identity and Access Management: A New Approach*, 18 August 2025. https://cloudsecurityalliance.org/artifacts/agentic-ai-identity-and-access-management-a-new-approach
> Industry-body publication; content extracted via WebFetch (the full artifact is a downloadable CSA document), so this rests on the summary and key quotes, not the full text.

## Abstract

The Cloud Security Alliance argues that conventional identity and access management (IAM) — built for static applications and human users — is inadequate for autonomous AI agents operating in multi-agent systems, and proposes a specialised framework for governing agent identity. It is the point at which agent identity and access became a formalised industry-body topic rather than only vendor commentary.

## Key points

- **Agent identities:** "rich, verifiable Agent IDs that support traceable, dynamic authentication" built on decentralised identifiers and verifiable credentials rather than legacy protocols.
- **Access control:** "fine-grained, context-aware access control using just-in-time credentials" aligned with zero-trust principles, beyond traditional role-based access.
- **Auditability and scale:** "zero trust IAM systems capable of scaling to thousands of agents" with real-time monitoring.
- **Protocol gap:** identifies the "shortcomings of OAuth 2.1, SAML, and OIDC in agentic environments" — legacy standards misalign with agent autonomy.

This grounds the chapter's service-account rule (§5.4.1): give each agent its own scoped, least-privilege, auditable identity rather than a borrowed human credential.
