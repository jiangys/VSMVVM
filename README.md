# MVC架构
Model：程序中要操纵的实际对象的抽象，为Controller提供经过抽象的业务数据，供Controller调度
View：视图，负责界面的元素的展示
Controller：控制器，管理View的声明周期及子view的生成和组装，负责Model和View之间的通信。

### MVC框架的优势
1. 应用广泛，几乎所有前端语言都有类似MVC的设计痕迹
2. 设计思想非常简洁，学习成本很低，新人上手非常容易。
MVC框架的问题：
MVC并没有对数据请求和处理逻辑代码应该放在哪一层做出明确地划分，因此一旦页面逻辑或交互稍微复杂，Controller就会变得很臃肿，代码也就越来越难维护。

# MVVM架构
MVVM框架是在MVC的基础上演化而来，MVVM想要解决的问题是尽可能地减少Controller的任务。

### Model：程序中要操纵的实际对象的抽象
View(ViewController)：MVVM中的View不再是UIView的子类，而变成了UIViewController的子类。这里的View实际上就是MVC中剥离了处理呈现View逻辑部分的Controller，因此它仍然有各种UIView的属性，仍然有ViewController的声明周期的各种方法，但是这里的Controller不再负责数据的请求以及处理逻辑，因此不再臃肿。
ViewModel：MVVM中，ViewModel代替了MVC中的Controller成为了协调者的角色，ViewModel被View（ViewController）持有，同时持有者Model。数据请求以及处理逻辑都放在ViewModel中，View(ViewController)就瘦了下来。

### MVVM框架的优势
1. View（ViewController）通过对ViewModel中的数据进行绑定来更新界面，不用通过逻辑或者条件判断来更新view，大大降低了复杂交互时出bug的几率。
2. View（ViewController）中代码简洁，后期的维护和优化比较容易。

### MVVM框架的问题
学习成本比MVC高，如果对MVVM的职责划分理解不透彻，很容易导致ViewModel的存在形同虚设, 反而增加了维护的成本。

# VSMVVM
MVVM框架的精简版，使用Block进行双向绑定操作。可以适应处理非常复杂的页面结构，使页面的每个元素都可以独立起来，增加修改不影响到其它元素。

# 具体实现思路
下面就CollectionView做说明，每一个内容都是一个小块Cell，都有自己的cellViewmodel，整个控制器有一个大的viewmodel，包装所有的cellViewmodel，就这样构建一个页面。
1. itemCell 是小块Cell，里面主要是初始化View，更新View的数据，需要返回cell的宽高
2. cellViewModel，是itemCell的ViewModel，给itemCell 提供数据，itemCell的点击事件也是回调到cellViewModel中。
3. Cell1ViewModel 和 item1Cell 组成一个小块Cell1
4. Cell2ViewModel 和 item2Cell 组成另一个小块Cell2
5. ViewModel 网络请求拿到数据之后，组装上面的小块Cell1ViewModel、小块Cell2ViewModel，通过方法【 - (Class)cellClass 】就可以拿到当前的itemCell
6. ViewModel中，还通过block的方式，对Controller回调绑定了事件，比如cell的点击事件、加载数据成功事件、按钮点击事件等

# Example
Demo有两种处理方式，一是通过继承基类，重写基类的方法来实现；二是通过协议，cell使用cellprotocol协议，cellModel使用cellModelProtocol协议。

# 使用方法
直接继承MVVMBase使用
1、新建一个控制器VSDemoCollectionViewController，继承于VSMVVMCollectionViewController
2、新建一个该控制器的ViewModel（VSDemoCollectionViewModel），继承于VSMVVMCollectionViewModel，负责管理所有的CellViewModel
3、新建一个CellModel（VSDemoCollectionItemCellModel），继承于VSMVVMCollectionViewCellModel，负责管理元素Cell，在方法cellClass中，返回关联的Cell（VSDemoCollectionItemCell）
4、新建一个Cell（VSDemoCollectionItemCell），继承于VSMVVMCollectionViewCell，需要重写VSMVVMCollectionViewCell中的方法，返回该cell的高度。
5、页面很复杂，需要重新步骤3和4，不断的拆分这个复杂的Cell.
6、最后，所有的cellModel都交由第2步的控制器的ViewModel整合加载。

# 说明
可以直接查看博客介绍，有类图。

# Author
jiangys, jys509@126.com

# License
VSMVVM is available under the MIT license. See the LICENSE file for more info.
