<?php

namespace Drupal\core_event_dispatcher;

use Drupal\hook_event_dispatcher\HookEventDispatcherInterface;

/**
 * Defines events for token hooks.
 */
final class TokenHookEvents {

  /**
   * Provide replacement values for placeholder tokens.
   *
   * @Event
   *
   * @see \Drupal\core_event_dispatcher\Event\Token\TokensReplacementEvent
   * @see core_event_dispatcher_tokens()
   * @see hook_tokens()
   *
   * @var string
   */
  public const TOKEN_REPLACEMENT = HookEventDispatcherInterface::PREFIX . 'token.replacement';

  /**
   * Provide information about available placeholder tokens and token types.
   *
   * @Event
   *
   * @see \Drupal\core_event_dispatcher\Event\Token\TokensInfoEvent
   * @see core_event_dispatcher_token_info()
   * @see hook_token_info()
   *
   * @var string
   */
  public const TOKEN_INFO = HookEventDispatcherInterface::PREFIX . 'token.info';

}
