#include <cassert> // assert
#include <iostream>
#include <cstddef>
using namespace std;

struct Expression
{
// put your code here
	
	virtual double evaluate() const = 0;
	virtual ~Expression(){}
};

struct Number : Expression
{
    Number(double value)
        : value_(value)
    {}

    double value() const
    { return value_; }

    double evaluate() const
    { return value_; }

private:
    double value_;
};

struct BinaryOperation : Expression
{
    enum {
        PLUS = '+',
        MINUS = '-',
        DIV = '/',
        MUL = '*'
    };

    BinaryOperation(Expression const *left, int op, Expression const *right)
        : left_(left), op_(op), right_(right)
    { assert(left_ && right_); }

    ~BinaryOperation()
    {
        delete left_;
        delete right_;
    }

    Expression const *left() const
    { return left_; }

    Expression const *right() const
    { return right_; }

    int operation() const
    { return op_; }

    double evaluate() const
    {
        double left = left_->evaluate();
        double right = right_->evaluate();
        switch (op_)
        {
        case PLUS: return left + right;
        case MINUS: return left - right;
        case DIV: return left / right;
        case MUL: return left * right;
        }
        assert(0);
        return 0.0;
    }

private:
    Expression const *left_;
    Expression const *right_;
    int op_;
};

bool check_equals(Expression const *left, Expression const *right)
{
    // put your code here
	//size_t ll = left;
	//size_t rr = right;
	
	//cout<<sizeof(Expression);
	
	cout << ((size_t *)left)[0]<<" "; 
	cout << ((size_t *)right)[0]<<" ";
	return (((size_t *)left)[0] == ((size_t *)right)[0]);
}

int main(){
	Number * l = new Number(1);
	
	Number * r2 = new Number(5);
	const Expression * r = new BinaryOperation(l,  3, l);
	const Expression * r3 = new BinaryOperation(r2,  5, r);
	cout << "first" << check_equals(l, r) << " ";
	cout<< "second" << check_equals(l, r2) << " ";
	cout << "third" << check_equals(r, r3);
	return 0;
}