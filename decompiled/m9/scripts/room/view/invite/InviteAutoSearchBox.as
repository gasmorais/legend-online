package room.view.invite
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.controler.FriendControler;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   
   public class InviteAutoSearchBox extends Sprite implements Disposeable
   {
      
      private var _list:VBox;
      
      private var _friendList:Dictionary;
      
      private var _tempText:FilterFrameText;
      
      private var _tempList:Array;
      
      private var _searchString:String;
      
      private var _backGround:ScaleBitmapImage;
      
      private var _dataList:Array = [];
      
      public function InviteAutoSearchBox(param1:Array = null)
      {
         super();
         if(param1)
         {
            _dataList = param1;
         }
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _backGround = ComponentFactory.Instance.creatComponentByStylename("roomInvite.searchResultBg");
         _backGround.width = 290;
         _backGround.height = 120;
         addChild(_backGround);
         _list = new VBox();
         _list.y = 10;
         _list.spacing = 8;
         addChild(_list);
         _friendList = FriendManager.getInstance().friendList;
         _tempText = ComponentFactory.Instance.creatComponentByStylename("roomInvite.AutoSearchTextStyle");
         _tempText.text = LanguageMgr.GetTranslation("friends.view.FriendAutoSearchBox.temp");
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _backGround = null;
      }
      
      private function initEvent() : void
      {
         _backGround.addEventListener("click",__clickHander);
      }
      
      private function removeEvent() : void
      {
         if(_backGround)
         {
            _backGround.removeEventListener("click",__clickHander);
         }
      }
      
      private function removeList() : void
      {
         _tempList = [];
         _list.disposeAllChildren();
         _list.refreshChildPos();
      }
      
      private function refreshList() : void
      {
         removeList();
         for each(var _loc1_:Object in _dataList)
         {
            if(_loc1_.nickName.indexOf(_searchString) >= 0)
            {
               _tempList.push(_loc1_);
               if(_tempList.length >= 5)
               {
                  return;
               }
            }
         }
      }
      
      private function get control() : FriendControler
      {
         return FrameControllerManager.instance.friendControler;
      }
      
      private function refreshView() : void
      {
         var _loc1_:InviteItemButton = null;
         if(_tempList.length == 0)
         {
            _list.addChild(_tempText);
            _backGround.height = 30;
            return;
         }
         _tempList.sortOn("state",2);
         for each(var _loc2_:ThaneInfo in _tempList)
         {
            _loc1_ = new InviteItemButton();
            _loc1_.data = _loc2_;
            _list.addChild(_loc1_);
         }
         _backGround.height = _list.y + _list.height + 6;
      }
      
      public function setSearchString(param1:String, param2:Array) : void
      {
         _searchString = param1;
         _dataList = param2;
         refreshList();
         refreshView();
      }
      
      private function __clickHander(param1:MouseEvent) : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(_list)
         {
            _list.dispose();
         }
         _list = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

