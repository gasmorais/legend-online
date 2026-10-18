package childspiritexpedition
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SpiritExpeditionManager;
   import mvc.module.childspiritexpedition.SpiritExpeditionModel;
   import yishi.utils.GoodsHelp;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.tips.MessageTipManager;
   
   public class SpiritExpeditionRewardItem extends Component
   {
      
      private var _boxImage:ScaleFrameImage;
      
      private var _starItem:TokenAmountItem;
      
      private var _rewardAry:Array;
      
      public var star:int;
      
      private var starIndex:int;
      
      private var rewardState:int;
      
      public function SpiritExpeditionRewardItem(param1:int)
      {
         super();
         starIndex = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _boxImage = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionRewardItem.boxImage");
         _starItem = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionRewardItem.starItem");
         addChild(_boxImage);
         addChild(_starItem);
         _boxImage.setFrame(1);
         _boxImage.buttonMode = true;
      }
      
      private function addEvent() : void
      {
         _boxImage.addEventListener("click",__boxClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_boxImage)
         {
            _boxImage.removeEventListener("click",__boxClickHandler);
         }
      }
      
      private function __boxClickHandler(param1:MouseEvent) : void
      {
         if(rewardState == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("SpiritExpeditionRewardItem.rewardItem.needStarGetReward"));
            return;
         }
         if(rewardState == 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("SpiritExpeditionRewardItem.rewardItem.hasGetReward"));
            return;
         }
         SpiritExpeditionManager.instance.sendExpeditionGetReward(starIndex + 1);
      }
      
      public function get rewardAry() : Array
      {
         return _rewardAry;
      }
      
      public function set rewardAry(param1:Array) : void
      {
         _starItem.firstText = star + "";
         _rewardAry = param1;
         var _loc2_:String = LanguageMgr.GetTranslation("SpiritExpeditionRewardItem.rewardItem.tip");
         _loc2_ += "\n" + GoodsHelp.getRewardDesc3(param1);
         _boxImage.tipData = _loc2_;
      }
      
      public function refreshView() : void
      {
         if(model.rewardState && model.rewardState.indexOf((starIndex + 1).toString()) != -1)
         {
            _boxImage.setFrame(3);
            rewardState = 3;
         }
         else if(model.getTotalStar() >= star)
         {
            _boxImage.setFrame(2);
            rewardState = 2;
         }
         else
         {
            _boxImage.setFrame(1);
            rewardState = 1;
         }
      }
      
      private function get model() : SpiritExpeditionModel
      {
         return SpiritExpeditionManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_boxImage);
         _boxImage = null;
         ObjectUtils.disposeObject(_starItem);
         _starItem = null;
         super.dispose();
      }
   }
}

