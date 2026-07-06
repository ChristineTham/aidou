/* These styles mirror our design system (converted to plain CSS with Claude's help) from https://ui.product.ant.dev/button */
/* Base button styles */
.btn {
  position: relative;
  display: inline-flex;
  gap: 0.5rem;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  min-width: 5rem;
  height: 2.25rem;
  padding: 0.5rem 1rem;
  white-space: nowrap;
  font-family: Styrene;
  font-weight: 600;
  border-radius: 0.5rem;
  &:active {
    transform: scale(0.985);
  }
  /* Size variants */
  &.size-xs {
    height: 1.75rem;
    min-width: 3.5rem;
    padding: 0 0.5rem;
    border-radius: 0.25rem;
    font-size: 0.75rem;
    gap: 0.25rem;
  }
  &.size-sm {
    height: 2rem;
    min-width: 4rem;
    padding: 0 0.75rem;
    border-radius: 0.375rem;
    font-size: 0.75rem;
  }
  &.size-lg {
    height: 2.75rem;
    min-width: 6rem;
    padding: 0 1.25rem;
    border-radius: 0.6rem;
  }
  &:disabled {
    pointer-events: none;
    opacity: 0.5;
    box-shadow: none;
  }
  &:focus-visible {
    outline: none;
    --tw-ring-offset-shadow: var(--tw-ring-inset) 0 0 0 var(--tw-ring-offset-width) var(--tw-ring-offset-color);
    --tw-ring-shadow: var(--tw-ring-inset) 0 0 0 calc(1px + var(--tw-ring-offset-width)) var(--tw-ring-color);
    box-shadow: var(--tw-ring-offset-shadow), var(--tw-ring-shadow);
  }
  /* Primary variant */
  &.primary {
    font-weight: 600;
    color: hsl(var(--oncolor-100));
    background-color: hsl(var(--accent-main-100));
    background-image: linear-gradient(
      to right,
      hsl(var(--accent-main-100)) 0%,
      hsl(var(--accent-main-200) / 0.5) 50%,
      hsl(var(--accent-main-200)) 100%
    );
    background-size: 200% 100%;
    background-position: 0% 0%;
    border: 0.5px solid hsl(var(--border-300) / 0.25);
    box-shadow: 
      inset 0 0.5px 0px rgba(255, 255, 0, 0.15),
      0 1px 1px rgba(0, 0, 0, 0.05);
    text-shadow: 0 1px 2px rgb(0 0 0 / 10%);
    transition: all 150ms cubic-bezier(0.4, 0, 0.2, 1);
    &:hover {
      background-position: 100% 0%;
      background-image: linear-gradient(
        to right,
        hsl(var(--accent-main-200)) 0%,
        hsl(var(--accent-main-200)) 100%
      );
    }
    &:active {
      background-color: hsl(var(--accent-main-000));
      box-shadow: inset 0 1px 6px rgba(0, 0, 0, 0.2);
      transform: scale(0.985);
    }
  }
  /* Flat variant */
  &.flat {
    font-weight: 500;
    color: hsl(var(--oncolor-100));
    background-color: hsl(var(--accent-main-100));
    transition: background-color 150ms;
    &:hover {
      background-color: hsl(var(--accent-main-200));
    }
  }
  /* Secondary variant */
  &.secondary {
    font-weight: 600;
    color: hsl(var(--text-100) / 0.9);
    background-image: radial-gradient(
      ellipse at center,
      hsl(var(--bg-500) / 0.1) 50%,
      hsl(var(--bg-500) / 0.3) 100%
    );
    border: 0.5px solid hsl(var(--border-400));
    transition: color 150ms, background-color 150ms;
    &:hover {
      color: hsl(var(--text-000));
      background-color: hsl(var(--bg-500) / 0.6);
    }
    &:active {
      background-color: hsl(var(--bg-500) / 0.5);
    }
  }
  /* Outline variant */
  &.outline {
    font-weight: 600;
    color: hsl(var(--text-200));
    background-color: transparent;
    border: 1.5px solid currentColor;
    transition: color 150ms, background-color 150ms;
    &:hover {
      color: hsl(var(--text-100));
      background-color: hsl(var(--bg-400));
      border-color: hsl(var(--bg-400));
    }
  }
  /* Ghost variant */
  &.ghost {
    color: hsl(var(--text-200));
    border-color: transparent;
    transition: color 150ms, background-color 150ms;
    &:hover {
      color: hsl(var(--text-100));
      background-color: hsl(var(--bg-500) / 0.4);
    }
    &:active {
      background-color: hsl(var(--bg-400));
    }
  }
  /* Underline variant */
  &.underline {
    opacity: 0.8;
    text-decoration-line: none;
    text-underline-offset: 3px;
    transition: all 150ms;
    &:hover {
      opacity: 1;
      text-decoration-line: underline;
    }
    &:active {
      transform: scale(0.985);
    }
  }
  /* Danger variant */
  &.danger {
    font-weight: 600;
    color: hsl(var(--oncolor-100));
    background-color: hsl(var(--danger-100));
    transition: background-color 150ms;
    &:hover {
      background-color: hsl(var(--danger-200));
    }
  }
}
</style><style data-custom-css-index="1" data-custom-css-path="style.css">/* Anthropic Sans - Static fonts from assets.claude.ai */
@font-face {
  font-family: "Anthropic Sans";
  src: url("https://assets.claude.ai/Fonts/AnthropicSans-Text-Regular-Static.otf") format("opentype");
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Sans";
  src: url("https://assets.claude.ai/Fonts/AnthropicSans-Text-RegularItalic-Static.otf") format("opentype");
  font-weight: 400;
  font-style: italic;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Sans";
  src: url("https://assets.claude.ai/Fonts/AnthropicSans-Text-Medium-Static.otf") format("opentype");
  font-weight: 500;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Sans";
  src: url("https://assets.claude.ai/Fonts/AnthropicSans-Text-MediumItalic-Static.otf") format("opentype");
  font-weight: 500;
  font-style: italic;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Sans";
  src: url("https://assets.claude.ai/Fonts/AnthropicSans-Text-Semibold-Static.otf") format("opentype");
  font-weight: 600;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Sans";
  src: url("https://assets.claude.ai/Fonts/AnthropicSans-Text-SemiboldItalic-Static.otf") format("opentype");
  font-weight: 600;
  font-style: italic;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Sans";
  src: url("https://assets.claude.ai/Fonts/AnthropicSans-Text-Bold-Static.otf") format("opentype");
  font-weight: 700;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Sans";
  src: url("https://assets.claude.ai/Fonts/AnthropicSans-Text-BoldItalic-Static.otf") format("opentype");
  font-weight: 700;
  font-style: italic;
  font-display: swap;
}
/* Anthropic Serif Display - for headlines */
@font-face {
  font-family: "Anthropic Serif Display";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Display-Regular-Static.otf") format("opentype");
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif Display";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Display-RegularItalic-Static.otf") format("opentype");
  font-weight: 400;
  font-style: italic;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif Display";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Display-Medium-Static.otf") format("opentype");
  font-weight: 500;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif Display";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Display-Semibold-Static.otf") format("opentype");
  font-weight: 600;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif Display";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Display-Bold-Static.otf") format("opentype");
  font-weight: 700;
  font-style: normal;
  font-display: swap;
}
/* Anthropic Serif - Static fonts from assets.claude.ai */
@font-face {
  font-family: "Anthropic Serif";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Text-Regular-Static.otf") format("opentype");
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Text-RegularItalic-Static.otf") format("opentype");
  font-weight: 400;
  font-style: italic;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Text-Medium-Static.otf") format("opentype");
  font-weight: 500;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Text-MediumItalic-Static.otf") format("opentype");
  font-weight: 500;
  font-style: italic;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Text-Semibold-Static.otf") format("opentype");
  font-weight: 600;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Text-SemiboldItalic-Static.otf") format("opentype");
  font-weight: 600;
  font-style: italic;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Text-Bold-Static.otf") format("opentype");
  font-weight: 700;
  font-style: normal;
  font-display: swap;
}
@font-face {
  font-family: "Anthropic Serif";
  src: url("https://assets.claude.ai/Fonts/AnthropicSerif-Text-BoldItalic-Static.otf") format("opentype");
  font-weight: 700;
  font-style: italic;
  font-display: swap;
}
/* Color variables copied from https://github.com/anthropics/apps/blob/main/packages/ui/themes/generated/theme-colors.css */
:root {
  --always-white: 0 0% 100%;
  --always-black: 0 0% 0%;
  --constant-book-cloth: 15 55% 80%;
  --constant-clay: 15 60% 85%;
  --constant-kraft: 25 40% 83%;
  --constant-manilla: 40 20% 92%;
  --constant-slate-000: 0 0% 100%;
  --constant-slate-050: 48 33.3% 97.1%;
  --constant-slate-100: 53 28.6% 94.5%;
  --constant-slate-150: 48 25% 92.2%;
  --constant-slate-200: 50 20.7% 88.6%;
  --constant-slate-250: 51 16.5% 84.5%;
  --constant-slate-300: 50 11.5% 79.6%;
  --constant-slate-350: 50 9% 73.7%;
  --constant-slate-400: 49 6.5% 66.9%;
  --constant-slate-450: 48 4.8% 59.2%;
  --constant-slate-500: 53 3.2% 51.4%;
  --constant-slate-550: 51 3.1% 43.7%;
  --constant-slate-600: 48 2.7% 35.9%;
  --constant-slate-650: 48 3.4% 29.2%;
  --constant-slate-700: 60 2.5% 23.3%;
  --constant-slate-750: 60 2.1% 18.4%;
  --constant-slate-800: 60 2.7% 14.5%;
  --constant-slate-850: 30 3.3% 11.8%;
  --constant-slate-900: 30 4% 9.8%;
  --constant-slate-950: 60 2.6% 7.6%;
  --constant-slate-1000: 60 3.4% 5.7%;
}
:root:not(.dark) {
  --accent-brand: 15 63.1% 59.6%;
  --accent-main-000: 15 55.6% 52.4%;
  --accent-main-100: 15 55.6% 52.4%;
  --accent-main-200: 15 63.1% 59.6%;
  --accent-main-900: 0 0% 0%;
  --accent-pro-000: 251 34.2% 33.3%;
  --accent-pro-100: 251 40% 45.1%;
  --accent-pro-200: 251 61% 72.2%;
  --accent-pro-900: 253 33.3% 91.8%;
  --accent-secondary-000: 210 73.7% 40.2%;
  --accent-secondary-100: 210 70.9% 51.6%;
  --accent-secondary-200: 210 70.9% 51.6%;
  --accent-secondary-900: 211 72% 90%;
  --bg-000: 0 0% 100%;
  --bg-100: 48 33.3% 97.1%;
  --bg-200: 53 28.6% 94.5%;
  --bg-300: 48 25% 92.2%;
  --bg-400: 50 20.7% 88.6%;
  --bg-500: 50 20.7% 88.6%;
  --border-100: 30 3.3% 11.8%;
  --border-200: 30 3.3% 11.8%;
  --border-300: 30 3.3% 11.8%;
  --border-400: 30 3.3% 11.8%;
  --danger-000: 0 61.4% 22.4%;
  --danger-100: 0 58.6% 34.1%;
  --danger-200: 0 58.6% 34.1%;
  --danger-900: 0 50% 95%;
  --oncolor-100: 0 0% 100%;
  --oncolor-200: 60 6.7% 97.1%;
  --oncolor-300: 60 6.7% 97.1%;
  --text-000: 60 2.6% 7.6%;
  --text-100: 60 2.6% 7.6%;
  --text-200: 60 2.5% 23.3%;
  --text-300: 60 2.5% 23.3%;
  --text-400: 51 3.1% 43.7%;
  --text-500: 51 3.1% 43.7%;
}
:root.dark {
  --accent-brand: 15 63.1% 59.6%;
  --accent-main-000: 15 55.6% 52.4%;
  --accent-main-100: 15 63.1% 59.6%;
  --accent-main-200: 15 63.1% 59.6%;
  --accent-main-900: 0 0% 0%;
  --accent-pro-000: 251 84.6% 74.5%;
  --accent-pro-100: 251 40.2% 54.1%;
  --accent-pro-200: 251 40% 45.1%;
  --accent-pro-900: 250 25.3% 19.4%;
  --accent-secondary-000: 210 71.1% 62%;
  --accent-secondary-100: 210 70.9% 51.6%;
  --accent-secondary-200: 210 70.9% 51.6%;
  --accent-secondary-900: 210 55.9% 24.6%;
  --bg-000: 60 2.1% 18.4%;
  --bg-100: 60 2.7% 14.5%;
  --bg-200: 30 3.3% 11.8%;
