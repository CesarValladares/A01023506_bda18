//1

var map1 = function(){
	emit(this.address.zipcode, 1);
};

var reduce1 = function(name, values){
	var n = Array.sum(values);
	return n; 
};

db.restaurants.mapReduce(map1,reduce1,{out:"res1"})

//2

var map2 = function(){
	this.grades.forEach((value)=>{emit(this.name, 1)});
};

var reduce2 = function(name, values){
	return Array.sum(values);
};

db.restaurants.mapReduce(map2,reduce2, {out:"res2"})

//3
var map3 = function(){
	this.grades.forEach((value)=>{emit(this.name, value.score)});
};

var reduce3 = function(name, values){
	return Array.sum(values);
};

db.restaurants.mapReduce(map3,reduce3, {out:"res3"})

//4

var map4 = function(){
	this.grades.forEach((value)=>{emit(value.grade, 1)});
};

var reduce4 = function(name, values){
	return Array.sum(values);
};

db.restaurants.mapReduce(map4,reduce4, {out:"res4"})

//5
db.restaurants.aggregate([{$group:{_id:"$cuisine", hay:{$sum:1}}}])
