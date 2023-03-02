<?php

namespace Drupal\Tests\akamai\Functional;

use Drupal\Tests\BrowserTestBase;

/**
 * Test the Akamai Homepage Clearing.
 *
 * @description Test Akamai cache clearings of the site homepage.
 *
 * @group Akamai
 */
class AkamaiHomepageTest extends BrowserTestBase {

  /**
   * Node created.
   *
   * @var \Drupal\node\NodeInterface
   */
  protected $node;

  /**
   * Path to Drupal homepage.
   *
   * @var string
   */
  protected $homepage;

  /**
   * Default theme.
   *
   * @var string
   */
  protected $defaultTheme = 'bartik';

  /**
   * User with admin rights.
   *
   * @var \Drupal\user\UserInterface
   */
  protected $privilegedUser;

  /**
   * Modules to enable.
   *
   * @var array
   */
  protected static $modules = ['system_test', 'block', 'node', 'akamai'];

  /**
   * {@inheritdoc}
   */
  protected function setUp() : void {
    parent::setUp();
    // Create and log in our privileged user.
    $this->privilegedUser = $this->drupalCreateUser([
      'administer blocks',
      'purge akamai cache',
    ]);
    $this->drupalLogin($this->privilegedUser);
    $this->drupalCreateContentType(['type' => 'article']);
    $this->node = $this->drupalCreateNode(['type' => 'article']);
    $this->homepage = "/node/{$this->node->id()}";

    // Make node page default.
    $this->config('system.site')->set('page.front', $this->homepage)->save();
  }

  /**
   * Tests that Akamai Cache Clear block can clear the homepage.
   */
  public function testHomepageClear() {
    // Set up theme.
    $theme_settings = $this->config('system.theme');
    foreach (['bartik'] as $theme) {
      // Configure and save the block.
      $this->drupalPlaceBlock('akamai_cache_clear_block', [
        'region' => 'content',
        'theme' => $theme,
      ]);
      // Set the default theme and ensure the block is placed.
      $theme_settings->set('default', $theme)->save();
      // The cache clearing block should pick up the current URL as the clearing
      // target.
      $this->drupalGet($this->homepage);
      $this->assertSession()
        ->responseContains($this->homepage);
    }
  }

}
