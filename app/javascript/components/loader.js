const initLoader = () => {
  // window.addEventListener('DOMContentLoaded', () => {
    console.log("Hi Yann!");
    const loader = document.querySelector(".loader");
    if (loader) {
      loader.classList.add("loaded");
    }
  // });
}

export { initLoader }

