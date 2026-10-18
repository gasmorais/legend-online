package unrealshooting.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.data.UnrealShootingModel;
   import mvc.controler.UnrealShootingController;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   
   public class UnrealShootingRoomTopView extends Sprite implements Disposeable, IEnterFrame
   {
      
      private var _bg:Image;
      
      private var _titleTxt:Image;
      
      private var _waitTimeTxt:FilterFrameText;
      
      private var _waitTime:int;
      
      private var _working:Boolean;
      
      private var _first:Boolean;
      
      private var _controller:UnrealShootingController;
      
      private var _model:UnrealShootingModel;
      
      public function UnrealShootingRoomTopView()
      {
         super();
         _controller = FrameControllerManager.instance.unrealShootingController;
         _model = _controller.model;
         _model.inFiveSecondCounting = false;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomTopView.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomTopView.titleTxt");
         _waitTimeTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomTopView.waitTimeTxt");
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_waitTimeTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_waitTimeTxt);
         _waitTimeTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _controller = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         var _loc1_:int = Math.ceil((getTimer() - _model.currentTime) / 1000);
         var _loc5_:int = _waitTime - _loc1_;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:String = "00";
         var _loc4_:String = "00";
         if(_loc5_ > 0)
         {
            _loc2_ = _loc5_ / 60;
            _loc6_ = _loc5_ % 60;
            _loc3_ = _loc2_.toString();
            _loc4_ = _loc6_.toString();
            if(_loc3_.length < 2)
            {
               _loc3_ = "0" + _loc2_;
            }
            if(_loc4_.length < 2)
            {
               _loc4_ = "0" + _loc6_;
            }
         }
         _waitTimeTxt.text = LanguageMgr.GetTranslation("map.nationwar.view.physics.NationWarArmyView.Tips02",_loc3_,_loc4_);
         if(_loc5_ <= 5 && !_model.inFiveSecondCounting)
         {
            _model.inFiveSecondCounting = true;
            _controller.sendUnrealShootingConfirmTemplate(_model.selectedTempalteId);
         }
      }
      
      public function refreshView() : void
      {
         _waitTime = _model.leftTime;
         if(!_first)
         {
            _first = true;
            if(_waitTime > 5)
            {
               _model.inFiveSecondCounting = false;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

