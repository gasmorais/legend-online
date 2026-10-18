package demonland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import utils.LogicUtils;
   import yishi.manager.DemonLandManager;
   
   public class DemonLandMapRoad extends Component
   {
      
      private var _map1:Image;
      
      private var _map2:Image;
      
      private var spLevel:Sprite;
      
      private var arrIcon:Array;
      
      private var mcMap:MovieClip;
      
      public function DemonLandMapRoad()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:DemonRoadMapIcon = null;
         var _loc2_:int = 0;
         _map1 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandMapRoad.map1");
         addChild(_map1);
         mcMap = ComponentFactory.Instance.creatCustomObject("asset.DemonLand.resource.main.mcMap");
         addChild(mcMap);
         mcMap.stop();
         spLevel = new Sprite();
         addChild(spLevel);
         arrIcon = [];
         _loc2_ = 1;
         while(_loc2_ <= 30)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DemonLand.DemonLandMapRoad.level" + _loc2_,[_loc2_]);
            spLevel.addChild(_loc1_);
            arrIcon.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function setProgress(param1:int) : void
      {
         var _loc2_:DemonRoadMapIcon = null;
         var _loc3_:int = 0;
         _loc3_ = 1;
         while(_loc3_ <= 30)
         {
            _loc2_ = arrIcon[_loc3_ - 1];
            if(_loc3_ < param1)
            {
               _loc2_.setState(2);
            }
            else if(_loc3_ == param1)
            {
               _loc2_.setState(3);
            }
            else
            {
               _loc2_.setState(1);
            }
            _loc3_++;
         }
         mcMap.gotoAndStop(DemonLandManager.instance.model.maxChapterId);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_map1);
         _map1 = null;
         ObjectUtils.disposeObject(_map2);
         _map2 = null;
         ObjectUtils.disposeViolentMc(mcMap);
         mcMap = null;
         ObjectUtils.disposeObject(spLevel);
         spLevel = null;
         LogicUtils.disposeDisplayCollection(arrIcon);
         arrIcon = null;
         super.dispose();
      }
   }
}

