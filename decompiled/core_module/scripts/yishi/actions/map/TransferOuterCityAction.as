package yishi.actions.map
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import map.internals.data.MapInfo;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.preload.PreLoadOuterCityData;
   import mvc.module.armyII.BaseArmy;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.view.community.LoadingSceneView;
   import yishi.view.tools.SimpleMovie;
   
   public class TransferOuterCityAction extends MapBaseAction
   {
      
      private var _count:int;
      
      private var _movie:MovieClip;
      
      private var _simMovie:SimpleMovie;
      
      private var _data:Object;
      
      private var _selfCastle:Sprite;
      
      private var _playMovieOver:Boolean = false;
      
      private var _playEffectTimeId:int;
      
      private var _preLoadOver:Boolean;
      
      private var _shape:Shape;
      
      public function TransferOuterCityAction()
      {
         super();
      }
      
      override public function prepare() : void
      {
         super.prepare();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function update() : void
      {
         var _loc1_:MapInfo = null;
         if(_count == 1)
         {
            _movie = ComponentFactory.Instance.creatCustomObject("asset.core.CollectionAsset");
            if(_movie)
            {
               _movie.stateMc.gotoAndStop(2);
               _simMovie = new SimpleMovie(_movie,movieOver);
               LayerManager.Instance.addToLayer(_simMovie,3,true);
            }
            else
            {
               movieOver();
            }
            _loc1_ = new MapInfo();
            _loc1_.mapId = PlayerManager.instance.currentPlayerModel.mapNodeInfo.info.mapId;
            new PreLoadOuterCityData(_loc1_).syncBackCall(preLoadOver);
            selfCastleVisible(false,true);
         }
         if(_preLoadOver && _playMovieOver)
         {
            selfCastleVisible(false);
         }
         else if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            selfCastleVisible(false,true);
         }
         _count = _count + 1;
      }
      
      private function movieOver() : void
      {
         _playMovieOver = true;
         _movie = null;
         _simMovie = null;
         if(_preLoadOver)
         {
            gotoOuterCity();
         }
         else
         {
            LoadingSceneView.instance.show();
         }
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         if(param1.data != "OUTER_CITY_SCENE")
         {
            return;
         }
         SceneManager.instance.lockScene = true;
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("SWITCH_MAP_TRANSFER",null));
         if(_playEffectTimeId > 0)
         {
            clearInterval(_playEffectTimeId);
         }
         _playEffectTimeId = 0;
         _playEffectTimeId = setInterval(playTransferEffect,1000);
      }
      
      private function selfCastleVisible(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc5_:BaseArmy = null;
         var _loc3_:int = PlayerManager.instance.currentPlayerModel.mapNodeInfo.x;
         var _loc4_:int = PlayerManager.instance.currentPlayerModel.mapNodeInfo.y;
         if(!OuterCityManager.instance.model)
         {
            return;
         }
         _selfCastle = OuterCityManager.instance.model.getPhysicsByXY(_loc3_,_loc4_);
         if(_selfCastle)
         {
            _selfCastle.visible = param1;
         }
         if(!param2)
         {
            if(!OuterCityManager.instance.mapView)
            {
               return;
            }
            if(!OuterCityManager.instance.mapView.worldWalkLayer)
            {
               return;
            }
            _loc5_ = OuterCityManager.instance.model.getWorldArmyById(ArmyManager.instance.army.id);
            if(!_loc5_)
            {
               return;
            }
            if(_loc5_.armyView)
            {
               _loc5_.armyView.visible = param1;
            }
         }
      }
      
      private function preLoadOver() : void
      {
         _preLoadOver = true;
         if(_playMovieOver)
         {
            gotoOuterCity();
         }
      }
      
      private function gotoOuterCity() : void
      {
         var _loc1_:Object = {
            "isShowLoading":false,
            "showMapName":false
         };
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         SceneManager.instance.setScene("OUTER_CITY_SCENE",_loc1_,true);
      }
      
      private function playTransferEffect() : void
      {
         if(_playEffectTimeId > 0)
         {
            clearInterval(_playEffectTimeId);
         }
         _playEffectTimeId = 0;
         PlayerManager.instance.currentPlayerModel.mapNodeInfo.info;
         _movie = ComponentFactory.Instance.creatCustomObject("asset.outercity.TransferOuterCityEffectAsset");
         _simMovie = new SimpleMovie(_movie,dispose);
         var _loc1_:Sprite = OuterCityManager.instance.mapView as Sprite;
         _simMovie.x = PlayerManager.instance.currentPlayerModel.mapNodeInfo.x;
         _simMovie.y = PlayerManager.instance.currentPlayerModel.mapNodeInfo.y;
         _shape = new Shape();
         _shape.graphics.beginFill(0,0.68);
         _shape.graphics.drawRect(-1500,-900,3000,1800);
         _shape.graphics.drawRect(-750,-450,1500,900);
         _shape.graphics.endFill();
         _loc1_.addChild(_shape);
         _shape.x = _simMovie.x;
         _shape.y = _simMovie.y;
         _loc1_.addChild(_simMovie);
      }
      
      override public function dispose() : void
      {
         selfCastleVisible(true);
         super.dispose();
         if(_simMovie)
         {
            if(_simMovie.parent)
            {
               _simMovie.parent.removeChild(_simMovie);
            }
            _simMovie = null;
         }
         if(_shape)
         {
            _shape.graphics.clear();
            if(_shape.parent)
            {
               _shape.parent.removeChild(_shape);
            }
         }
         _shape = null;
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

