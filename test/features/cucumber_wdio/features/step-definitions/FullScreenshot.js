import { Given, When, Then } from '@wdio/cucumber-framework';
import { helper } from './classes/helper';

/**
 * Statements:
 * I take full page screenshot
 * I take full page screenshot of :arg1 URL
 * I take full page screenshot of :arg1 URL and :arg2(hide|remove) :arg3
 * I take full page screenshot and add text :arg4 to filename
 * Variables:
 * arg1 (optional) = URL
 * arg2 (optional) = hide|remove
 * arg3 (optional) = element(s) selector
 * arg4 (optional) = tag file name
 */
When(/^I take full page screenshot(?: of (?:"|')([^("|')]*)(?:"|') URL)?(?: and (hide|remove) (?:"|')([^("|')]*)(?:"|'))?(?: and add text (?:"|')([^("|')]*)(?:"|') to filename)?$/,
  async function (arg1, arg2, arg3, arg4) {
    // File/Folder structure full/[hide|remove]/url-size.jpg
    var file_name = 'full/';
    if (arg1 != null) {
      await browser.url(arg1);
      if (arg2 != null && arg3 != null) {
        file_name += helper.hideOrRemove(arg2, arg3);
      }
    }
    if (arg4 != null) {
      file_name += await helper.generateFileNameOnUrl(arg4);
    } else {
      file_name += await helper.generateFileNameOnUrl();
    }
    // Check a full page screens
    var result = await browser.checkFullPageScreen(file_name, { /* some options*/ });
    helper.checkTheResult(result);
  });
