#include <cassert>
#include <string>
#include <cmath>

struct Transformer;
struct Number;
struct BinaryOperation;
struct FunctionCall;
struct Variable;

struct Expression
{
    virtual ~Expression() { }
    virtual double evaluate() const = 0;
    virtual Expression *transform(Transformer *tr) const = 0;
};

struct Transformer
{
    virtual ~Transformer() { }
    virtual Expression *transformNumber(Number const *) = 0;
    virtual Expression *transformBinaryOperation(BinaryOperation const *) = 0;
    virtual Expression *transformFunctionCall(FunctionCall const *) = 0;
    virtual Expression *transformVariable(Variable const *) = 0;
};

struct Number : Expression
{
    Number(double value);
    double value() const;
    double evaluate() const;
    Expression *transform(Transformer *tr) const;

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
    BinaryOperation(Expression const *left, int op, Expression const *right);
    ~BinaryOperation();
    double evaluate() const;
    Expression *transform(Transformer *tr) const;
    Expression const *left() const;
    Expression const *right() const;
    int operation() const;

private:
    Expression const *left_;
    Expression const *right_;
    int op_;
};

struct FunctionCall : Expression
{
    FunctionCall(std::string const &name, Expression const *arg);
    ~FunctionCall();
    double evaluate() const;
    Expression *transform(Transformer *tr) const;
    std::string const &name() const;
    Expression const *arg() const;

private:
    std::string const name_;
    Expression const *arg_;
};

struct Variable : Expression
{
    Variable(std::string const name);
    std::string const & name() const;
    double evaluate() const;
    Expression *transform(Transformer *tr) const;

private:
    std::string const name_;
};


/**
 * реализйте все необходимые методы
 * если считаете нужным, то можете
 * заводить любые вспомогетльные
 * методы
 */
struct FoldConstants : Transformer
{
    Expression *transformNumber(Number const *number)
    { 
		return new Number(number->value());
	}

    Expression *transformBinaryOperation(BinaryOperation const *binop)
    {
		Expression const * lex = binop->left()->transform(this);
		Expression const * rex = binop->right()->transform(this);
		Number const * lnum = dynamic_cast<Number const *>(lex);
		Number const * rnum = dynamic_cast<Number const *>(rex);
		if(lnum && rnum){
			//delete rnum;
			//delete lnum;
			delete lex;
			delete rex;
			return new Number(binop->evaluate());
		}
	/*	else if(lnum){
			delete rnum;
			delete lnum;
			delete lex;
			delete rex;
			return new BinaryOperation(new Number(binop->left()->evaluate()), binop->operation(), binop->right()->transform(this));;
	
		}
		else if(rnum){
			delete rnum;
			delete lnum;
			//delete lex;
			//delete rex;
			return new BinaryOperation(binop->left()->transform(this), binop->operation(), new Number(binop->right()->evaluate()));;
	
		} */
		else{
			//delete rnum;
			//delete lnum;
			delete lex;
			delete rex;
			return new BinaryOperation(binop->left()->transform(this), binop->operation(), binop->right()->transform(this));;
	
		}
		
	}

    Expression *transformFunctionCall(FunctionCall const *fcall)
    {
		Expression const *ex = fcall->arg()->transform(this);
		Number const * num = dynamic_cast<Number const *>(ex);
		if(num) {
			//delete num;
			delete ex;
			return new Number(fcall->evaluate());
		}
		else{
			//delete num;
			delete ex;
			return new FunctionCall(fcall->name(), fcall->arg()->transform(this));
		}
	}

    Expression *transformVariable(Variable const *var)
    { 
		return new Variable(var->name());
	}
};

int main(){
    /*Number* n32 = new Number(32.0);
    Number* n16 = new Number(16.0);
    BinaryOperation* minus = new BinaryOperation(n32, BinaryOperation::MINUS, n16);
    FunctionCall* callSqrt = new FunctionCall("sqrt", minus);
    Variable* var = new Variable("var");
    BinaryOperation* mult = new BinaryOperation(var, BinaryOperation::MUL, callSqrt);
    FunctionCall* callAbs = new FunctionCall("abs", mult);
    FunctionCall* callSqrt2 = new FunctionCall("sqrt", callAbs);

    FoldConstants folder;
    Expression* newExpr = callSqrt2->transform(&folder); */
	return 0;
}