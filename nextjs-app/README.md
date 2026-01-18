# Thai VTuber Ranking - Next.js Application

Modern, high-performance web application for ranking and discovering Thai VTubers, built with Next.js 16, React 19, and TypeScript.

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Start production server
npm start
```

Open [http://localhost:3000](http://localhost:3000) - automatically redirects to `/channels`.

## 📊 Implementation Status

See [IMPLEMENTATION_STATUS.md](./IMPLEMENTATION_STATUS.md) for detailed progress tracking.

**Current Progress:** Phase 1 - ~60% complete
- ✅ Project setup & TypeScript types
- ✅ API data fetching with ISR
- ✅ i18n (Thai/English/Japanese)
- ✅ Channel rankings page
- ⏳ Filter tabs & search
- ⏳ Channel detail page
- ⏳ Layout components

## 🛠️ Technology Stack

- **Framework:** Next.js 16.1.3 (App Router + React Server Components)
- **Language:** TypeScript 5+
- **Styling:** Tailwind CSS 4
- **Fonts:** Sarabun (body), Kanit (headings)
- **i18n:** next-intl (Thai/English/Japanese)
- **State:** Zustand (minimal client state)
- **Charts:** Apache ECharts
- **UI:** Radix UI primitives

## 🌐 Internationalization

Access different locales:
- Thai (default): `http://localhost:3000/channels`
- English: `http://localhost:3000/en/channels`
- Japanese: `http://localhost:3000/ja/channels`

## 📁 Project Structure

```
nextjs-app/
├── app/                    # Next.js pages (App Router)
│   ├── layout.tsx         # Root layout with i18n
│   ├── page.tsx           # Redirects to /channels
│   └── channels/          # Channel rankings
├── components/             # React components
│   ├── ui/                # Reusable UI components
│   ├── channels/          # Channel-specific components
│   └── layout/            # Layout components (pending)
├── lib/                    # Core utilities
│   ├── api/               # Data fetching with ISR
│   ├── types/             # TypeScript types
│   ├── utils/             # Utilities (format, filter, sort)
│   └── stores/            # Zustand stores
└── locales/                # i18n translations
```

## 🎯 Key Features

### ISR (Incremental Static Regeneration)
- Channel list: 1-hour cache
- Automatic revalidation
- Optimal performance

### TypeScript
- Full type safety
- Migrated from Flutter models

### Server Components
- 85%+ server-rendered
- Minimal client JavaScript
- Fast initial load

### URL-Based State
- Shareable filter/sort links
- SEO-friendly
- Browser navigation support

## 📦 Available Scripts

```bash
npm run dev      # Development server
npm run build    # Production build
npm start        # Production server
npm run lint     # ESLint
```

## 🔧 Configuration

### Next.js Config (`next.config.ts`)
- next-intl plugin for i18n
- Image optimization for YouTube thumbnails
- TypeScript strict mode

### Tailwind CSS (`app/globals.css`)
- CSS v4 configuration
- Thai font variables
- Custom theme tokens

## 🚀 Deployment

### Vercel (Recommended)
1. Connect GitHub repository
2. Framework preset: Next.js
3. Build command: `npm run build`
4. Deploy

### Firebase App Hosting
Follow Firebase App Hosting documentation for Next.js deployment.

## 📝 Development Notes

### Adding New Components
1. Use Server Components by default
2. Add `'use client'` only for interactivity
3. Keep components in appropriate directories

### i18n Translations
Update locale files in `locales/`:
- `th.json` - Thai
- `en.json` - English
- `ja.json` - Japanese

### API Integration
All API calls use Google Cloud Storage endpoints (compatible with existing Flutter app).

## 🔗 Related Documentation

- [Next.js Docs](https://nextjs.org/docs)
- [next-intl Docs](https://next-intl-docs.vercel.app/)
- [Tailwind CSS Docs](https://tailwindcss.com/docs)
- [Migration Plan](../docs/MIGRATION_PLAN.md) (if exists)

## 🤝 Contributing

Follow the migration plan in phases:
1. Phase 1: Foundation + Channel browsing (current)
2. Phase 2: Video rankings + Live streams
3. Phase 3: Admin panel + Migration

## 📞 Contact

- GitHub: @chuymaster
- Issues: Use GitHub issues for bug reports

---

**Note:** This is a migration from Flutter Web to Next.js. The Flutter app remains in the parent directory for reference.
