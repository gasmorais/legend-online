package friends.view
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
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.FriendManager;
   
   public class FriendAutoSearchBox extends Sprite implements Disposeable
   {
      
      private var _list:VBox;
      
      private var _friendList:Dictionary;
      
      private var _tempText:FilterFrameText;
      
      private var _tempList:Array;
      
      private var _searchString:String;
      
      private var _backGround:ScaleBitmapImage;
      
      private var _dataList:Array = [];
      
      private var _isDefualt:Boolean = true;
      
      public function FriendAutoSearchBox(param1:Array = null)
      {
         super();
         if(param1)
         {
            _dataList = param1;
            _isDefualt = false;
         }
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _backGround = ComponentFactory.Instance.creatComponentByStylename("friends.searchResultBg");
         _backGround.width = 235;
         _backGround.height = 120;
         addChild(_backGround);
         _list = new VBox();
         _list.y = 10;
         _list.spacing = 8;
         addChild(_list);
         _friendList = FriendManager.getInstance().friendList;
         _tempText = ComponentFactory.Instance.creatComponentByStylename("friends.AutoSearchTextStyle");
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
         var _loc3_:Array = null;
         var _loc2_:String = null;
         removeList();
         if(_isDefualt)
         {
            if(control.currentPanel == 1)
            {
               _loc3_ = FriendManager.getInstance().friendList.getList();
               _loc3_ = _loc3_.concat(FriendManager.getInstance().crossFriendList.getList());
               _loc3_ = _loc3_.concat(FriendManager.getInstance().crossStrangerList.getList());
               _loc3_ = _loc3_.concat(FriendManager.getInstance().crossBlackList.getList());
            }
            else
            {
               _loc3_ = ConsortiaManager.instance.model.consortiaMemberList.getList();
            }
         }
         else
         {
            _loc3_ = _dataList;
         }
         var _loc1_:String = _searchString.toLocaleLowerCase();
         for each(var _loc4_:Object in _loc3_)
         {
            _loc2_ = _loc4_.nickName.toLocaleLowerCase();
            if(_loc2_.indexOf(_loc1_) >= 0)
            {
               _tempList.push(_loc4_);
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
         var _loc1_:FriendItemButton = null;
         if(_tempList.length == 0)
         {
            _list.addChild(_tempText);
            _backGround.height = 30;
            return;
         }
         _tempList.sortOn("state",2);
         for each(var _loc2_:ThaneInfo in _tempList)
         {
            _loc1_ = new FriendItemButton();
            _loc1_.scaleX = 0.97;
            _loc1_.canDelete = false;
            _loc1_.chatVisible = true;
            _loc1_.data = _loc2_;
            _loc1_.enable = _loc2_.isOnline;
            _list.addChild(_loc1_);
         }
         _backGround.height = _list.y + _list.height + 6;
      }
      
      public function setSearchString(param1:String) : void
      {
         _searchString = param1;
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

