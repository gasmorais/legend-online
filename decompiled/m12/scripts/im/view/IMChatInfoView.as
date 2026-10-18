package im.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.IMManager;
   import mvc.module.friends.BaseIMInfo;
   import mvc.module.friends.IMEvent;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerManager;
   
   public class IMChatInfoView extends Sprite implements Disposeable
   {
      
      private var _scaleFrameBg:ScaleBitmapImage;
      
      private var _bg:Bitmap;
      
      private var _noticeImg:Bitmap;
      
      private var _notice:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _msgVBox:VBox;
      
      private var _data:ThaneInfo;
      
      private var _contain:Sprite;
      
      public function IMChatInfoView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _scaleFrameBg = ComponentFactory.Instance.creatComponentByStylename("core.IMChatInfoScaleBg");
         _bg = ComponentFactory.Instance.creatBitmap("asset.core.IMChatInfoBg");
         _noticeImg = ComponentFactory.Instance.creatBitmap("asset.core.IMChatInfoNoticeImg");
         _notice = ComponentFactory.Instance.creatComponentByStylename("core.IMChatInfoNotice");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("core.IMChatInfoScrollPanel");
         _msgVBox = ComponentFactory.Instance.creatComponentByStylename("core.IMChatMsgVBox");
         _contain = new Sprite();
         _contain.addChild(_noticeImg);
         _contain.addChild(_notice);
         _msgVBox.addChild(_contain);
         _scrollPanel.setView(_msgVBox);
         addChild(_scaleFrameBg);
         addChild(_bg);
         addChild(_scrollPanel);
         _notice.text = LanguageMgr.GetTranslation("friends.im.view.IMChatInfoView.Notice");
      }
      
      private function addEvent() : void
      {
         imManager.addEventListener("MSG_SEND_RESPONSE",__sendMsgResponseHandler);
         imManager.addEventListener("RECEIVE_MSG",__receiveMsgHandler);
      }
      
      private function removeEvent() : void
      {
         imManager.removeEventListener("MSG_SEND_RESPONSE",__sendMsgResponseHandler);
         imManager.removeEventListener("RECEIVE_MSG",__receiveMsgHandler);
      }
      
      private function __sendMsgResponseHandler(param1:IMEvent) : void
      {
         var _loc2_:BaseIMInfo = param1.msg;
         if(_loc2_ && _data && _loc2_.sendResult == 0)
         {
            if(isCross)
            {
               if(_loc2_.imThane && _data.userId == _loc2_.toId)
               {
                  addMsgItem(createMsgItem(_loc2_));
               }
            }
            else if(!_loc2_.imThane && _data.userId == _loc2_.toId)
            {
               addMsgItem(createMsgItem(_loc2_));
            }
         }
      }
      
      private function __receiveMsgHandler(param1:IMEvent) : void
      {
         var _loc2_:BaseIMInfo = param1.msg;
         if(_loc2_ && _data)
         {
            if(isCross)
            {
               if(_loc2_.imThane && _data.userId == _loc2_.userId && _data.serviceName == _loc2_.imThane.serviceName)
               {
                  addMsgItem(createMsgItem(_loc2_));
               }
            }
            else if(!_loc2_.imThane && _data.userId == _loc2_.userId)
            {
               addMsgItem(createMsgItem(_loc2_));
            }
         }
      }
      
      private function refreshView() : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Boolean = _data.serviceName != "" && _data.serviceName != null && _data.serviceName != playerInfo.serviceName;
         var _loc4_:String = _loc2_ ? _data.serviceName + "_" + _data.userId : _data.userId + "";
         if(_data && imManager.model.unreadMsgDic[_loc4_])
         {
            _loc3_ = imManager.model.unreadMsgDic[_loc4_];
            for each(var _loc1_:BaseIMInfo in _loc3_)
            {
               addMsgItem(createMsgItem(_loc1_));
            }
         }
      }
      
      private function createMsgItem(param1:BaseIMInfo) : IMChatInfoItem
      {
         var _loc2_:IMChatInfoItem = null;
         if(!param1)
         {
            return null;
         }
         var _loc3_:Boolean = false;
         if(isCross)
         {
            if(param1.imThane && param1.userId == playerInfo.userId && param1.imThane.serviceName == playerInfo.serviceName)
            {
               _loc3_ = true;
            }
         }
         else if(!param1.imThane && param1.userId == playerInfo.userId)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc2_ = new IMChatInfoItem(1,param1);
            _loc2_.x = _bg.width - _loc2_.width - 12;
         }
         else
         {
            _loc2_ = new IMChatInfoItem(2,param1);
         }
         return _loc2_;
      }
      
      private function addMsgItem(param1:IMChatInfoItem) : void
      {
         _msgVBox.addChild(param1);
         _scrollPanel.invalidateViewport(true);
      }
      
      public function cleanView() : void
      {
         cleanData();
         _msgVBox.addChild(_contain);
         _scrollPanel.invalidateViewport(true);
      }
      
      private function cleanData() : void
      {
         var _loc1_:DisplayObject = null;
         while(_msgVBox.numChildren > 0)
         {
            _loc1_ = _msgVBox.getChildAt(0);
            _msgVBox.removeChild(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
      }
      
      private function get imManager() : IMManager
      {
         return IMManager.instance;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function get isCross() : Boolean
      {
         return _data.serviceName != "" && _data.serviceName != null && _data.serviceName != playerInfo.serviceName;
      }
      
      public function dispose() : void
      {
         removeEvent();
         cleanData();
         ObjectUtils.disposeAllChildren(this);
         if(_scaleFrameBg)
         {
            _scaleFrameBg.dispose();
         }
         _scaleFrameBg = null;
         if(_scrollPanel)
         {
            _scrollPanel.dispose();
         }
         _scrollPanel = null;
         if(_msgVBox)
         {
            _msgVBox.dispose();
         }
         _msgVBox = null;
         _bg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

