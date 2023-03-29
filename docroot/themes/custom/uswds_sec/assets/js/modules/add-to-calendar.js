(($, Drupal, drupalSettings) => {
  // TODO: refactor this code and remove jquery wherever possible

  // generate invite button
  $(".atcb-link").click(() => {
    const calID = "var.atc_event";
    var calSingle = LocalICS.ics(); // eslint-disable-line

    let contact = "";
    if ($(calID).find(".atc_organizer").text().length > 0) {
      contact = `<p>Contact: ${$(calID)
        .find(".atc_organizer")
        .text()
        .replace(/\n/g, "\\n")}</p>`;
    }
    calSingle.addEvent(
      $(calID).find(".atc_title").text(),
      $(calID).find(".atc_description").text().replace(/\n/g, "\\n") + contact,
      $(calID).find(".atc_description").html().replace(/\n/g, "\\n") + contact,
      $.trim($(calID).find(".atc_location").text()).replace(/\n/g, ", "),
      $(calID).find(".atc_date_start").text(),
      $(calID).find(".atc_date_end").text()
    );
    calSingle.download($(calID).find(".atc_title").text());
  });

  Drupal.behaviors.sec_add_to_calendar = {
    attach() {
      const calItem = drupalSettings.cal_item;

      if (typeof calItem !== "undefined") {
        if (typeof calItem.start !== "undefined" && calItem.start !== null) {
          $(".atc_date_start").text(calItem.start);
        }
        if (typeof calItem.end !== "undefined" && calItem.end !== null) {
          $(".atc_date_end").text(calItem.end);
        }
      }
    },
  };
})(jQuery, Drupal, drupalSettings);
