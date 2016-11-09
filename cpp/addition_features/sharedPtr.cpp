struct Expression;
struct Number;
struct BinaryOperation;
struct FunctionCall;
struct Variable;

struct Links{
	int get(){
		return count;
	}
	
	void inc(){
		count++;
	}
	
	void dec(){
		count--;
	}
	
	private:
	int count = 0;
};

struct SharedPtr
{
    // реализуйте следующие методы
    //
	
    explicit SharedPtr(Expression *ptr = 0){
		if(ptr!=0){
			l = new Links();
			l->inc();
		}
		this->ptr_ = ptr;
		
	} 
	
    ~SharedPtr() {
		if(ptr_!=0){
			l->dec();
		
			if(l->get()==0){
				delete this->ptr_;
				delete l;
			}
		}
	}
    
	SharedPtr(const SharedPtr & Sh){
		if(Sh.get()!=0){
			l = Sh.getLink();
			l->inc();
		}
			this->ptr_ = Sh.get();
		
	}
    
	SharedPtr& operator=(const SharedPtr & Sh){
		if(this->ptr_!=Sh.get()){
			if(this->ptr_!=0){
				
				l->dec();
			
				if(l->get()==0){
					delete this->ptr_;
					delete l;
				}
			}
			if(Sh.get()!=0){
				
				this->l = Sh.getLink();
				l->inc();
			}
			this->ptr_ = Sh.get();
		}
		return *this;
	}
    
	Expression* get() const{
		return this->ptr_;
	}
    
	void reset(Expression *ptr = 0){
		if(ptr_!=0){
			l->dec();
			if(l->get()==0){
				delete ptr_;
				delete l;
			}
			
		}
		if(ptr!=0){
			l = new Links();
			l->inc();
		}
		this->ptr_=ptr;
	}
	
    Expression& operator*() const{
		return *ptr_;
	}
    Expression* operator->() const{
		return this->ptr_;
	} 
	
	Links* getLink() const{
		return l;
	}
	
private:
	Expression *ptr_ = 0;
	int links;
	Links *l = 0;
};



int main(){
	return 0;
}