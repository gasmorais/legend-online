package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class MagicSpringBufferAddView extends Component
   {
      
      private var descText:FilterFrameText;
      
      private var timeText:FilterFrameText;
      
      private var _data:MagicSpringSlotInfo;
      
      public function MagicSpringBufferAddView(param1:MagicSpringSlotInfo)
      {
         super();
         _data = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         descText = ComponentFactory.Instance.creatComponentByStylename("MagicSpringBufferAddView.descText");
         timeText = ComponentFactory.Instance.creatComponentByStylename("MagicSpringBufferAddView.timeText");
         addChild(descText);
         addChild(timeText);
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__leftTimeHandler);
      }
      
      private function removeEvent() : void
      {
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__leftTimeHandler);
      }
      
      public function setDescText(param1:String) : void
      {
         descText.htmlText = param1;
         descText.width = descText.textWidth + 5;
      }
      
      private function __leftTimeHandler(param1:PlayerEvent) : void
      {
         var _loc2_:String = "";
         if(_data.validCountDown > 0)
         {
            _loc2_ = DateFormatter.getConsortiaCountDate(_data.validCountDown);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
         }
         timeText.htmlText = LanguageMgr.GetTranslation("MagicSpringBufferAddView.timeText.text",_loc2_);
         timeText.y = descText.textHeight - 2;
      }
      
      public function stopTimer() : void
      {
         removeEvent();
      }
      
      public function resetTimer() : void
      {
         addEvent();
      }
      
      public function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(descText);
         descText = null;
         ObjectUtils.disposeObject(timeText);
         timeText = null;
         super.dispose();
      }
   }
}

