# Kiss Queue Tests

⚠️ **This package is for test use only. Do not include it in production apps.**

A comprehensive test suite for testing implementations of the `kiss_queue` package. This package provides a standardized set of tests that can be used to verify that any queue implementation correctly follows the `kiss_queue` interface.

## Features

- **Generic Test Suite**: Works with any queue implementation that follows the `kiss_queue` interface
- **Order Processing Model**: Uses a realistic e-commerce order processing scenario for testing
- **Comprehensive Coverage**: Tests all major queue operations including:
  - Enqueue and dequeue operations
  - Message visibility timeouts
  - Acknowledgment handling
  - Error conditions and edge cases
  - Message lifecycle management

## Getting Started

### Installation

Add this package to your `dev_dependencies` in `pubspec.yaml`:

```yaml
dev_dependencies:
  kiss_queue_tests: ^0.0.1
  test: ^1.24.0
```

### Usage

To test your queue implementation, import the test suite and run it with your queue factory:

```dart
import 'package:kiss_queue_tests/kiss_queue_tests.dart';
import 'package:test/test.dart';
import 'your_queue_implementation.dart';

void main() {
  runQueueTests<YourQueueClass, YourStorageType>(
    implementationName: 'Your Queue Implementation',
    factoryProvider: () => YourQueueFactory(),
    cleanup: () {
      // Clean up any resources (databases, files, etc.)
    },
  );
}
```

### Example with In-Memory Queue

```dart
import 'package:kiss_queue_tests/kiss_queue_tests.dart';
import 'package:test/test.dart';

void main() {
  runQueueTests<InMemoryQueue<Order>, Map<String, dynamic>>(
    implementationName: 'In-Memory Queue',
    factoryProvider: () => InMemoryQueueFactory<Order>(),
    cleanup: () {
      // No cleanup needed for in-memory implementation
    },
  );
}
```

## Test Coverage

The test suite covers the following scenarios:

### Basic Operations
- ✅ Enqueue and dequeue messages
- ✅ Message creation with auto-generated IDs
- ✅ Message creation with custom IDs
- ✅ Payload-only enqueue operations

### Message Lifecycle
- ✅ Message visibility timeout behavior
- ✅ Message acknowledgment
- ✅ Message restoration after timeout
- ✅ Duplicate message handling

### Error Handling
- ✅ Empty queue behavior
- ✅ Invalid acknowledgment attempts
- ✅ Malformed message handling

### Performance & Edge Cases
- ✅ High-volume message processing
- ✅ Concurrent access patterns
- ✅ Message ordering guarantees

## Test Models

The package includes a realistic `Order` model for testing:

```dart
class Order {
  final String orderId;
  final String customerId;
  final double amount;
  final List<String> items;
  
  // ... constructor and methods
}
```

This provides a practical example of how queues might be used in real applications.

## API Requirements

Your queue implementation must provide:

1. **QueueFactory**: Factory pattern for creating queue instances
2. **Queue Interface**: Implementation of the `kiss_queue` interface
3. **Message Support**: Handle `QueueMessage<T>` objects
4. **Storage Backend**: Any storage mechanism (memory, database, file, etc.)

## Contributing

This package is part of the WAMF (We Are Making Frameworks) ecosystem. Contributions are welcome!

## Repository

[GitHub Repository](https://github.com/WAMF/kiss_queue_tests)

## License

See the [LICENSE](LICENSE) file for details.
