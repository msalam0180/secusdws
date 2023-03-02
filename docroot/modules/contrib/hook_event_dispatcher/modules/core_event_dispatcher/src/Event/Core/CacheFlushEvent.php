<?php

namespace Drupal\core_event_dispatcher\Event\Core;

use Drupal\Component\EventDispatcher\Event;
use Drupal\core_event_dispatcher\CoreHookEvents;
use Drupal\hook_event_dispatcher\Event\EventInterface;

/**
 * Class CacheFlushEvent.
 */
class CacheFlushEvent extends Event implements EventInterface {

  /**
   * {@inheritdoc}
   */
  public function getDispatcherType(): string {
    return CoreHookEvents::CACHE_FLUSH;
  }

}
