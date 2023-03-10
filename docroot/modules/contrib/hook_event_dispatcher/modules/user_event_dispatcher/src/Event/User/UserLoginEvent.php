<?php

namespace Drupal\user_event_dispatcher\Event\User;

use Drupal\Component\EventDispatcher\Event;
use Drupal\Core\Session\AccountInterface;
use Drupal\hook_event_dispatcher\Event\EventInterface;
use Drupal\user_event_dispatcher\UserHookEvents;

/**
 * Class UserLoginEvent.
 */
final class UserLoginEvent extends Event implements EventInterface {

  /**
   * Account.
   *
   * @var \Drupal\Core\Session\AccountInterface
   */
  private $account;

  /**
   * UserLoginEvent constructor.
   *
   * @param \Drupal\Core\Session\AccountInterface $account
   *   Account.
   */
  public function __construct(AccountInterface $account) {
    $this->account = $account;
  }

  /**
   * Get the account.
   *
   * @return \Drupal\Core\Session\AccountInterface
   *   Account.
   */
  public function getAccount(): AccountInterface {
    return $this->account;
  }

  /**
   * Get the dispatcher type.
   *
   * @return string
   *   The dispatcher type.
   */
  public function getDispatcherType(): string {
    return UserHookEvents::USER_LOGIN;
  }

}
