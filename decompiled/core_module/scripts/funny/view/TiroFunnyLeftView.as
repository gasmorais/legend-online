package funny.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funny.FunnyEvent;
   import managers.FunnyManager;
   
   public class TiroFunnyLeftView extends Sprite implements Disposeable
   {
      
      private var _vbox:VBox;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _maxPage:int;
      
      private var _currPage:int = 1;
      
      private var _itemList:Array;
      
      private var _selectedIndex:int = 0;
      
      public function TiroFunnyLeftView()
      {
         super();
         initView();
         initEvent();
         initData(1);
      }
      
      private function initView() : void
      {
         _itemList = [];
         _vbox = ComponentFactory.Instance.creatComponentByStylename("funnyFrame.leftVBox");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.nextBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.pageText");
         _vbox.spacing = -7;
         _vbox.x = 5;
         _vbox.y = 5;
         addChild(_vbox);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageTxt);
         _pageTxt.text = "1 / 1";
      }
      
      private function initData(param1:int, param2:String = "") : void
      {
         var _loc6_:int = 0;
         var _loc3_:TiroFunnyButton = null;
         var _loc8_:int = 0;
         var _loc7_:TiroFunnyButton = null;
         var _loc4_:int = int(tiroList.length);
         _maxPage = _loc4_ % 8 == 0 ? _loc4_ / 8 : _loc4_ / 8 + 1;
         if(_maxPage < 1)
         {
            _maxPage = 1;
         }
         _pageTxt.text = param1 + " / " + _maxPage;
         var _loc5_:int = int(_loc4_ >= param1 * 8 ? param1 * 8 : _loc4_);
         clearAll();
         _vbox.disposeAllChildren();
         _loc6_ = (param1 - 1) * 8;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("funny.leftBtn");
            _loc3_.data = tiroList[_loc6_];
            _vbox.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc3_.addEventListener("click",__funnyBtnClickHandler);
            _loc6_++;
         }
         if(param2 == "")
         {
            _selectedIndex = 0;
         }
         else
         {
            FunnyManager.instance.dispatchEvent(new FunnyEvent("TIROITEM_CHANGE"));
            _loc8_ = _vbox.numChildren;
            while(_loc8_ > 0)
            {
               _loc7_ = _vbox.getChildAt(_loc8_ - 1) as TiroFunnyButton;
               if(_loc7_.data.id == param2)
               {
                  _selectedIndex = _loc8_ - 1;
                  break;
               }
               _loc8_--;
            }
         }
         if(tiroList && tiroList.length > 0)
         {
            showBtnState(_selectedIndex + 1);
         }
         else
         {
            _maxPage = 1;
         }
         if(_currPage >= _maxPage)
         {
            _nextBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
         }
         if(_currPage <= 1)
         {
            _preBtn.enable = false;
         }
         else
         {
            _preBtn.enable = true;
         }
      }
      
      private function get tiroList() : Array
      {
         return FunnyManager.instance.model.currentTiroList;
      }
      
      public function locatedBtn(param1:int) : void
      {
         var _loc2_:TiroFunnyButton = null;
         if(tiroList && tiroList.length > 0)
         {
            if(_vbox.numChildren > 0)
            {
               if(param1 > _vbox.numChildren)
               {
                  param1 = 1;
               }
               _loc2_ = _vbox.getChildAt(param1 - 1) as TiroFunnyButton;
               _loc2_.dispatchEvent(new MouseEvent("click"));
            }
         }
      }
      
      private function initEvent() : void
      {
         _nextBtn.addEventListener("click",__pageClickHandler);
         _preBtn.addEventListener("click",__pageClickHandler);
      }
      
      private function __pageClickHandler(param1:MouseEvent) : void
      {
         _nextBtn.enable = true;
         _preBtn.enable = true;
         switch(param1.currentTarget)
         {
            case _nextBtn:
               if(_currPage >= _maxPage)
               {
                  _currPage = _maxPage;
                  return;
               }
               _currPage = _currPage + 1;
               break;
            case _preBtn:
               if(_currPage <= 1)
               {
                  _currPage = 1;
                  return;
               }
               _currPage = _currPage - 1;
         }
         initData(_currPage);
      }
      
      public function refreshView() : void
      {
         initData(_currPage,FunnyManager.instance.tiroFunnySelectedId);
      }
      
      private function showBtnState(param1:int) : void
      {
         var _loc4_:TiroFunnyButton = null;
         var _loc2_:int = _vbox.numChildren;
         while(_loc2_ > 0)
         {
            _loc4_ = _vbox.getChildAt(_loc2_ - 1) as TiroFunnyButton;
            _loc4_.selected = false;
            _loc2_--;
         }
         if(_vbox.numChildren > 0)
         {
            if(param1 > _vbox.numChildren)
            {
               param1 = 1;
            }
         }
         var _loc3_:TiroFunnyButton = _vbox.getChildAt(param1 - 1) as TiroFunnyButton;
         _loc3_.dispatchEvent(new MouseEvent("click"));
         _loc3_.selected = true;
      }
      
      private function __funnyBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:TiroFunnyButton = null;
         var _loc4_:TiroFunnyButton = param1.currentTarget as TiroFunnyButton;
         FunnyManager.instance.tiroFunnySelectedId = _loc4_.data.id;
         var _loc2_:int = _vbox.numChildren;
         while(_loc2_ > 0)
         {
            _loc3_ = _vbox.getChildAt(_loc2_ - 1) as TiroFunnyButton;
            _loc3_.selected = false;
            _loc2_--;
         }
         _loc4_.selected = true;
      }
      
      private function removeEvent() : void
      {
         _nextBtn.removeEventListener("click",__pageClickHandler);
         _preBtn.removeEventListener("click",__pageClickHandler);
      }
      
      private function clearAll() : void
      {
         var _loc1_:TiroFunnyButton = null;
         while(_itemList.length > 0)
         {
            _loc1_ = _itemList.shift() as TiroFunnyButton;
            _loc1_.removeEventListener("click",__funnyBtnClickHandler);
            ObjectUtils.disposeObject(_loc1_);
         }
      }
      
      private function setfilter() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearAll();
         ObjectUtils.disposeObject(_vbox);
         ObjectUtils.disposeObject(_preBtn);
         ObjectUtils.disposeObject(_nextBtn);
         ObjectUtils.disposeObject(_pageTxt);
      }
   }
}

