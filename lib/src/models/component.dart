typedef ColorPickCollection = Map<String, String>;
typedef ComponentPickCollection = Map<String, ComponentPick?>;
typedef ComponentGroupItem =
    String Function(
      ComponentPickCollection components,
      ColorPickCollection colors,
    );
typedef ComponentGroup = Map<String, ComponentGroupItem>;
typedef ComponentGroupCollection = Map<String, ComponentGroup>;

class ComponentPick {
  final String name;
  final ComponentGroupItem value;

  ComponentPick({required this.name, required this.value});

  @override
  String toString() => 'ComponentPick(name: $name, value: $value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentPick &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          value == other.value;

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}
