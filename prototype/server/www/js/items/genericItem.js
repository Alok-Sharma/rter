angular.module('genericItem', [
	'edit-map', //maps
	'disp-map'  //maps
])

.controller('FormGenericItemCtrl', function($scope) {
	$scope.item.StartTime = new Date();
	$scope.item.StopTime = $scope.item.StartTime;

	$scope.item.HasHeading = false;
	$scope.item.HasGeo = false;
	$scope.item.Live = false;
})

.directive('formGenericItem', function() {
	return {
		restrict: 'E',
		scope: {
			item: "=",
			form: "="
		},
		templateUrl: '/template/items/generic/form-generic-item.html',
		controller: 'FormGenericItemCtrl',
		link: function(scope, element, attr) {

		}
	};
})

.controller('TileGenericItemCtrl', function($scope) {

})

.directive('tileGenericItem', function() {
	return {
		restrict: 'E',
		scope: {
			item: "="
		},
		templateUrl: '/template/items/generic/tile-generic-item.html',
		controller: 'TileGenericItemCtrl',
		link: function(scope, element, attr) {

		}
	};
})

.controller('CloseupGenericItemCtrl', function($scope) {

})

.directive('closeupGenericItem', function() {
	return {
		restrict: 'E',
		scope: {
			item: "=",
			dialog: "="
		},
		templateUrl: '/template/items/generic/closeup-generic-item.html',
		controller: 'CloseupGenericItemCtrl',
		link: function(scope, element, attr) {
			
		}
	};
})

.controller('PanoramaGenericItemCtrl', function($scope) {

})

.directive('panoramaGenericItem', function() {
	return {
		restrict: 'E',
		scope: {
			item: "=",
			dialog: "="
		},
		templateUrl: '/template/items/generic/panorama-generic-item.html',
		controller: 'PanoramaGenericItemCtrl',
		link: function(scope, element, attr) {
			
		}
	};
});