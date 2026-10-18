package theseuspvpscene.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.manager.FrameControllerManager;
   
   public class TheseuspvpSceneRightView extends Sprite
   {
      
      public var _sceneShopBtn:BaseButton;
      
      public var _sceneSortBtn:BaseButton;
      
      public var _sceneGloryBtn:BaseButton;
      
      public var _sceneRewardBtn:BaseButton;
      
      public function TheseuspvpSceneRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _sceneShopBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.sceneShopBtn");
         _sceneSortBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.sceneSortBtn");
         _sceneGloryBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.sceneGloryBtn");
         _sceneRewardBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.sceneRewardBtn");
         addChild(_sceneShopBtn);
         addChild(_sceneSortBtn);
         addChild(_sceneGloryBtn);
         addChild(_sceneRewardBtn);
      }
      
      private function initEvent() : void
      {
         _sceneShopBtn.addEventListener("click",shopHandler);
         _sceneSortBtn.addEventListener("click",sortHandler);
         _sceneGloryBtn.addEventListener("click",gloryHandler);
         _sceneRewardBtn.addEventListener("click",rewardHandler);
      }
      
      private function removeEvent() : void
      {
         _sceneShopBtn.removeEventListener("click",shopHandler);
         _sceneSortBtn.removeEventListener("click",sortHandler);
         _sceneGloryBtn.removeEventListener("click",gloryHandler);
         _sceneRewardBtn.removeEventListener("click",rewardHandler);
      }
      
      private function shopHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",1027);
      }
      
      private function sortHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("theseuspvp","SORT");
      }
      
      private function gloryHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("theseuspvp","GLORY");
      }
      
      private function rewardHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("theseuspvp","PRIVATE");
      }
      
      public function resize(param1:int, param2:int) : void
      {
         this.x = param1 - this.width - 30;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_sceneShopBtn);
         _sceneShopBtn = null;
         ObjectUtils.disposeObject(_sceneSortBtn);
         _sceneSortBtn = null;
         ObjectUtils.disposeObject(_sceneGloryBtn);
         _sceneGloryBtn = null;
         ObjectUtils.disposeObject(_sceneRewardBtn);
         _sceneRewardBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

