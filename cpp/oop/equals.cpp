struct Expression
{
// put your code here
	
	virtual double evaluate() const = 0;
	virtual ~Expression(){}
};

bool check_equals(Expression const *left, Expression const *right)
{
    // put your code here
	if(left == right) return true;
	return false;
}
int main{
return 0;
}