require([
      "esri/config",
      "esri/Map",
      "esri/WebMap",
      "esri/views/MapView",
      "esri/portal/Portal",
      "esri/layers/FeatureLayer",
      "esri/layers/CSVLayer",
      "esri/renderers/SimpleRenderer",
      "esri/symbols/SimpleMarkerSymbol",
      "esri/core/urlUtils",

      "esri/widgets/BasemapGallery",
      "esri/widgets/BasemapToggle",
      "esri/widgets/Locate",
      "esri/widgets/Search",
      "esri/widgets/CoordinateConversion",
      "esri/widgets/LayerList",
      "esri/widgets/Legend",
      "esri/widgets/Expand",
      "dojo/domReady!"
    ],
    function (
          esriConfig,
          Map,
          WebMap,
          MapView,
          Portal,
          FeatureLayer,
          CSVLayer,
          SimpleRenderer,
          SimpleMarkerSymbol,
          urlUtils,
          BasemapGallery,
          BasemapToggle,
          Locate,
          Search,
          CoordinateConversion,
          LayerList,
          Legend,
          Expand){

          const map = new WebMap({
            basemap: {
              portalItem: {
                id: "bee4f67960a040c79aad67e1810b70d4"
              }
            },
            //layers: [csvLayer]
          });
          const url ="/static/surveyData.csv";
          const csvLayer = new CSVLayer({
          title: "Survey Data",
            url: url,
            copyright: "mjzaid921pccoer"
          });
          map.layers.add(csvLayer);//

          const view = new MapView({
            container: "viewDiv",
            map: map
          });
    }
  );