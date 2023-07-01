利用make_shared实例化对象的优势

ChatGPT

使用 **`std::make_shared`** 函数实例化对象具有几个优势：

1. 内存管理： **`std::make_shared`** 函数使用单个内存块来存储对象和控制块。控制块包含引用计数和其他与共享所有权相关的信息。这种内存布局减少了内存开销，并且可以更有效地管理内存。
2. 引用计数： **`std::make_shared`** 函数使用引用计数来管理共享指针的生命周期。每当创建一个指向对象的共享指针时，引用计数会增加。当所有指向对象的共享指针都被销毁时，引用计数为零，对象的内存会自动释放。这种自动的内存管理可以避免内存泄漏和悬空指针问题。
3. 性能优化： **`std::make_shared`** 函数可以通过在单个内存块中存储对象和控制块来提高性能。这种连续存储可以提高缓存局部性，减少内存碎片化，并提高访问对象的速度。
4. 异常安全： **`std::make_shared`** 函数提供了异常安全的保证。如果在创建共享指针的过程中抛出异常，已分配的内存会被自动清理，不会出现内存泄漏。

总的来说，使用 **`std::make_shared`** 函数实例化对象可以提供更高效的内存管理、引用计数、性能优化和异常安全性，使得共享指针的使用更加方便和可靠。

除了 **`std::make_shared`** 之外，还有其他类似的操作可以用于实例化对象和管理内存，包括：

1.  **`std::shared_ptr`** 构造函数：可以直接使用 **`std::shared_ptr`** 的构造函数来实例化对象，并管理对象的生命周期。例如：
    
    ```cpp
    
    std::shared_ptr<int> ptr(new int(42));
    
    ```
    
2. **`std::allocate_shared`**：类似于 **`std::make_shared`** ，它也可以用于实例化对象并返回一个共享指针，但它允许自定义分配器。例如：
    
    ```cpp
    
    std::allocate_shared<int>(MyAllocator<int>(), 42);
    
    ```
    
3.  **`std::shared_ptr`** 的 **`reset`** 函数： **`std::shared_ptr`** 的 **`reset`** 函数可以重新指定一个新的指针，并且会处理引用计数和内存释放。例如：
    
    ```cpp
    
    std::shared_ptr<int> ptr;
    ptr.reset(new int(42));
    
    ```
    
4. **`std::unique_ptr`** ： **`std::unique_ptr`** 是一种独占所有权的智能指针，它提供了类似的功能，但不支持共享所有权。使用 **`std::unique_ptr`** 可以实例化对象并进行内存管理，但不能与其他指针共享。例如：
    
    ```cpp
    
    std::unique_ptr<int> ptr(new int(42));
    
    ```
    

这些操作提供了不同的内存管理和所有权模型，可以根据具体的需求选择适合的方法。如果需要共享所有权， **`std::make_shared`** 和 **`std::shared_ptr`** 是较为常用的选择。如果只需要独占所有权，可以使用 **`std::unique_ptr`** 。

---

## 将一个代理模式代码由new改成make_shared

### 原代码

```c++
// Proxy.hpp

#include <iostream>
#include <string>

/**
* @brief 简单概述
* @brief 游戏类
*/
class Game
{
public:
	Game(std::string name) { m_sGameName = name; }
	~Game(){}
	std::string GetGameName() { return m_sGameName; }

private:
	std::string m_sGameName;
};

/**
* @brief 简单概述
* @brief 玩家类
*/
class Player
{
public:
	Player(Game* game){}
	virtual ~Player(){}
	virtual void OutputGameName() = 0;
	virtual void PlayGame() = 0;

protected:
	Game* m_pGame;
};

/**
* @brief 简单概述
* @brief 代理玩家
*/
class ProxyPlayer :public Player
{
public:
	ProxyPlayer(Game* game):Player(game) 
	{
		m_pGame = game;
	}
	~ProxyPlayer(){}

	void OutputGameName()
	{
		std::cout << "I am ProxyPlayer,Game name:" << m_pGame->GetGameName() << std::endl;
	}
	void PlayGame()
	{
		std::cout << "Start play game with ProxyPlayer." << std::endl;
	}
};

/**
* @brief 简单概述
* @brief 初级玩家
*/
class PrimaryPlayer :public Player
{
public:
	PrimaryPlayer(Game* game) :Player(game)
	{
		m_pProxyPlayer = new ProxyPlayer(game);
	}
	~PrimaryPlayer() 
	{
		delete m_pProxyPlayer;
		m_pProxyPlayer = NULL;
	}
	void OutputGameName()
	{
		std::cout << "/-- PrimaryPlayer:OutputGameName --/" << std::endl;
		m_pProxyPlayer->OutputGameName();
	}
	void PlayGame()
	{
		std::cout << "/-- PrimaryPlayer:PlayGame --/" << std::endl;
		m_pProxyPlayer->PlayGame();
	}

private:
	ProxyPlayer* m_pProxyPlayer;
};

/**
* @brief 简单概述
* @brief 中级玩家
*/
class MediumPlayer :public Player
{
public:
	MediumPlayer(Game* game) :Player(game)
	{
		m_pProxyPlayer = new ProxyPlayer(game);
	}
	~MediumPlayer()
	{
		delete m_pProxyPlayer;
		m_pProxyPlayer = NULL;
	}
	void OutputGameName()
	{
		std::cout << "/-- MediumPlayer:OutputGameName ---/" << std::endl;
		m_pProxyPlayer->OutputGameName();
	}
	void PlayGame()
	{
		std::cout << "/-- MediumPlayer:PlayGame --/" << std::endl;
		m_pProxyPlayer->PlayGame();
	}

private:
	ProxyPlayer* m_pProxyPlayer;
};


// main.cpp

#include "Proxy.hpp"

int main(int argc, char* argv[])
{
	Game* mGame = new Game("刀塔");

	ProxyPlayer* mProxyPlayer = new ProxyPlayer(mGame);
	mProxyPlayer->OutputGameName();
	mProxyPlayer->PlayGame();

	PrimaryPlayer* mRyPlayer = new PrimaryPlayer(mGame);
	mRyPlayer->OutputGameName();
	mRyPlayer->PlayGame();

	MediumPlayer* mMuPlayer = new MediumPlayer(mGame);
	mMuPlayer->OutputGameName();
	mMuPlayer->PlayGame();

	delete mGame; mGame = NULL;
	delete mProxyPlayer; mProxyPlayer = NULL;
	delete mRyPlayer; mRyPlayer = NULL;
	delete mMuPlayer; mMuPlayer = NULL;

    return 0;
}

```

