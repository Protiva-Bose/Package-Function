import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../core/di/di_config.dart';

class AppViewModels {
  static final List<SingleChildWidget> viewModels = [
    // ChangeNotifierProvider<ParentScreenProvider>(create: (_) => getIt<ParentScreenProvider>(),),
  ];
}