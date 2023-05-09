// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("DOMContentLoaded", function(event) {
  // Get all the elements with the class 'update-time'
  const updateTimeElems = document.querySelectorAll('.update-time');
  
  // Loop through each element and update the text content with the time passed since the update
  updateTimeElems.forEach(function(elem) {
    const updateTime = new Date(elem.textContent);
    const currentTime = new Date();
    const timePassedMs = currentTime - updateTime;
    
    // Convert the time passed to a human-readable format
    const timePassed = getTimePassed(timePassedMs);
    
    // Update the text content of the element
    elem.textContent = timePassed;
  });
});

// Returns a human-readable string for the given time in milliseconds
function getTimePassed(timeMs) {
  const secondMs = 1000;
  const minuteMs = secondMs * 60;
  const hourMs = minuteMs * 60;
  const dayMs = hourMs * 24;
  
  if (timeMs < secondMs) {
    return "just now";
  } else if (timeMs < minuteMs) {
    const seconds = Math.round(timeMs / secondMs);
    return `${seconds} second${seconds > 1 ? 's' : ''} ago`;
  } else if (timeMs < hourMs) {
    const minutes = Math.round(timeMs / minuteMs);
    return `${minutes} minute${minutes > 1 ? 's' : ''} ago`;
  } else if (timeMs < dayMs) {
    const hours = Math.round(timeMs / hourMs);
    return `${hours} hour${hours > 1 ? 's' : ''} ago`;
  } else {
    const days = Math.round(timeMs / dayMs);
    return `${days} day${days > 1 ? 's' : ''} ago`;
  }
}
