package map.internals.view.layer
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import flash.events.MouseEvent;
   import map.internals.data.FloorMapInfo;
   import map.internals.data.MapInfo;
   import map.internals.event.OuterCityEvent;
   import map.internals.filter.MapPhysicsFilter;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.interfaces.ISelectMovie;
   import map.internals.view.physics.MapPhysicsBase;
   import yishi.manager.PlayerManager;
   
   public class SimpleMapLayer extends MapBaseLayer
   {
      
      protected var _model:FloorMapInfo;
      
      private var _fileter:MapPhysicsFilter = new MapPhysicsFilter();
      
      private var _is:Boolean;
      
      private var _canAttack:Array = [];
      
      private var _noAttack:Array = [];
      
      public function SimpleMapLayer()
      {
         this.scrollRect = null;
         super();
      }
      
      public function set mapData(param1:MapInfo) : void
      {
         _model = param1 as FloorMapInfo;
         _model.addEventListener("commitLoading",__commitLoadHandler);
      }
      
      protected function __commitLoadHandler(param1:OuterCityEvent) : void
      {
         removeOtherItems();
      }
      
      override protected function get nineSliceScaling() : Array
      {
         return _model.nineSliceScaling;
      }
      
      override protected function deleteRectCall(param1:String) : void
      {
         _model.reUserFile(param1);
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            return _loc2_.mouseClickHandler(param1);
         }
         return false;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            return _loc2_.mouseOverHandler(param1);
         }
         return false;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            return _loc2_.mouseOutHandler(param1);
         }
         return false;
      }
      
      public function setAllPhysicsFilter() : void
      {
         if(_is)
         {
            return;
         }
         _is = true;
         var _loc2_:TimelineMax = new TimelineMax({
            "repeat":-1,
            "yoyo":true,
            "repeatDelay":0.5
         });
         var _loc1_:TimelineMax = new TimelineMax({
            "repeat":-1,
            "yoyo":true,
            "repeatDelay":0.5
         });
         var _loc8_:TimelineMax = new TimelineMax({
            "repeat":-1,
            "yoyo":true,
            "repeatDelay":0.5
         });
         var _loc5_:TimelineMax = new TimelineMax({
            "repeat":-1,
            "yoyo":true,
            "repeatDelay":0.5
         });
         var _loc6_:Array = [];
         var _loc3_:Array = [];
         var _loc9_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         for each(var _loc4_:Array in _dict)
         {
            for each(var _loc7_:ISelectMovie in _loc4_)
            {
               _loc7_.beginSelectMovie();
               if(_loc7_["isPlaying"])
               {
                  if(_loc7_ is MapPhysicsBase)
                  {
                     if((_loc7_ as MapPhysicsBase).info.info.occupyPlayerId == _loc9_)
                     {
                        _loc3_.push(_loc7_.selectMovie);
                        _noAttack.push(_loc7_);
                        continue;
                     }
                  }
                  _loc6_.push(_loc7_.selectMovie);
                  _canAttack.push(_loc7_);
               }
            }
         }
         _loc2_.insertMultiple(TweenMax.allFrom(_loc6_,0.5,{
            "colorTransform":{
               "tint":16711680,
               "tintAmount":0.4
            },
            "glowFilter":{
               "color":16711680,
               "alpha":0.9,
               "blurX":17,
               "blurY":17
            }
         }));
         _loc1_.insertMultiple(TweenMax.allFrom(_loc6_,0.5,{
            "colorTransform":{
               "tint":16711680,
               "tintAmount":0.18
            },
            "glowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":0,
               "blurY":0,
               "delay":0.5
            }
         }));
         _loc8_.insertMultiple(TweenMax.allFrom(_loc3_,0.5,{
            "colorTransform":{
               "tint":16776960,
               "tintAmount":0.4
            },
            "glowFilter":{
               "color":16711680,
               "alpha":0.9,
               "blurX":17,
               "blurY":17
            }
         }));
         _loc5_.insertMultiple(TweenMax.allFrom(_loc3_,0.5,{
            "colorTransform":{
               "tint":16776960,
               "tintAmount":0.15
            },
            "glowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":0,
               "blurY":0,
               "delay":0.5
            }
         }));
      }
      
      public function clearAllPhysicsFilter() : void
      {
         var _loc1_:ISelectMovie = null;
         _is = false;
         TweenMax.killChildTweensOf(this,false);
         while(_canAttack.length > 0)
         {
            _loc1_ = _canAttack.pop();
            _loc1_.resetSelectMovie();
         }
         while(_noAttack.length > 0)
         {
            _loc1_ = _noAttack.pop();
            _loc1_.resetSelectMovie();
         }
      }
      
      override protected function removeOtherItems() : void
      {
         throw new Error("override removeOtherItems()");
      }
      
      override public function dispose() : void
      {
         if(_model)
         {
            _model.removeEventListener("commitLoading",__commitLoadHandler);
         }
         removeAllChild();
         _dict = null;
         _model = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