---

### 修改后代码

```c++
// proxy.hpp
#include <iostream>
#include <string>


class Game{
public:
    Game(std::string name){m_sGameName = name;}
    std::string GetGameName(){return m_sGameName;}
private:
    std::string m_sGameName;
};

class Player{
public:
    Player(std::shared_ptr<Game> game){}
    virtual void OutputGameName() = 0;
    virtual void PlayGame() = 0;

protected:
//    Game* m_pGame;
    std::shared_ptr<Game> m_pGame;
};

class ProxyPlayer:public Player{
public:
    ProxyPlayer(std::shared_ptr<Game> game): Player(game)
    {
        m_pGame = game;
    }
    void OutputGameName(){
        std::cout << "I am ProxyPlayer,Game name:" << m_pGame->GetGameName() << std::endl;
    }
    void PlayGame(){
        std::cout << "Start play game with ProxyPlayer." << std::endl;
    }
};


class PrimaryPlayer:public Player{
public:
    PrimaryPlayer(std::shared_ptr<Game> game): Player(game){
        m_pProxyPlayer = std::make_shared<ProxyPlayer>(game);
    }
    void OutputGameName(){
        std::cout << "/-- PrimaryPlayer:OutputGameName --/" << std::endl;
        m_pProxyPlayer->OutputGameName();
    }
    void PlayGame(){
        std::cout << "/-- PrimaryPlayer:PlayGame --/" << std::endl;
        m_pProxyPlayer->PlayGame();
    }
private:
    std::shared_ptr<ProxyPlayer> m_pProxyPlayer;
};

class MediumPlayer :public Player
{
public:
    MediumPlayer(std::shared_ptr<Game> game) :Player(game)
    {
        m_pProxyPlayer = std::make_shared<ProxyPlayer>(game);
    }
    void OutputGameName()
    {
        std::cout << "/-- MediumPlayer:OutputGameName ---/" << std::endl;
        m_pProxyPlayer->OutputGameName();
    }
    void PlayGame()
    {
        std::cout << "/-- MediumPlayer:PlayGame --/" << std::endl;
        m_pProxyPlayer->PlayGame();
    }

private:
    std::shared_ptr<ProxyPlayer> m_pProxyPlayer;
};


// main.cpp
#include <iostream>
#include <memory>
#include "Proxy.hpp"

int main() {

//    Game* mGame = new Game("刀塔");
//    ProxyPlayer* mProxyPlayer = new ProxyPlayer(mGame);
//    mProxyPlayer->OutputGameName();
//    mProxyPlayer->PlayGame();
//
//    PrimaryPlayer* mRyPlayer = new PrimaryPlayer(mGame);
//    mRyPlayer->OutputGameName();
//    mRyPlayer->PlayGame();
//
//    MediumPlayer* mMuPlayer = new MediumPlayer(mGame);
//    mMuPlayer->OutputGameName();
//    mMuPlayer->PlayGame();
    std::shared_ptr<Game> mGame = std::make_shared<Game>("Dota2");

    std::shared_ptr<ProxyPlayer> mProxyPlayer = std::make_shared<ProxyPlayer>(mGame);
    mProxyPlayer->OutputGameName();
    mProxyPlayer->PlayGame();

    std::shared_ptr<PrimaryPlayer> mPrimaryPlayer = std::make_shared<PrimaryPlayer>(mGame);
    mPrimaryPlayer->OutputGameName();
    mPrimaryPlayer->PlayGame();

    std::shared_ptr<MediumPlayer> mMediumPlayer = std::make_shared<MediumPlayer>(mGame);
    mMediumPlayer->OutputGameName();
    mMediumPlayer->PlayGame();

    return 0;
}
```

---


使用make_shared实例化类时:

1. 类无需写析构函数
2. 类中创建或实例化时,也使用`std::shared_ptr`

---