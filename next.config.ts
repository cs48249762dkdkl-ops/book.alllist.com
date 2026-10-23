import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  reactStrictMode: true,
  // Keep development assets separate so a production build cannot remove
  // the CSS served by an open development tab.
  distDir: process.env.BOOK_NEXUS_BUILD_DIR === ".next-verify"
    ? ".next-verify"
    : process.env.NODE_ENV === "development" ? ".next-dev" : ".next",
};

export default nextConfig;
