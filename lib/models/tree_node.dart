class TreeNode {
  TreeNode({required this.id, required this.title, required this.children});
  String id;
  String title;
  List<TreeNode> children;

  TreeNode copyWith({final String? title}) {
    return TreeNode(id: id, title: title ?? this.title, children: children);
  }
}
