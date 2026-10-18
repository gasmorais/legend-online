package theseusdoublepvproom.invite
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import yishi.manager.IMEManager;
   import yishi.utils.StringHelper;
   
   public class TheseusInviteSearchView extends Sprite implements Disposeable
   {
      
      private var _searchText:FilterFrameText;
      
      private var _bg:ScaleBitmapImage;
      
      private var _btn:SelectedButton;
      
      private var _searchList:TheseusInviteAutoSearchBox;
      
      private var _currentList:Array;
      
      private var _tempStr:String = "";
      
      public function TheseusInviteSearchView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("roomInvite.searchBg");
         addChild(_bg);
         _btn = ComponentFactory.Instance.creatComponentByStylename("roomInvite.searchBtn");
         addChild(_btn);
         _btn.selected = false;
         _btn.mouseEnabled = false;
         _searchText = ComponentFactory.Instance.creatComponentByStylename("roomInvite.SearchTextStyle");
         addChild(_searchText);
         _searchList = new TheseusInviteAutoSearchBox();
         _searchList.x = _searchText.x;
         _searchList.y = _searchText.y + _searchText.height;
      }
      
      private function uninit() : void
      {
         StageReferance.stage.focus = null;
         ObjectUtils.disposeAllChildren(this);
         _searchText = null;
      }
      
      private function initEvent() : void
      {
         _searchText.addEventListener("change",_textChange);
         _searchText.addEventListener("click",__inHandler);
         _searchText.addEventListener("keyDown",__keyDownHandler);
         _btn.addEventListener("click",__deleteHandler);
      }
      
      private function removeEvent() : void
      {
         if(_searchText)
         {
            _searchText.removeEventListener("change",_textChange);
            _searchText.removeEventListener("click",__inHandler);
            _searchText.removeEventListener("keyDown",__keyDownHandler);
         }
         if(_btn)
         {
            _btn.removeEventListener("click",__deleteHandler);
         }
         StageReferance.stage.removeEventListener("click",__stageClick);
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _searchText.text = "";
         hideList();
         _btn.selected = false;
         _btn.mouseEnabled = false;
      }
      
      private function _textChange(param1:Event) : void
      {
         if(_searchText.text == "")
         {
            hideList();
            _btn.selected = false;
            _btn.mouseEnabled = false;
         }
         else
         {
            showList();
            _btn.selected = true;
            _btn.mouseEnabled = true;
            if(StringHelper.checkStringLength(_searchText.text) > 12)
            {
               _searchText.text = _tempStr;
            }
            _tempStr = _searchText.text;
         }
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function hideList() : void
      {
         if(_searchList.parent)
         {
            _searchList.parent.removeChild(_searchList);
         }
      }
      
      public function setCurrentList(param1:Array) : void
      {
         _currentList = param1;
      }
      
      private function showList() : void
      {
         _searchList.setSearchString(_searchText.text,_currentList);
         addChild(_searchList);
      }
      
      private function __inHandler(param1:MouseEvent) : void
      {
         IMEManager.enable();
         _textChange(null);
         StageReferance.stage.addEventListener("click",__stageClick);
      }
      
      private function __stageClick(param1:MouseEvent) : void
      {
         if(this.hitTestPoint(param1.stageX,param1.stageY,true))
         {
            return;
         }
         if(DisplayUtils.isTargetOrContain(param1.target as DisplayObject,_searchList))
         {
            return;
         }
         StageReferance.stage.removeEventListener("click",__stageClick);
         hideList();
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(_searchList)
         {
            _searchList.dispose();
         }
         _searchList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

