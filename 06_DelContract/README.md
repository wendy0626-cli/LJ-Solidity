# LJ-Solidity

"selfdestruct" has been deprecated. The underlying opcode will eventually undergo breaking changes, and its use is not recommended.

selfdestruct命令可以用来删除智能合约，并将该合约剩余ETH转到指定地址。selfdestruct是为了应对合约出错的极端情况而设计的。它最早被命名为suicide（自杀），但是这个词太敏感。为了保护抑郁的程序员，改名为selfdestruct；在 v0.8.18 版本中，selfdestruct 关键字被标记为「不再建议使用」，在一些情况下它会导致预期之外的合约语义，但由于目前还没有代替方案，目前只是对开发者做了编译阶段的警告，相关内容可以查看 EIP-6049。
https://blog.soliditylang.org/2023/02/01/solidity-0.8.18-release-announcement/
https://eips.ethereum.org/EIPS/eip-6049

注意事项
1.对外提供合约销毁接口时，最好设置为只有合约所有者可以调用，可以使用函数修饰符onlyOwner进行函数声明。
2.当合约被销毁后与智能合约的交互也能成功，并且返回0。
3.当合约中有selfdestruct功能时常常会带来安全问题和信任问题，合约中的Selfdestruct功能会为攻击者打开攻击向量
(例如使用selfdestruct向一个合约频繁转入token进行攻击，这将大大节省了GAS的费用，虽然很少人这么做)，此外，此功能还会降低用户对合约的信心。

selfdestruct是智能合约的紧急按钮，销毁合约并将剩余ETH转移到指定账户。
当著名的The DAO攻击发生时，以太坊的创始人们一定后悔过没有在合约里加入selfdestruct来停止黑客的攻击吧。
