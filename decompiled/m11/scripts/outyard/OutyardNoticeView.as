package outyard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.FilterWordManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   
   public class OutyardNoticeView extends Component
   {
      
      private var _title:DisplayObject;
      
      private var _inputBgBmp:DisplayObject;
      
      private var _changeBtn:IconButton;
      
      private var _inputTxt:FilterFrameText;
      
      public function OutyardNoticeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatBitmap("asset.outyard.NoticeViewTitle");
         _inputBgBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.noticeInputBmp");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.blessNoticeBtn");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardNoticeView.noticeValueTxt");
         addChild(_title);
         addChild(_inputBgBmp);
         addChild(_changeBtn);
         addChild(_inputTxt);
         _changeBtn.enable = false;
         var _loc2_:SimpleDictionary = ConsortiaManager.instance.model.consortiaMemberList;
         for each(var _loc1_:ThaneInfo in _loc2_)
         {
            if(_loc1_.userId == playerInfo.userId && _loc1_.dutyId == 1)
            {
               _changeBtn.enable = true;
            }
         }
         _inputTxt.maxChars = 120;
      }
      
      private function addEvent() : void
      {
         _changeBtn.addEventListener("click",onClick);
         NotificationManager.instance.addEventListener("OUTYARD_FULL_INFO",__refreshNoticeHandler);
         __refreshNoticeHandler(null);
      }
      
      private function removeEvent() : void
      {
         _changeBtn.removeEventListener("click",onClick);
         NotificationManager.instance.removeEventListener("OUTYARD_FULL_INFO",__refreshNoticeHandler);
      }
      
      private function __refreshNoticeHandler(param1:NotificationEvent) : void
      {
         _inputTxt.text = OutyardManager.instance.model.myForce.notice;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = _inputTxt.text;
         _loc2_ = StringHelper.trim(_loc2_);
         _loc2_ = FilterWordManager.filterWrod(_loc2_);
         _loc2_ = StringHelper.rePlaceHtmlTextField(_loc2_);
         OutyardManager.instance.OperateMapOutyard(6,0,0,_loc2_);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_inputBgBmp);
         _inputBgBmp = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         super.dispose();
      }
   }
}

