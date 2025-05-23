const ENGAGEMENT_CHECK_INTERVAL = 1000;
const ENGAGEMENT_THRESHOLD = 80.0 / 100.0;

let engagementMonitor = null;
let likeEngagementObserver = null;
let dislikeEngagementObserver = null;

function activateEngagementHighlight() {
    const buttonsContainer = document.querySelector('#top-level-buttons-computed');
    if (!buttonsContainer) {
        return false;
    }
    buttonsContainer.classList.add('yt-engagement-highlight');
    return true;
}

function deactivateEngagementHighlight() {
    const buttonsContainer = document.querySelector('#top-level-buttons-computed');
    if (buttonsContainer) {
        buttonsContainer.classList.remove('yt-engagement-highlight');
        return true;
    }
    return false;
}

function setupEngagementObservers() {
    // Clear existing observers
    if (likeEngagementObserver) {
        likeEngagementObserver.disconnect();
    }
    if (dislikeEngagementObserver) {
        dislikeEngagementObserver.disconnect();
    }

    // Find engagement buttons
    const likeButton = document.evaluate(
        '//*[@id="top-level-buttons-computed"]/segmented-like-dislike-button-view-model/yt-smartimation/div/div/like-button-view-model/toggle-button-view-model/button-view-model/button',
        document,
        null,
        XPathResult.FIRST_ORDERED_NODE_TYPE,
        null
    ).singleNodeValue;

    const dislikeButton = document.evaluate(
        '//*[@id="top-level-buttons-computed"]/segmented-like-dislike-button-view-model/yt-smartimation/div/div/dislike-button-view-model/toggle-button-view-model/button-view-model/button',
        document,
        null,
        XPathResult.FIRST_ORDERED_NODE_TYPE,
        null
    ).singleNodeValue;

    // Set up observers for engagement actions
    if (likeButton) {
        likeEngagementObserver = new MutationObserver(() => {
            deactivateEngagementHighlight();
        });
        likeEngagementObserver.observe(likeButton, {
            attributes: true,
            attributeFilter: ['aria-pressed']
        });
    }

    if (dislikeButton) {
        dislikeEngagementObserver = new MutationObserver(() => {
            deactivateEngagementHighlight();
        });
        dislikeEngagementObserver.observe(dislikeButton, {
            attributes: true,
            attributeFilter: ['aria-pressed']
        });
    }
}

function monitorViewerEngagement() {
    // Reset any existing monitoring
    if (engagementMonitor) {
        clearInterval(engagementMonitor);
    }
    deactivateEngagementHighlight();

    const videoPlayer = document.querySelector('video');
    if (!videoPlayer) {
        return;
    }

    engagementMonitor = setInterval(() => {
        if (videoPlayer.duration && videoPlayer.currentTime / videoPlayer.duration >= ENGAGEMENT_THRESHOLD) {
            if (activateEngagementHighlight()) {
                setupEngagementObservers();
            }
            clearInterval(engagementMonitor);
        }
    }, ENGAGEMENT_CHECK_INTERVAL);
}

// Inject engagement styles
const engagementStyles = document.createElement('link');
engagementStyles.rel = 'stylesheet';
engagementStyles.href = chrome.runtime.getURL('styles.css');
document.head.appendChild(engagementStyles);

// Initialize engagement tracking
document.addEventListener('yt-navigate-finish', monitorViewerEngagement);
monitorViewerEngagement();
