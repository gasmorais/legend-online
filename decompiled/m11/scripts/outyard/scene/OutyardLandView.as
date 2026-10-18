package outyard.scene
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BlurFilter;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import mvc.module.outyard.LandPoint;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardLandView extends Component
   {
      
      private var _containSprite:Component;
      
      private var _arrowSprite:Component;
      
      private var _mapSprite:Component;
      
      private var _lineSprite:Sprite;
      
      private var _nodeContain:Component;
      
      private var _shapeSprite:Component;
      
      private var _map1:DisplayObject;
      
      private var _map2:DisplayObject;
      
      private var _map3:DisplayObject;
      
      private var _map4:DisplayObject;
      
      private var _map5:DisplayObject;
      
      private var _map6:DisplayObject;
      
      private var _mapShape1:DisplayObject;
      
      private var _mapShape2:DisplayObject;
      
      private var _mapShape3:DisplayObject;
      
      private var _mapShape4:DisplayObject;
      
      private var _mapShape5:DisplayObject;
      
      private var _mapShape6:DisplayObject;
      
      private var _offsetArr:Array = [[-513,-103],[-372,-818],[-1716,-644],[-1510,-11],[-991,-472],[-1162,-1085]];
      
      private var _lineDic:Dictionary;
      
      private var _clickArrow:Bitmap;
      
      private var _clickOverMc:MovieClip;
      
      private var _rollOverMc:MovieClip;
      
      private var _swordView:OutyardSwordView;
      
      public function OutyardLandView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc7_:int = 0;
         var _loc2_:LandPoint = null;
         var _loc5_:int = 0;
         var _loc3_:LandNodeView = null;
         _lineDic = new Dictionary();
         _containSprite = ComponentFactory.Instance.creatCustomObject("outyard.scene.containSprite");
         _arrowSprite = ComponentFactory.Instance.creatCustomObject("outyard.scene.arrowSprite");
         _mapSprite = ComponentFactory.Instance.creatCustomObject("outyard.scene.mapSprite");
         _lineSprite = ComponentFactory.Instance.creatCustomObject("outyard.scene.lineSprite");
         _nodeContain = ComponentFactory.Instance.creatCustomObject("outyard.scene.nodeSprite");
         _shapeSprite = ComponentFactory.Instance.creatCustomObject("outyard.scene.shapeSprite");
         _map1 = ComponentFactory.Instance.creatBitmap("asset.outyard.landBg1");
         _map2 = ComponentFactory.Instance.creatBitmap("asset.outyard.landBg2");
         _map3 = ComponentFactory.Instance.creatBitmap("asset.outyard.landBg3");
         _map4 = ComponentFactory.Instance.creatBitmap("asset.outyard.landBg4");
         _map5 = ComponentFactory.Instance.creatBitmap("asset.outyard.landBg5");
         _map6 = ComponentFactory.Instance.creatBitmap("asset.outyard.landBg6");
         _mapShape1 = ComponentFactory.Instance.creatCustomObject("asset.outyard.mapShape1");
         _mapShape2 = ComponentFactory.Instance.creatCustomObject("asset.outyard.mapShape2");
         _mapShape3 = ComponentFactory.Instance.creatCustomObject("asset.outyard.mapShape3");
         _mapShape4 = ComponentFactory.Instance.creatCustomObject("asset.outyard.mapShape4");
         _mapShape5 = ComponentFactory.Instance.creatCustomObject("asset.outyard.mapShape5");
         _mapShape6 = ComponentFactory.Instance.creatCustomObject("asset.outyard.mapShape6");
         _clickArrow = ComponentFactory.Instance.creatBitmap("asset.outyard.clickArrow");
         _clickOverMc = ComponentFactory.Instance.creatCustomObject("asset.outyard.rollOverMc");
         _rollOverMc = ComponentFactory.Instance.creatCustomObject("asset.outyard.rollOverMc");
         _swordView = ComponentFactory.Instance.creatCustomObject("outyard.scene.OutyardSwordView");
         var _loc1_:Dictionary = OutyardManager.instance.model.nodeDic;
         var _loc8_:Point = new Point();
         var _loc6_:Point = new Point();
         for each(var _loc9_:LandPoint in _loc1_)
         {
            _loc8_.x = _loc9_.posX;
            _loc8_.y = _loc9_.posY;
            _loc5_ = 0;
            while(_loc5_ < _loc9_.lineArr.length)
            {
               _loc2_ = _loc1_[_loc9_.lineArr[_loc5_]];
               if(!(!_loc2_ || (_lineDic[_loc9_.id + "_" + _loc2_.id] || _lineDic[_loc2_.id + "_" + _loc9_.id])))
               {
                  _loc6_.x = _loc2_.posX;
                  _loc6_.y = _loc2_.posY;
                  _loc7_ = 5;
                  _lineSprite.graphics.lineStyle(_loc7_,16777215,0.25);
                  _lineSprite.graphics.moveTo(_loc8_.x,_loc8_.y);
                  _lineSprite.graphics.lineTo(_loc6_.x,_loc6_.y);
                  _lineSprite.graphics.endFill();
                  _loc7_ = 2.5;
                  _lineSprite.graphics.lineStyle(_loc7_,3811588);
                  _lineSprite.graphics.moveTo(_loc8_.x,_loc8_.y);
                  _lineSprite.graphics.lineTo(_loc6_.x,_loc6_.y);
                  _lineSprite.graphics.endFill();
                  _lineDic[_loc9_.id + "_" + _loc2_.id] = true;
                  _lineDic[_loc2_.id + "_" + _loc9_.id] = true;
               }
               _loc5_++;
            }
         }
         for each(var _loc4_:LandPoint in _loc1_)
         {
            _loc3_ = new LandNodeView();
            _loc3_.x = _loc4_.posX;
            _loc3_.y = _loc4_.posY;
            _loc3_.info = _loc4_;
            _nodeContain.addChild(_loc3_);
         }
         addChild(_containSprite);
         _containSprite.addChild(_mapSprite);
         _containSprite.addChild(_lineSprite);
         _containSprite.addChild(_nodeContain);
         _containSprite.addChild(_shapeSprite);
         _mapSprite.addChild(_map1);
         _mapSprite.addChild(_map2);
         _mapSprite.addChild(_map3);
         _mapSprite.addChild(_map4);
         _mapSprite.addChild(_map5);
         _mapSprite.addChild(_map6);
         _shapeSprite.addChild(_mapShape1);
         _shapeSprite.addChild(_mapShape2);
         _shapeSprite.addChild(_mapShape3);
         _shapeSprite.addChild(_mapShape4);
         _shapeSprite.addChild(_mapShape5);
         _shapeSprite.addChild(_mapShape6);
         _mapShape1.visible = false;
         _mapShape2.visible = false;
         _mapShape3.visible = false;
         _mapShape4.visible = false;
         _mapShape5.visible = false;
         _mapShape6.visible = false;
         _lineSprite.cacheAsBitmap = true;
         _containSprite.cacheAsBitmap = true;
         addChild(_arrowSprite);
         _arrowSprite.addChild(_clickArrow);
         _arrowSprite.addChild(_clickOverMc);
         _arrowSprite.addChild(_rollOverMc);
         _arrowSprite.addChild(_swordView);
         _clickArrow.visible = false;
         _clickOverMc.visible = false;
         _rollOverMc.visible = false;
         _arrowSprite.mouseChildren = _arrowSprite.mouseEnabled = false;
      }
      
      public function setMapId(param1:int, param2:Event) : void
      {
         var _loc3_:int = int(_offsetArr[param1 - 1][0]);
         var _loc4_:int = int(_offsetArr[param1 - 1][1]);
         if(param2)
         {
            TweenMax.to(_containSprite,0.6,{
               "x":_loc3_,
               "y":_loc4_
            });
            TweenMax.to(_arrowSprite,0.6,{
               "x":_loc3_,
               "y":_loc4_
            });
         }
         else
         {
            _containSprite.x = _loc3_;
            _containSprite.y = _loc4_;
            _arrowSprite.x = _loc3_;
            _arrowSprite.y = _loc4_;
         }
         _swordView.setMapId(param1);
         var _loc5_:DisplayObject = this["_mapShape" + param1];
         _loc5_.filters = [new BlurFilter(35,35,1)];
         _loc5_.visible = true;
         _loc5_.cacheAsBitmap = true;
         _containSprite.mask = _loc5_;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("CLICK_LAND_NODE",__clickNodeHandler);
         NotificationManager.instance.addEventListener("OVER_LAND_NODE",__overNodeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("CLICK_LAND_NODE",__clickNodeHandler);
         NotificationManager.instance.removeEventListener("OVER_LAND_NODE",__overNodeHandler);
      }
      
      private function __clickNodeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:LandPoint = param1.data as LandPoint;
         if(_loc2_)
         {
            _clickArrow.visible = true;
            _clickArrow.x = _loc2_.posX - 13;
            _clickArrow.y = _loc2_.posY - 75;
            _clickOverMc.gotoAndPlay(1);
            _clickOverMc.visible = true;
            _clickOverMc.x = _loc2_.posX;
            _clickOverMc.y = _loc2_.posY;
         }
         else
         {
            _clickArrow.visible = false;
            _clickOverMc.visible = false;
         }
      }
      
      private function __overNodeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:LandPoint = param1.data as LandPoint;
         if(_loc2_)
         {
            _rollOverMc.gotoAndPlay(1);
            _rollOverMc.visible = true;
            _rollOverMc.x = _loc2_.posX;
            _rollOverMc.y = _loc2_.posY;
         }
         else
         {
            _rollOverMc.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_containSprite);
         _containSprite = null;
         ObjectUtils.disposeObject(_arrowSprite);
         _arrowSprite = null;
         ObjectUtils.disposeObject(_mapSprite);
         _mapSprite = null;
         ObjectUtils.disposeObject(_lineSprite);
         _lineSprite = null;
         ObjectUtils.disposeObject(_nodeContain);
         _nodeContain = null;
         ObjectUtils.disposeObject(_shapeSprite);
         _shapeSprite = null;
         ObjectUtils.disposeObject(_map1);
         _map1 = null;
         ObjectUtils.disposeObject(_map2);
         _map2 = null;
         ObjectUtils.disposeObject(_map3);
         _map3 = null;
         ObjectUtils.disposeObject(_map4);
         _map4 = null;
         ObjectUtils.disposeObject(_map5);
         _map5 = null;
         ObjectUtils.disposeObject(_map6);
         _map6 = null;
         ObjectUtils.disposeObject(_mapShape1);
         _mapShape1 = null;
         ObjectUtils.disposeObject(_mapShape2);
         _mapShape2 = null;
         ObjectUtils.disposeObject(_mapShape3);
         _mapShape3 = null;
         ObjectUtils.disposeObject(_mapShape4);
         _mapShape4 = null;
         ObjectUtils.disposeObject(_mapShape5);
         _mapShape5 = null;
         ObjectUtils.disposeObject(_mapShape6);
         _mapShape6 = null;
         ObjectUtils.disposeObject(_clickArrow);
         _clickArrow = null;
         ObjectUtils.disposeViolentMc(_clickOverMc);
         _clickOverMc = null;
         ObjectUtils.disposeViolentMc(_rollOverMc);
         _rollOverMc = null;
         ObjectUtils.disposeObject(_swordView);
         _swordView = null;
         _offsetArr = null;
         _lineDic = null;
         super.dispose();
      }
   }
}

