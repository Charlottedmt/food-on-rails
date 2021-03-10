const initLoader = () => {
  window.addEventListener("load", () => {
    const loader = document.querySelector(".loader");
    if (loader) {
      loader.classList.add("loaded");
    }
  });
}

export { initLoader }

