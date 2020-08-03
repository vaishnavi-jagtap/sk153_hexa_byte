require([
    "esri/config",
    "esri/Map",
    "esri/WebMap",
    "esri/views/MapView",
    "esri/portal/Portal",
    "esri/layers/Layer",
    "esri/layers/FeatureLayer",
    "esri/widgets/FeatureTable",
    "esri/layers/CSVLayer",
    "esri/renderers/SimpleRenderer",
    "esri/symbols/SimpleMarkerSymbol",
    "esri/Graphic",
    "esri/geometry/Point",
    "esri/core/urlUtils",

    "esri/widgets/BasemapGallery",
    "esri/widgets/BasemapToggle",
    "esri/widgets/Locate",
    "esri/widgets/Search",
    "esri/widgets/CoordinateConversion",
    "esri/widgets/LayerList",
    "esri/widgets/Legend",
    "esri/widgets/Expand",
    "esri/widgets/Measurement",
    "esri/widgets/DistanceMeasurement2D",
    "esri/widgets/AreaMeasurement2D",

    "esri/core/watchUtils",
    "dojo/query",
    "dojo/domReady!"
  ],
  function (
        esriConfig,
        Map,
        WebMap,
        MapView,
        Portal,
        Layer,
        FeatureLayer,
        FeatureTable,
        CSVLayer,
        SimpleRenderer,
        SimpleMarkerSymbol,
        Graphic,
        Point,
        urlUtils,
        BasemapGallery,
        BasemapToggle,
        Locate,
        Search,
        CoordinateConversion,
        LayerList,
        Legend,
        Expand,
        Measurement,
        DistanceMeasurement2D,
        AreaMeasurement2D,
        watchUtils,
        dojoQuery){
          
        esriConfig.portalUrl = "https://mjzaid921pccoer.maps.arcgis.com";
//PART01:
    let RiverTracingWebMapId = "bee4f67960a040c79aad67e1810b70d4";
    if (window.location.href.indexOf("?id=") > 0) {
      RiverTracingWebMapId = window.location.href.split("?id=")[0];
    }
    let WebMap_WaterBodies_TopographicId = "23bc5f282ec848adb1ee2610d2408e51";
    if (window.location.href.indexOf("?id=") > 0) {
      WebMap_WaterBodies_TopographicId = window.location.href.split("?id=")[0];
    }
    let BASEWebMap_WaterBodies_TopographicId = "8912c1ef2dd6408090d9be41c8869558";
    if (window.location.href.indexOf("?id=") > 0) {
      BASEWebMap_WaterBodies_TopographicId = window.location.href.split("?id=")[0];
    }

    var map = new WebMap({
      portalItem: {
        id: BASEWebMap_WaterBodies_TopographicId
      }
      //basemap:"topo"
    });




            var view = new MapView({
              map: map,
              container: "viewDiv",
              //center: [78.9629 , 20.5937],
              //zoom: 4
            });

            console.log(view);

//PART02:
            view.ui.add("logoDiv", "bottom-left");
//PART03:
            var searchWidget = new Search({
              view: view
            });
            view.ui.add(searchWidget, {
              position: "top-right"
            });
//PART04:
            var locateBtn = new Locate({
              view: view
            });
            view.ui.add(locateBtn, {
              position: "top-left"
            });
//PART05:
            view.ui.add(
              [
                new Expand({
                  content: new Legend({
                    view: view
                  }),
                  view: view,
                  group: "top-left"
                }),
                new Expand({
                  content: new LayerList({
                    view: view
                  }),
                  view: view,
                  group: "top-left"
                }),
                new Expand({
                  content: new BasemapGallery({
                    view: view
                  }),
                  view: view,
                  expandIconClass: "esri-icon-basemap",
                  group: "top-left"
                }),
                new Expand({
                  content: new BasemapToggle({
                      view: view,
                      nextBasemap: "hybrid"
                  }),
                  view: view,
                  expandIconClass: "esri-icon-media",
                  group: "top-left"
                }),
                new Expand({
                  content:new CoordinateConversion({
                    view: view
                  }),
                  view: view,
                  expandIconClass: "esri-icon-experimental",
                  group: "top-left"
                })
              ],
              "top-left"
            );
//PART06:
            var activeWidget = null;
            view.ui.add("topbar", "top-right");

            document
            .getElementById("distanceButton")
            .addEventListener("click", function () {
              setActiveWidget(null);
              if (!this.classList.contains("active")) {
                setActiveWidget("distance");
              }else{
              setActiveButton(null);
              }
            });

            document
            .getElementById("areaButton")
            .addEventListener("click", function () {
              setActiveWidget(null);
              if (!this.classList.contains("active")) {
                setActiveWidget("area");
              } else {
                setActiveButton(null);
            }
            });

            function setActiveWidget(type) {
              switch (type) {
                case "distance":
                  activeWidget = new DistanceMeasurement2D({
                    view: view
                  });
                  // skip the initial 'new measurement' button
                  activeWidget.viewModel.newMeasurement();
                  view.ui.add(activeWidget, "top-right");
                  setActiveButton(document.getElementById("distanceButton"));
                break;

                case "area":
                  activeWidget = new AreaMeasurement2D({
                    view: view
                  });
                  // skip the initial 'new measurement' button
                  activeWidget.viewModel.newMeasurement();
                  view.ui.add(activeWidget, "top-right");
                  setActiveButton(document.getElementById("areaButton"));
                break;

                case null:
                  if (activeWidget) {
                    view.ui.remove(activeWidget);
                    activeWidget.destroy();
                    activeWidget = null;
                  }
                break;
              }
            }

            function setActiveButton(selectedButton) {
              // focus the view to activate keyboard shortcuts for sketching
              view.focus();
              var elements = document.getElementsByClassName("active");
              for (var i = 0; i < elements.length; i++) {
                elements[i].classList.remove("active");
              }
              if (selectedButton) {
                selectedButton.classList.add("active");
              }
            }

//PART07:
            var layer = new FeatureLayer({
                //url: "https://services.arcgis.com/fzIHTcK9TqzWXLVL/arcgis/rest/services/layer_pointsriverfront/FeatureServer/0"
                url:"https://services.arcgis.com/fzIHTcK9TqzWXLVL/arcgis/rest/services/sabarmatizone/FeatureServer/0"
            });
            layer.watch("loaded", function(){
              watchUtils.whenFalseOnce(view, "updating", function(){
                 var attribs = dojoQuery(".esri-attribution__sources")[0];
                 console.info(attribs);
                 attribs.innerHTML = "TEAM HEXA_BYTE";
              });
            });
            //map.layers.add(layer,1);
            map.layers.push(layer);
//PART08:
          const url ="/static/surveyData.csv";

          const csvLayer = new CSVLayer({
          title: "Survey Data",
            url: url,
            copyright: "mjzaid921pccoer"
          });


          csvLayer.renderer = {
            type: "simple",  // autocasts as new SimpleRenderer()
            symbol: {
              type: "simple-marker",  // autocasts as new SimpleMarkerSymbol()
              size: 6,
              color: "orange",
              outline: {  // autocasts as new SimpleLineSymbol()
                width: 0.5,
                color: "white"
              }
            }
          };
          map.layers.push(csvLayer);//




        }
  );
