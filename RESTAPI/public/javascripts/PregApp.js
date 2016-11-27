var app = angular.module('pregApp', ['ngRoute']).run(function($rootScope, $http){

    $rootScope.authenticated = false;
    $rootScope.current_user = "";
    $rootScope.current_id = "";

    $rootScope.signout = function(){
        $http.get("/auth/signout");

        $rootScope.authenticated = false;
        $rootScope.current_user = "";
    };
});

app.config(function($routeProvider){
    $routeProvider
        .when('/', {
            templateUrl: 'main.html',
            controller: 'mainController'
        })
        .when('/adduser', {
            templateUrl: 'addUser.html',
            controller: 'addUserController'
        })
        .when('/medicalRecords', {
            templateUrl: 'medicalRecords.html',
            controller: 'medicalRecordsController'
        })
        .when('/register', {
            templateUrl: 'register.html',
            controller: 'authController'
        })
        .when('/login', {
            templateUrl: 'login.html',
            controller: 'authController'
        });
});

app.controller('mainController', function($http, $location, $rootScope, $scope){
    $scope.init = function(){
        if(!$rootScope.authenticated){
            $location.path('/login');
        }
    };
    $scope.init();

    if($rootScope.authenticated){
        $http.get('/api/users/'+$rootScope.current_id).success(function(data){
            $scope.user = data;
            $scope.routines = [];
            for(var i = 0; i < $scope.user.routines.length; i++){
                $http.get("/api/routines/"+$scope.user.routines[i]).success(function(data){
                    $scope.routines.push(data);
                });
            }
            $scope.workouts = [];
            for(var i = 0; i < $scope.user.workouts.length; i++){
                $http.get("/api/workouts/"+$scope.user.workouts[i]).success(function(data){
                    $scope.workouts.push(data);
                });
            }
        });
    }

    $scope.displayRoutine = function(index){
        $rootScope.selectedRoutine = $scope.user.routines[index];
        $location.path('/displayroutine');
    };

    $scope.displayWorkout = function(index){
        $rootScope.selectedRoutine = $scope.user.routines[index];
        $rootScope.selectedWorkout = $scope.user.workouts[index];
        $location.path('/displayworkout');
    };
});

app.controller('displayUserController', function($scope, $rootScope, $http){
    $http.get("/api/routines/"+$rootScope.selectedRoutine).success(function(data){
        $scope.routine = data;
    });
    $scope.download = function(){
        console.log($scope.routine);
    }
});

app.controller('displayMedicalController', function($scope, $rootScope, $http){
    $http.get("/api/workouts/"+$rootScope.selectedWorkout).success(function(data){
        $scope.workout = data;
    });
    $http.get("/api/routines/"+$rootScope.selectedRoutine).success(function(data){
        $scope.routine = data;
    });
    $scope.download = function(){
        console.log($scope.workout);
    }
});

app.controller('addUserController', function($scope, $rootScope, $location, $http){
    $scope.title = "";
    $scope.number = 0;
    $scope.exercises = [];
    $scope.change = function(){
        $scope.exercises = [];
        for(var i = 0; i  < $scope.number; i++){
            $scope.exercises.push({value:""});
        }
    };

    $scope.submit = function(){
        var routine = {};
        routine.title = $scope.title;
        routine.creator = $rootScope.current_user;
        routine.exercises = [];
        for(var i = 0; i < $scope.exercises.length; i++){
            routine.exercises.push($scope.exercises[i].value);
        }
        $http.post("/api/users/" + $rootScope.current_id + "/routines", routine);
        $location.path('/');
    }
});

app.controller('chooseController', function($scope, $http, $rootScope, $location){
    $http.get('/api/users/'+$rootScope.current_id+"/routines").success(function(data){
        var routineId = data;
        $scope.routines = [];
        for(var i = 0; i < routineId.length; i++){
            $http.get("/api/routines/"+routineId[i]).success(function(data){
                $scope.routines.push(data);
            });
        }
    });
    $scope.chosen = "";
    $scope.submit = function(){
        console.log($scope.routines);
        for(var j = 0; j < $scope.routines.length; j++){
            if($scope.routines[j].title == $scope.chosen){
                $rootScope.chosenRoutine = $scope.routines[j]._id;
            }
        }
        $location.path("/workout");
    };
});

app.controller('medicalRecordsController', function($location, $scope, $http, $rootScope){
    $scope.routine = {};
    $http.get("/api/routines/"+$rootScope.chosenRoutine).success(function(data){
        $scope.routine = data;
    });
    $scope.submit = function(){
        var workout = {};
        workout.creator = $rootScope.current_user;
        workout.routine = $scope.routine.title;
        workout.sets = [];
        workout.reps = [];
        workout.weights = [];
        workout.sets.push(3);
        workout.sets.push(3);
        for(var i = 0; i < 6; i++){
            workout.reps.push(10);
            workout.weights.push(50);
        }
        $http.post("/api/users/" + $rootScope.current_id + "/workouts", workout);
        $location.path('/');
    }
});

app.controller('authController', function($scope, $rootScope, $http, $location){
    $scope.user = {name: '', username: '', password: ''};
    $scope.error_message = '';

    //if already logged in then redirect
    $scope.init = function(){
        if($rootScope.authenticated){
            $location.path('/');
        }
    };
    $scope.init();

    $scope.login = function(){
        $http.post('/auth/login', $scope.user)
            .success(function(data){
                if(data.state == 'success'){
                    $rootScope.authenticated = true;
                    $rootScope.current_user = data.user.name;
                    $rootScope.current_id = data.user._id;
                    $location.path('/');
                }
                else if(data.state == 'failure'){
                    $scope.error_message = data.message;
                }
            });
    };
    $scope.register = function(){
        $http.post('/auth/register', $scope.user)
            .success(function(data){
                if(data.state == 'success'){
                    $rootScope.authenticated = true;
                    $rootScope.current_user = data.user.name;
                    $rootScope.current_id = data.user._id;
                    $location.path('/');
                }
                else if(data.state == 'failure'){
                    $scope.error_message = data.message;
                }
            });
    };
});