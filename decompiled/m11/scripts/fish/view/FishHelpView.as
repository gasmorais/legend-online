package fish.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.FishEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import managers.FishManager;
   import mvc.module.fish.FishModel;
   import mvc.module.fish.FishPlayerInfo;
   import yishi.view.community.TimeDownView;
   import yishi.view.component.MovieButton;
   
   public class FishHelpView extends Sprite implements Disposeable
   {
      
      private var _helpBtn:MovieButton;
      
      private var _helpTime:TimeDownView;
      
      private var _helpTxtMc:MovieClip;
      
      private var _hBoxHelp:HBox;
      
      private var _helpArray:Array = [];
      
      private var _fishHelpFrame:FishHelpFrame;
      
      public function FishHelpView()
      {
         super();
         initView();
         addEvent();
         __updateFishPoolHandler(null);
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FishHelpSprite = null;
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("fish.FishHelpView.helpBtn");
         _helpTime = ComponentFactory.Instance.creatComponentByStylename("fish.FishHelpView.helpTime");
         _helpTxtMc = ComponentFactory.Instance.creatCustomObject("fish.FishHelpView.helpTxtMc");
         _hBoxHelp = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.hBoxHelp");
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = new FishHelpSprite();
            _hBoxHelp.addChild(_loc2_);
            _helpArray.push(_loc2_);
            _loc1_++;
         }
         _hBoxHelp.visible = true;
         addChild(_helpBtn);
         addChild(_helpTime);
         addChild(_helpTxtMc);
         addChild(_hBoxHelp);
      }
      
      private function addEvent() : void
      {
         _helpTime.addEventListener("timerDown_complete",__completeHandler);
         _helpBtn.addEventListener("click",__clickHandler);
         model.addEventListener("UPDATE_FISH_POOL",__updateFishPoolHandler);
         model.addEventListener("POINT_HELP",__pointHelpHandler);
      }
      
      protected function __pointHelpHandler(param1:FishEvent) : void
      {
         model.isRageReward = true;
         over();
      }
      
      protected function __updateFishPoolHandler(param1:FishEvent) : void
      {
         var _loc2_:FishPlayerInfo = null;
         var _loc4_:FishHelpSprite = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _helpArray.length)
         {
            if(model.playerList.length > _loc3_)
            {
               _loc2_ = model.playerList[_loc3_];
            }
            else
            {
               _loc2_ = null;
            }
            _loc4_ = _helpArray[_loc3_] as FishHelpSprite;
            _loc4_.data = _loc2_;
            _loc3_++;
         }
         if(model.playerList.length == 3 && Boolean(model.isSelf))
         {
            model.isRageReward = true;
            over();
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         _fishHelpFrame = ComponentFactory.Instance.creatComponentByStylename("fish.FishHelpFrame");
         _fishHelpFrame.timeNum(_helpTime.timeCount - 1);
         _fishHelpFrame.show();
         _helpTxtMc.visible = false;
      }
      
      private function removeEvent() : void
      {
         if(_helpTime)
         {
            _helpTime.removeEventListener("timerDown_complete",__completeHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__clickHandler);
         }
         model.removeEventListener("UPDATE_FISH_POOL",__updateFishPoolHandler);
         model.removeEventListener("POINT_HELP",__pointHelpHandler);
      }
      
      private function over() : void
      {
         model.isRageSuccess = true;
         if(_fishHelpFrame)
         {
            ObjectUtils.disposeObject(_fishHelpFrame);
            _fishHelpFrame = null;
         }
         setVisible(false);
      }
      
      public function cleanHelpArray() : void
      {
         var _loc2_:FishHelpSprite = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _helpArray.length)
         {
            _loc2_ = _helpArray[_loc1_] as FishHelpSprite;
            _loc2_.data = null;
            _loc1_++;
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         _helpBtn.visible = param1;
         _helpTime.visible = param1;
         _helpTxtMc.visible = param1;
      }
      
      public function rageOver() : void
      {
         cleanHelpArray();
         model.playerList.length = 0;
         setVisible(true);
         visible = false;
      }
      
      private function __completeHandler(param1:Event) : void
      {
         model.isRageReward = false;
         over();
      }
      
      public function get helpTime() : TimeDownView
      {
         return _helpTime;
      }
      
      public function get helpBtn() : MovieButton
      {
         return _helpBtn;
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      public function dispose() : void
      {
         _helpArray = null;
         removeEvent();
         ObjectUtils.disposeObject(_fishHelpFrame);
         _fishHelpFrame = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_helpTime);
         _helpTime = null;
         if(_helpTxtMc)
         {
            _helpTxtMc.stop();
         }
         ObjectUtils.disposeObject(_helpTxtMc);
         _helpTxtMc = null;
         ObjectUtils.disposeObject(_hBoxHelp);
         _hBoxHelp = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

