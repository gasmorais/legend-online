package im.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.IMManager;
   import mvc.module.friends.IMEvent;
   import mvc.module.friends.IMModel;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FrameControllerManager;
   
   public class IMConsortiaGroupChatMsgBoxItem extends Sprite implements Disposeable
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _msgNumTxt:FilterFrameText;
      
      private var _mouseOverImg:Bitmap;
      
      private var _data:ThaneInfo;
      
      public function IMConsortiaGroupChatMsgBoxItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMConsortiaGroupChatMsgBoxItemNameTxt");
         _msgNumTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMConsortiaGroupChatMsgBoxItemMsgNumTxt");
         _mouseOverImg = ComponentFactory.Instance.creatBitmap("asset.core.IMMsgBoxItemMouseOverBg");
         _mouseOverImg.alpha = 0;
         _nameTxt.text = LanguageMgr.GetTranslation("consortiagroupchat.msgBoxItemNameTxt");
         addChild(_mouseOverImg);
         addChild(_nameTxt);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__clickHandler);
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
         IMManager.instance.addEventListener("RECEIVE_MSG",__receiveMsgHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
         IMManager.instance.removeEventListener("RECEIVE_MSG",__receiveMsgHandler);
      }
      
      private function __receiveMsgHandler(param1:IMEvent) : void
      {
         if(_data && param1.msg && _data.userId == param1.msg.userId)
         {
            refreshView();
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         MainToolBar.instance.poptipButtonShine = false;
         MainToolBar.instance.poptipButtonVisible = false;
         IMManager.instance.removeIMMsgBox();
         FrameControllerManager.instance.openControllerByInfo("consortiagroupchat");
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(_nameTxt)
         {
            _nameTxt.setFrame(2);
         }
         if(_msgNumTxt)
         {
            _msgNumTxt.setFrame(2);
         }
         _mouseOverImg.alpha = 1;
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(_nameTxt)
         {
            _nameTxt.setFrame(1);
         }
         if(_msgNumTxt)
         {
            _msgNumTxt.setFrame(1);
         }
         _mouseOverImg.alpha = 0;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function refreshView() : void
      {
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      private function get imModel() : IMModel
      {
         return IMManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_msgNumTxt)
         {
            _msgNumTxt.dispose();
         }
         _msgNumTxt = null;
         _mouseOverImg = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

