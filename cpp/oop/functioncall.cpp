#include <string> // std::string
#include <cassert>
#include <cmath>  // sqrt и fabs

// эти классы определять заново не нужно
struct Expression
{
// put your code here
	
	virtual double evaluate() const = 0;
	virtual ~Expression(){}
};

struct BinaryOperation;
struct Number;



struct FunctionCall : Expression
{
    /**
     * @name имя функции, возможные варианты
     *       "sqrt" и "abs".
     *
     *       Объекты, std::string можно
     *       сравнивать с C-строками используя
     *       обычный синтаксис ==.
     *
     * @arg  выражение аргумент функции
     */
	
	
    FunctionCall(std::string const &name, Expression const *arg)
        : name_(name), arg_(arg)
    {
        assert(arg_);
        assert(name_ == "sqrt" || name_ == "abs");
    }

    // реализуйте оставшие методы из
    // интерфейса Expression и не забудьте
    // удалить arg_, как это сделано в классе
    // BinaryOperation

    std::string const & name() const
    {
        // put your code here
		return name_;
    }

    Expression const *arg() const
    {
        // here
		return arg_;
		
    }

    // and here
	double evaluate() const{
		double arg = arg_->evaluate();
		if(name_ == "sqrt") return sqrt(arg);
		else if(name_ == "abs") {
			return fabs(arg);
		}
		assert(0);
		return 0.0;
	}
	
	~FunctionCall(){
		
		delete arg_;
		
	}
	

private:
    std::string const name_;
    Expression const *arg_;
};

int main(){ return 0;}