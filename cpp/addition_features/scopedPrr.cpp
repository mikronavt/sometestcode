struct Expression;
struct Number;
struct BinaryOperation;
struct FunctionCall;
struct Variable;

struct ScopedPtr
{
    // реализуйте следующие методы:
    //
    explicit ScopedPtr(Expression *ptr = 0){
		
		this->ptr_ = ptr;
	}
	
    ~ScopedPtr(){
		delete this->ptr_;
	}
    
	Expression* get() const{
		return this->ptr_;
	}
	
    Expression* release(){
		Expression *ptr = this->ptr_;
		ptr_=0;
		return ptr;
	}
	
	void reset(Expression *ptr = 0){
		delete ptr_;
		this->ptr_ = ptr;
	}
    
	Expression& operator*() const{
		return *ptr_;
	}
    
	Expression* operator->() const{
		return this->ptr_;
	}


private:
    // запрещаем копирование ScopedPtr
    ScopedPtr(const ScopedPtr&);
    ScopedPtr& operator=(const ScopedPtr&);

    Expression *ptr_;
};

int main(){
return 0;
}