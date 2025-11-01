function showToast(title, message, type = 'normal', duration = 3000) {
    const toastComponent = document.getElementById('toast-component');
    const toastTitle = document.getElementById('toast-title');
    const toastMessage = document.getElementById('toast-message');
    
    if (!toastComponent) return;

    // Reset styles
    toastComponent.style.border = '';
    toastComponent.style.background = '';
    toastComponent.style.color = '';

    // Apply theme colors based on type
    if (type === 'success') {
        // Biru kehijauan untuk sukses
        toastComponent.style.background = 'linear-gradient(to right, #064e3b, #065f46)'; 
        toastComponent.style.border = '1px solid #10b981';
        toastComponent.style.color = '#d1fae5';
    } else if (type === 'error') {
        // Merah terang untuk error
        toastComponent.style.background = 'linear-gradient(to right, #7f1d1d, #991b1b)';
        toastComponent.style.border = '1px solid #ef4444';
        toastComponent.style.color = '#fee2e2';
    } else {
        // Netral – abu gelap transparan (default)
        toastComponent.style.background = 'rgba(17, 24, 39, 0.9)'; // gray-900/90
        toastComponent.style.border = '1px solid rgba(55, 65, 81, 0.6)'; // gray-700
        toastComponent.style.color = '#f3f4f6'; // gray-100
    }

    // Update content
    toastTitle.textContent = title;
    toastMessage.textContent = message;

    // Show animation
    toastComponent.classList.remove('opacity-0', 'translate-y-10');
    toastComponent.classList.add('opacity-100', 'translate-y-0');

    // Hide after duration
    setTimeout(() => {
        toastComponent.classList.remove('opacity-100', 'translate-y-0');
        toastComponent.classList.add('opacity-0', 'translate-y-10');
    }, duration);
}
