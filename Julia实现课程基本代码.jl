#演示练习Julia
#标量 
x=6.6+3.6im                         
y=8.2+5.6im
z=x+y
c=x^2
sqrt(z)                              #求均跟方
#换个形式写
x=6.6+3.6im ;y=8.2+5.6im ;z=x+y
#如果只关注最后一个计算式
z=begin x=6.6+3.6im; y=8.2+5.6im; x+y #按顺序计算多个式子的表达式，然后返回最后一个子表达式的值作为其值
end

#向量 rand() randn()
# 数字个数代表指标个数，数字大小代表维数
v=randn(4,)                          #随机生成一个正态分布的四维向量 
size(v)                              #数组的维数
length(v)                            #元素个数
typeof(v)                            #抽象类型
ndims(v)                             #数组阶数
v[2]=2                               #替换第二个元素为2                                                  
print(v)                             #查看是否被替换

#矩阵 
A=randn(4,4)+randn(4,4)*im           #生成随机复矩阵
size(A)                             
length(A)
typeof(A)
A[4,4]=5.62+3.68im
print(A)
conj(A)                              #生成共轭矩阵
A'                                   #转置共轭矩阵

using LinearAlgebra                  #使用线性代数模块
I(3)                                 #生成3*3的单位阵
tr(A)                                #矩阵求迹
inv(A)                               #矩阵求逆                   
det(A)                               #求矩阵行列式
eigvals(A)                           #求特值向量
ones(4,4)                            #生成全1的矩阵
zeros(4,3)                           #生成全0的矩阵

#张量 其实就是三个指标
A=rand(5,3,2)                        #随机生成一个正态分布的3阶张量
B=rand(5,3,2,2)                      #随机生成一个均匀分布的四阶张量
ndims(A)                             #查看A张量的阶数
ndims(B)
print(A[2,3,1])                      #查看张量的某个元素
ones(3,2,2,3)
zeros(3,2,2,3)
                     
#reshape
q=Vector(1:20)                       #生成一个从1到20的Array
w=reshape(q,(4,5))                   #改变列向量的标记方式
e=reshape(1:15,5,3)
q[1]=1                               
w[1,1]=1
transpose(w)                         #不同于w'  代表 求矩阵的转置

x=rand(3,)
y=rand(3,)     
dot(x,y)                             #做内积 点乘
cross(x,y)                           #做外积 叉乘
kron(x,y)                            #克罗内克积
a=[1 ,0]                             #用张量验算一下CNOT门
b=copy(a)                            #控制比特为0，目标比特为0
c=kron(a,b)                          #输出结果 00
d=[1 0 0 0 ; 0 1 0 0 ; 0 0 0 1 ; 0 0 1 0]
d*c

a=[0,1]                              #输入为11 输出为10
b=copy(a)
c=kron(a,b)
d=[1 0 0 0 ; 0 1 0 0 ; 0 0 0 1 ; 0 0 1 0]
d*c
f=[1,0]                              #验证一下输出结果是否为10的直积
kron(a,f)           
#张量收缩
using Einsum                         # Aijk=Xir Yjr Zkr
A = zeros(5,6,7)                     # need to preallocate destination
X = randn(5,2,2)
Y = randn(6,2,2)
Z = randn(7,2,2)
T=@einsum A[i,j,k] = X[i,a,b]*Y[j,b,c]*Z[k,c,a]          # @einsum A[i,j,k] := X[i,r]*Y[j,r]*Z[k,r]
size(T)
length(T)

#本征值分解
using LinearAlgebra                    #调用线性代数模块
A=rand(4,4)  
A=A+transpose(A)                       #对称化矩阵，进行本征分解        
B=eigvals(A)                           #求本征值
C=eigvecs(A)                           #求本征向量
D=C*transpose(C)                       #验证正交性
F=diag(A,0)                            #从矩阵中取走元素，组成向量

M1=copy(B)                             #复制B                         
M2=zeros(4,4)                          #生成4*4，元素皆为0的矩阵
M2[1,1]=M1[1];M2[2,2]=M1[2];M2[3,3]=M1[3];M2[4,4]=M1[4]   #用本征值组成对角矩阵
A1=C*M2*C'
error=norm(A-A1)                       #验证欧几里得范数误差，向量模误差
a=findmax(B,dims=1)                    #寻找最大本征值
b=C[1:4,4]                             #打出最大本征向量
fmax=transpose(b)*A*b                  #计算f
R=rand(4)
G=normalize(R,1)                       #将R向量归一化
 
using Plots                            #调用作图包
x= 1:10           
y= rand(10)
plot(x,y)                              #作图 x作为横坐标，y作为纵坐标
y=rand(10,2)                           #生成两个列向量，出现两条线
plot(x,y)        
z=rand(10)                             #增加第三条线
plot!(x,z)                             #！表示补充到原图上

plot(x,y,title="My plot",label=["Line1" "Line2"],lw=3)
                                       #改变标题 改变label 改变线的宽度
xlabel!("x")                           #横轴
ylabel!("y axis")                      #纵轴

p=plot(x,y,title="My plot",label=["Line1" "Line2"],lw=3,xlabel="x",ylabel="y axis")
savefig(p,"My plot.png")               #保存到repl目录下
pwd()                                  #查看工作目录

scatter(x,y)                            #做散点图
plot!(x,y)                             #散点图基础上，加上折线图