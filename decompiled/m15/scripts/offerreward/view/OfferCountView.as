package offerreward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.OfferRewardManager;
   import mvc.module.buildings.OfferRewardModel;
   
   public class OfferCountView extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _dailyCountTxt:FilterFrameText;
      
      public function OfferCountView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("offerReward.TitleBg");
         _dailyCountTxt = ComponentFactory.Instance.creatComponentByStylename("offerReward.DailyCountTxt");
         var _loc1_:String = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferCountView.dailyCount");
         _dailyCountTxt.htmlText = _loc1_ + toArialBold(String(rewardModel.remainRewardCount) + " / " + String(rewardModel.maxRewardCount));
         addChild(_bg);
         addChild(_dailyCountTxt);
      }
      
      public function refreshView() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferCountView.dailyCount");
         _dailyCountTxt.htmlText = _loc1_ + toArialBold(String(rewardModel.remainRewardCount) + " / " + String(rewardModel.maxRewardCount));
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_dailyCountTxt);
         _dailyCountTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

