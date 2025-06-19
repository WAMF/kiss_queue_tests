import 'package:kiss_queue/kiss_queue.dart';

/// Test timing profiles for different test environments
enum TimingProfile { tight, lenient, loose }

/// Test configuration with configurable timing profiles
class TestConfig {
  /// Message retention period for expiration tests
  final Duration messageRetentionPeriod;

  /// Visibility timeout for visibility tests
  final Duration visibilityTimeout;

  /// Wait time for visibility timeout to expire in restore tests
  final Duration visibilityTimeoutWait;

  /// Max receive count for dead letter queue tests
  final int maxReceiveCount;

  /// Delay between operations for consistency
  final Duration operationDelay;

  /// Delay to wait for queue state consistency
  final Duration consistencyDelay;

  /// Current timing profile
  final TimingProfile profile;

  const TestConfig({
    required this.messageRetentionPeriod,
    required this.visibilityTimeout,
    required this.visibilityTimeoutWait,
    required this.maxReceiveCount,
    required this.operationDelay,
    required this.consistencyDelay,
    required this.profile,
  });

  /// Tight timing - optimized for high-performance, consistent environments
  static const tight = TestConfig(
    messageRetentionPeriod: Duration(milliseconds: 50),
    visibilityTimeout: Duration(milliseconds: 100),
    visibilityTimeoutWait: Duration(milliseconds: 150),
    maxReceiveCount: 2,
    operationDelay: Duration.zero,
    consistencyDelay: Duration.zero,
    profile: TimingProfile.tight,
  );

  /// Lenient timing - balanced for most test environments
  static const lenient = TestConfig(
    messageRetentionPeriod: Duration(milliseconds: 500),
    visibilityTimeout: Duration(milliseconds: 300),
    visibilityTimeoutWait: Duration(milliseconds: 400),
    maxReceiveCount: 2,
    operationDelay: Duration(milliseconds: 10),
    consistencyDelay: Duration(milliseconds: 25),
    profile: TimingProfile.lenient,
  );

  /// Loose timing - forgiving for slower or inconsistent environments
  static const loose = TestConfig(
    messageRetentionPeriod: Duration(seconds: 2),
    visibilityTimeout: Duration(seconds: 1),
    visibilityTimeoutWait: Duration(milliseconds: 1200),
    maxReceiveCount: 2,
    operationDelay: Duration(milliseconds: 50),
    consistencyDelay: Duration(milliseconds: 100),
    profile: TimingProfile.loose,
  );

  /// Create queue configuration from test config
  QueueConfiguration toQueueConfiguration() {
    return QueueConfiguration(
      messageRetentionPeriod: messageRetentionPeriod,
      visibilityTimeout: visibilityTimeout,
      maxReceiveCount: maxReceiveCount,
    );
  }

  /// Get a descriptive name for the current profile
  String get profileName {
    switch (profile) {
      case TimingProfile.tight:
        return 'Tight';
      case TimingProfile.lenient:
        return 'Lenient';
      case TimingProfile.loose:
        return 'Loose';
    }
  }
}
