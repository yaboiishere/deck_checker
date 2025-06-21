module.exports = {
  darkMode: 'class', // enable 'dark:' variants via .dark class
  content: ["./app/**/*.html.erb", "./app/helpers/**/*.rb", "./app/javascript/**/*.js"],
  theme: {
    extend: {
      colors: {
        mtg: {
          primary: "#3b82f6",   // blue
          mythic: "#ef4444",    // red
          rare: "#facc15",      // yellow
          foil: "#a78bfa",      // purple shimmer
          background: "#1e1e2e" // dark mode bg
        },
      },
    },
  },
  plugins: [],
}
