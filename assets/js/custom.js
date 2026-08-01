// ============================================================
// Huaoyan's Blog — Custom JavaScript
// ============================================================

// --- Back to Top Button ---
(function () {
  const btn = document.createElement('button');
  btn.id = 'back-to-top';
  btn.innerHTML = '↑';
  btn.setAttribute('aria-label', '回到顶部');
  btn.setAttribute('title', '回到顶部');
  document.body.appendChild(btn);

  let scrollTimeout;
  window.addEventListener(
    'scroll',
    function () {
      clearTimeout(scrollTimeout);
      scrollTimeout = setTimeout(function () {
        if (window.scrollY > 400) {
          btn.classList.add('visible');
        } else {
          btn.classList.remove('visible');
        }
      }, 100);
    },
    { passive: true }
  );

  btn.addEventListener('click', function () {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
})();

// --- Smooth image loading ---
document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('.post-content img').forEach(function (img) {
    img.loading = 'lazy';
  });
});
