# Lorman Domingo Mamuyac — Online Portfolio Website
> Built with Godot Engine 4.7 | Hosted via GitHub Pages with Custom Domain Mapping

A fully customized, web-deployed portfolio built entirely inside a 2D canvas using Godot 4.7. This project serves as a live demonstration of custom application design, frontend engine deployment, and a philosophical stance against the modern, walled-garden web hosting ecosystem.

---

## 🛠️ Project Architecture & Technical Choices

### Why Godot 4.7 for a Website?
Because I despise barebones HTML + CSS + JS programming.. I'm more of an algorithm maker, not a UI/UX designer, but I am not new to making entire systems on my own. You see I'm not very apt at artistic visuals... The AI-written section supposed to be here is replaced with my own actual opinion as it went so off-tangent because of the previous context messages I had with it during this time.

### Hosting & Infrastructure
* **Deployment Platform**: GitHub Pages (Static hosting).
* **Domain Configuration**: 1 Year Bought at a discount and will expire since the card used to buy it will expire befire it even tries to renew Unless conditions get better. How? CNAME, yes, reading what's already laid out in the documentations. When I first learned to read, I would read every thing I could read. XD But ofcourse not everything is worth that time so. You learn to 'seek', 'skim' or 'preface' what you read. The first sentence usually summarizes the entire paragraph.

---

## ⚖️ The Custom Domain Lifecycle: Radical Transparency

In alignment with the principle of **Freedom of Information** and total disclosure, the availability matrix of this site's entry points is explicitly detailed below.

### The Temporary Custom Domain
The site is currently accessible via a personalized custom domain. 
* **The Mechanism**: The domain was purchased for a fixed **1-year duration**. 
* **The Expiration**: It **will not renew**. The registration is tied to a dispensable, temporary payment card structured to expire before the automated billing cycle triggers. 
* **The Result**: At the end of the 1-year term, the custom domain will gracefully fault, bounce, and terminate.

### Structural Resilience (Why it doesn't matter)
Because the site is natively anchored to GitHub Pages infrastructure, the expiration of the commercial custom domain **will not destroy the portfolio**. The site features a permanent, hardcoded fallback architecture:

| Access URL Type | Domain Status | Lifetime |
| :--- | :--- | :--- |
| `https://bcs-ldm-code-lab.spaces` | Temporary (Disposable Card) | 1 Year Only |
| `https://avsgamer.github.io/lorman-mamuyac-portfolio` | Permanent Fallback | Indefinite |

---

## 🎨 The Philosophy of Bespoke Creation vs. Monopolized Templates

Building a website from scratch through a professional creator yields specific architectural advantages over generic "free" corporate platforms.

### Advantages of Bespoke Development
1. **Zero Forced Watermarks**: Free-tier web providers (Wix, WordPress.com, Weebly) plaster intrusive branding ("*Create a free website with...*") across your content, immediately stripping away professional credibility. This site features absolute brand purity.
2. **Complete Licensing Freedom**: You own the compilation. There are no shifting Terms of Service (ToS) that lock your layouts or charge extortionate monthly premiums to access basic features like custom scripts or forms.
3. **No Arbitrary Paywalls**: Features like custom file structures, media libraries, and viewport management are completely free under open-source frameworks.

### Disadvantages to Disclose
1. **SEO Optimization Hurdles**: Search engine crawlers (Googlebot) read text embedded in HTML easily. Because Godot compiles into WebAssembly (WASM) and renders onto a WebGL canvas, search engines cannot easily "read" the text inside the game engine. Metadata tags (`og:title`, `og:image`) must be manually injected into `index.html` to allow social media link previews to display.
2. **Initial Load Overhead**: The user's browser must download the WebAssembly engine runtime files before the site renders. This results in a higher initial loading time compared to a raw HTML/CSS text file.

---

## 📚 Infrastructure Context: GitHub & Its Alternatives

To maintain institutional transparency, creators must understand the history, corporate backing, and centralization risks of the tools they use.

### GitHub History & Corporate Ownership
* **Foundation**: Founded in 2008 as an independent platform for Git repository hosting, becoming the bedrock of open-source collaboration.
* **The Microsoft Acquisition (2018)**: Microsoft purchased GitHub for $7.5 billion. While this influx of capital stabilized infrastructure and made core features (like private repositories) free for everyone, it fundamentally shifted GitHub from an independent community hub into a subsidiary of a multi-trillion-dollar corporate monopoly.
* **The Reality Check**: Hosting on GitHub Pages means your data is subject to Microsoft's corporate data compliance policies, telemetry tracking, and localized system downtime.

### Decentralized & Independent Alternatives
If you wish to escape the Microsoft ecosystem entirely, excellent developer-focused alternatives exist:
* **GitLab**: A powerful DevOps lifecycle tool offering robust CI/CD pipelines. Can be completely self-hosted on private hardware.
* **Codeberg**: A non-profit, secure, and privacy-first Git hosting platform specifically built to provide an independent alternative to commercial networks.
* **SourceHut**: A minimalist, open-source, ad-free forge built entirely around speed, accessibility, and lightweight markdown layouts.

---

## 🚀 Future Roadmap: Migrating to a Personal Server

To achieve absolute digital sovereignty, future iterations of this portfolio will migrate away from third-party hosting networks entirely.

### The Objective
Host the portfolio directly on a **Personal Server / Self-Hosted Bare Metal Stack** running out of a home environment.

### Deployment Blueprint (In Brief)
1. **Hardware Selection**: Deploy on an energy-efficient single-board computer (such as a Raspberry Pi 5) or an old mini-PC running an enterprise Linux distribution (Ubuntu Server or Debian).
2. **Web Server Layer**: Install and configure **Nginx** or **Caddy** to serve the static exported Godot HTML5/WASM binaries.
3. **SSL Encryption**: Implement automated, free cryptographic security layers via **Let's Encrypt** certbots.
4. **Network Tunneling & DNS**: 
   * To prevent exposing a home residential IP address to the public web, route the traffic through a secure, encrypted tunnel network (such as **Cloudflare Tunnels** or a self-managed **WireGuard VPN** node hosted on a cheap, isolated virtual private server).
   * Map the DNS records natively to the tunnel endpoint, securing permanent uptime completely independent of GitHub or external hosting networks.
