angular.module('streamingVideoV1Item', [
	//'tsunamijs.livethumbnail', //Live Thumbnails
	'edit-map',                //maps
	'disp-map'                 //maps
])

.controller('TileStreamingVideoV1ItemCtrl', function($scope) {
	$scope.video = {};

	$scope.livethumbConfig = {
		showtitle: false,
		autoplay: $scope.item.Live,
		selectable: false,
		skimmable: true,
		clickable: false,
		interval: 2,
		debuglive: false,
		width: 140,
		video: $scope.video
	};

	$scope.$watch('item', function() {
		if(!$scope.item) return;

		$scope.video.title = "";
		$scope.video.thumbnailUrl = $scope.item.ThumbnailURI;
		$scope.video.StartTime = $scope.item.StartTime;
		$scope.video.StopTime = $scope.item.StopTime;

		$scope.livethumbConfig.autoplay = $scope.item.Live;
	}, true);

	$scope.$on("clicked", function(e, video) {

	});
})

.directive('tileStreamingVideoV1Item', function() {
	return {
		restrict: 'E',
		scope: {
			item: "="
		},
		templateUrl: '/template/items/streamingVideoV1/tile-streamingVideoV1-item.html',
		controller: 'TileStreamingVideoV1ItemCtrl',
		link: function(scope, element, attr) {

		}
	};
})

.controller('CloseupStreamingVideoV1ItemCtrl', function($scope, $timeout, ItemCache, CloseupItemDialog) {
	$scope.$on("playing", function(e, video) {
		console.log("playing video " + $scope.item.ID);
	});

	$scope.$on("paused", function(e, video) {
		console.log("paused video " + $scope.item.ID);
	});

	$scope.$on("live", function(e, video) {
		console.log("live video " + $scope.item.ID);
	});

	$scope.toggleLive = function() {
		console.log($scope.item);
		$scope.item.Liveseek = false;
		$timeout(function() {
			$scope.item.Liveseek = true;
		}, 100);
	};
})

.directive('closeupStreamingVideoV1Item', function() {
	return {
		restrict: 'E',
		scope: {
			item: "=",
			dialog: "="
		},
		templateUrl: '/template/items/streamingVideoV1/closeup-streamingVideoV1-item.html',
		controller: 'CloseupStreamingVideoV1ItemCtrl',
		link: function(scope, element, attr) {

		}
	};
})

.directive('ngPoster', function() {
	return {
		priority: 99, // it needs to run after the attributes are interpolated
		link: function(scope, element, attr) {
			attr.$observe('ngPoster', function(value) {
				if (!value)
					return;

				attr.$set('poster', value);
			});
		}
	};
})

.directive('autoplayIf', function() {
	return {
		priority: 99, // it needs to run after the attributes are interpolated
		link: function(scope, element, attr) {
			attr.$observe('autoplayIf', function(value) {
				if (!value)
					return;

				attr.$set('autoplay', '');
			});
		}
	};
});
