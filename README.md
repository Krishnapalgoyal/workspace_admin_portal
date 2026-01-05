🧩 Workspace Admin Portal

A multi-tenant SaaS application built with Rails 8 that allows organizations to securely connect and manage their Google Workspace (Admin SDK) from a single unified admin panel.

This platform is designed for IT admins, SaaS providers, and enterprises who manage multiple organizations and want centralized control over Google Workspace users, devices, and policies.

🚀 Key Features

✅ Single URL SaaS (No subdomains)

👤 User authentication with Devise

🏢 Multi-organization support

🔐 Role-based access (Owner / Admin / Member)

🔁 Organization switching

🔗 Google Workspace Admin SDK integration

🔑 OAuth 2.0 secure authorization

🧱 Tenant isolation using Apartment

🎨 Modern UI with Tailwind CSS

🖥️ Extensible for devices, users, policies

🏗️ High-Level Architecture
User
 └── logs in (Devise)
      └── sees list of Organizations
           ├── Switch Organization (Session based)
           ├── Connect Google Workspace (OAuth)
           └── Manage Google Admin SDK resources

🔹 Important Architectural Decisions
Concern	Decision
URL structure	Single domain only
Multi-tenancy	Apartment gem
Tenant selection	Session-based (session[:organization_id])
Authentication	Global (Devise)
Authorization	Role-based (OrganizationMembership)
Google connection	Per organization
UI	Tailwind CSS
🧑‍💼 User Experience Flow
1️⃣ Authentication

User signs up or logs in using email/password

Authentication is global, not tenant-specific

2️⃣ Organization Management

User can:

Create a new organization

Be a member of multiple organizations

Switch organizations from the UI

Each organization has a role:

Owner – Full access

Admin – Manage Google Workspace

Member – Read-only access

3️⃣ Google Workspace Connection

Admin connects an organization to Google Workspace

OAuth consent is requested

Tokens are stored securely per organization

Organization is marked as Connected

4️⃣ Admin Dashboard

Based on selected organization:

Manage Google users

Manage devices

Manage permissions

(Future) Policies, audit logs, reports

🗂️ Core Models
User
 ├── has_many :organization_memberships
 └── has_many :organizations

Organization
 ├── has_many :organization_memberships
 ├── has_one  :google_workspace
 └── isolated per tenant (Apartment)

OrganizationMembership
 ├── belongs_to :user
 ├── belongs_to :organization
 └── role: owner | admin | member

GoogleWorkspace
 ├── belongs_to :organization
 ├── access_token
 ├── refresh_token
 ├── scopes
 └── connected flag

🔐 Google OAuth & Admin SDK

Uses OAuth 2.0 (offline access)

Scopes are limited to Google Admin SDK

Tokens are:

Stored per organization

Automatically refreshed

Admin SDK actions are always scoped to the currently selected organization

🛡️ Security Considerations

CSRF protection enabled

Secure token storage

Organization access enforced at controller level

Admin-only actions protected

No cross-tenant data access

🧪 Development & Testing

Rails 8

PostgreSQL

Tailwind CSS

Devise

Apartment

Signet OAuth2

Google Admin SDK (mockable for local testing)

🧭 Roadmap

 Google Users CRUD

 Device management

 Activity & audit logs

 Background jobs for sync

 Webhooks support

 Admin reports

 API access

 RBAC policies UI

🧑‍💻 Author

Krishnapal Goyal
Ruby on Rails Developer
Focused on SaaS, Multi-tenancy & Enterprise integrations
