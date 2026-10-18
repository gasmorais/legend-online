package yishi.view.frame.giftdonatio
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   
   public class AutoSearchFriendView extends Sprite implements Disposeable
   {
      
      private var _list:VBox;
      
      private var _tempText:FilterFrameText;
      
      private var _tempList:Array;
      
      private var _searchString:String;
      
      private var _backGround:ScaleBitmapImage;
      
      private var _dataList:Array = [];
      
      public function AutoSearchFriendView(param1:Array = null)
      {
         super();
         _dataList = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _backGround = ComponentFactory.Instance.creatComponentByStylename("friends.searchResultBg");
         _backGround.width = 155;
         _backGround.height = 120;
         addChild(_backGround);
         _list = new VBox();
         _list.y = 10;
         _list.spacing = 8;
         addChild(_list);
         _tempText = ComponentFactory.Instance.creatComponentByStylename("shop.Combox_TextStyle");
         _tempText.width = 155;
         _tempText.x = 0;
         _tempText.text = LanguageMgr.GetTranslation("friends.view.FriendAutoSearchBox.temp");
         _tempText.mouseEnabled = false;
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
         var _loc2_:Array = _dataList;
         for each(var _loc1_:String in _loc2_)
         {
            if(_loc1_.indexOf(_searchString) >= 0)
            {
               _tempList.push(_loc1_);
               if(_tempList.length >= 8)
               {
                  return;
               }
            }
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:FriendItemBtn = null;
         if(_tempList.length == 0)
         {
            _list.addChild(_tempText);
            _backGround.height = 30;
            return;
         }
         for each(var _loc2_:String in _tempList)
         {
            _loc1_ = new FriendItemBtn();
            _loc1_.friendName = _loc2_;
            _list.addChild(_loc1_);
         }
         _backGround.height = _list.y + _list.height + 6;
      }
      
      protected function onSelect(param1:Event) : void
      {
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

