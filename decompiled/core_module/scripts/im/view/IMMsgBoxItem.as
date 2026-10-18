package im.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.IMManager;
   import mvc.module.friends.BaseIMInfo;
   import mvc.module.friends.IMEvent;
   import mvc.module.friends.IMModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerManager;
   
   public class IMMsgBoxItem extends Sprite implements Disposeable
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _msgNumTxt:FilterFrameText;
      
      private var _delBtn:BaseButton;
      
      private var _mouseOverImg:Bitmap;
      
      private var _data:ThaneInfo;
      
      public function IMMsgBoxItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMMsgBoxItemNameTxt");
         _msgNumTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMMsgBoxItemMsgNumTxt");
         _delBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMMsgBoxItemDelBtn");
         _mouseOverImg = ComponentFactory.Instance.creatBitmap("asset.core.IMMsgBoxItemMouseOverBg");
         _mouseOverImg.alpha = 0;
         addChild(_mouseOverImg);
         addChild(_nameTxt);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__clickHandler);
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
         _delBtn.addEventListener("click",__onDelClick);
         IMManager.instance.addEventListener("RECEIVE_MSG",__receiveMsgHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
         _delBtn.removeEventListener("click",__onDelClick);
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
         if(_data)
         {
            IMManager.instance.createIMFrame(_data);
            IMManager.instance.removeIMMsgBox();
         }
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
         addChild(_delBtn);
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
         if(_delBtn && _delBtn.parent)
         {
            _delBtn.parent.removeChild(_delBtn);
         }
      }
      
      private function __onDelClick(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         if(_data)
         {
            _loc2_ = _data.serviceName != "" && _data.serviceName != null && _data.serviceName != playerInfo.serviceName;
            _loc3_ = _loc2_ ? _data.serviceName + "_" + _data.userId : _data.userId + "";
            IMManager.instance.removeIMFrame(_loc3_);
            IMManager.instance.cleanMsgListByIdAndType(_loc3_,1);
         }
         dispose();
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc1_:Boolean = false;
         var _loc3_:String = null;
         var _loc2_:* = undefined;
         if(_data)
         {
            _loc1_ = _data.serviceName != "" && _data.serviceName != null && _data.serviceName != playerInfo.serviceName;
            _loc3_ = _loc1_ ? _data.serviceName + "_" + _data.userId : _data.userId + "";
            _loc2_ = imModel.unreadMsgDic[_loc3_];
            _nameTxt.text = _data.nickName;
            if(_loc2_ && _loc2_.length > 0)
            {
               _msgNumTxt.text = "(" + _loc2_.length + ")";
               addChild(_msgNumTxt);
            }
            else if(_msgNumTxt.parent)
            {
               _msgNumTxt.parent.removeChild(_msgNumTxt);
            }
         }
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      private function get imModel() : IMModel
      {
         return IMManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
         if(_delBtn)
         {
            _delBtn.dispose();
         }
         _delBtn = null;
         _mouseOverImg = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

