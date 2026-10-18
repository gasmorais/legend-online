package childnswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.ChildNswarManager;
   import mvc.module.childnswar.ChildNswarModel;
   import yishi.manager.FrameControllerManager;
   
   public class ChildNswarRightView extends Sprite
   {
      
      public var _teamBtn:BaseButton;
      
      public var _rewardBtn:BaseButton;
      
      public var _shopBtn:BaseButton;
      
      public var _rankBtn:BaseButton;
      
      public function ChildNswarRightView()
      {
         super();
         initView();
         updateMatchState();
         initEvent();
      }
      
      private function initView() : void
      {
         _teamBtn = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.sceneTeamBtn");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.sceneRewardBtn");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.sceneShopBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.sceneRankBtn");
         addChild(_teamBtn);
         addChild(_rewardBtn);
         addChild(_shopBtn);
         addChild(_rankBtn);
      }
      
      public function updateMatchState() : void
      {
         if(model.matchState == 2 || model.matchState == 0)
         {
            _teamBtn.enable = false;
         }
         else
         {
            _teamBtn.enable = true;
         }
      }
      
      private function get model() : ChildNswarModel
      {
         return ChildNswarManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         _teamBtn.addEventListener("click",teamHandler);
         _rewardBtn.addEventListener("click",rewardHandler);
         _shopBtn.addEventListener("click",shopHandler);
         _rankBtn.addEventListener("click",rankHandler);
      }
      
      private function removeEvent() : void
      {
         _teamBtn.removeEventListener("click",teamHandler);
         _rewardBtn.removeEventListener("click",rewardHandler);
         _shopBtn.removeEventListener("click",shopHandler);
         _rankBtn.removeEventListener("click",rankHandler);
      }
      
      private function teamHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childnswar","TEAM");
      }
      
      private function rewardHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childnswar","REWARD");
      }
      
      private function shopHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",1031);
      }
      
      private function rankHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childnswar","RANK");
      }
      
      public function resize(param1:int, param2:int) : void
      {
         this.x = param1 - this.width - 30;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_teamBtn);
         _teamBtn = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

