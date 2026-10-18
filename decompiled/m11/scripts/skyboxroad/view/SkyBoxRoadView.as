package skyboxroad.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Point;
   import managers.SkyboxRoadManager;
   import mvc.module.skyboxroad.SkyTrialLayerInfo;
   import mvc.module.skyboxroad.SkyTrialPortalInfo;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   
   public class SkyBoxRoadView extends Component
   {
      
      private var _checkPointObj:Object;
      
      private const CHECK_POINT_POS:Array = [[],[new Point(376,128)],[new Point(265,128),new Point(516,128)],[new Point(130,153),new Point(378,103),new Point(631,153)],[new Point(34,157),new Point(267,106),new Point(496,106),new Point(721,157)],[new Point(34,147),new Point(212,189),new Point(385,114),new Point(557,189),new Point(731,147)],[new Point(52,172),new Point(280,26),new Point(480,26),new Point(248,244),new Point(513,244),new Point(706,172)]];
      
      public function SkyBoxRoadView()
      {
         super();
         _checkPointObj = {};
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:SkyTrialPortalInfo = null;
         var _loc6_:SkyBoxRoadCheckPointView = null;
         for(var _loc1_:String in _checkPointObj)
         {
            if(_checkPointObj[_loc1_] != null && _checkPointObj[_loc1_].parent != null)
            {
               _checkPointObj[_loc1_].parent.removeChild(_checkPointObj[_loc1_]);
            }
         }
         var _loc3_:SkyTrialLayerInfo = model.getCurrentLayerInfo();
         var _loc5_:Array = CHECK_POINT_POS[_loc3_.portalList.length];
         _loc4_ = 0;
         while(_loc4_ < _loc3_.portalList.length)
         {
            _loc2_ = _loc3_.portalList[_loc4_];
            _loc6_ = getCheckPointByIndex(_loc4_.toString());
            _loc6_.x = _loc5_[_loc4_].x;
            _loc6_.y = _loc5_[_loc4_].y;
            _loc6_.saveInitData(_loc2_);
            addChild(_checkPointObj[_loc4_]);
            _loc4_++;
         }
      }
      
      private function getCheckPointByIndex(param1:String) : SkyBoxRoadCheckPointView
      {
         var _loc2_:SkyBoxRoadCheckPointView = _checkPointObj[param1];
         if(_loc2_ == null)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("skyboxroad.SkyBoxRoadCheckPointView");
            _checkPointObj[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function showChooseCheckPoint(param1:SkyBoxRoadCheckPointView) : void
      {
         for(var _loc2_:String in _checkPointObj)
         {
            if(_checkPointObj[_loc2_] != param1)
            {
               _checkPointObj[_loc2_].visible = false;
            }
         }
         TweenMax.to(param1,0.3,{
            "x":381,
            "y":109,
            "onComplete":onMoveCheckPointComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function onMoveCheckPointComplete(param1:SkyBoxRoadCheckPointView = null) : void
      {
         param1.showFindBg();
      }
      
      public function showInitView() : void
      {
         for(var _loc1_:String in _checkPointObj)
         {
            _checkPointObj[_loc1_]["showInitView"]();
         }
      }
      
      private function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         TweenMax.killChildTweensOf(this);
         if(_checkPointObj != null)
         {
            for(var _loc1_:String in _checkPointObj)
            {
               ObjectUtils.disposeObject(_checkPointObj[_loc1_]);
               _checkPointObj[_loc1_] = null;
               delete _checkPointObj[_loc1_];
            }
         }
         ObjectUtils.disposeObject(_checkPointObj);
         _checkPointObj = null;
         super.dispose();
      }
   }
}

