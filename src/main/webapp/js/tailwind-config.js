tailwind.config = {
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        primary: "#D8A48F",          // rose gold
        secondary: "#8FBC8F",        // sage green
        "background-light": "#FDFBF7",
        "background-dark": "#1F1B1A",
        "surface-light": "#FFFFFF",
        "surface-dark": "#2D2625",
      },
      fontFamily: {
        display: ["Playfair Display", "serif"],
        body: ["Lato", "sans-serif"],
      },
      borderRadius: {
        DEFAULT: "0.75rem",
      },
    },
  },
};
