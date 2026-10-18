package funny.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import funny.FunnyEvent;
   import managers.FunnyManager;
   
   public class TiroLeftView extends Sprite implements Disposeable
   {
      
      private var _vbox:VBox;
      
      private var _selectedBtnGroup:SelectedButtonGroup;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _maxPage:int;
      
      private var _currPage:int = 1;
      
      private var _index:int = 0;
      
      public function TiroLeftView()
      {
         super();
         initView();
         initEvent();
         initData(_currPage);
      }
      
      private function initView() : void
      {
         _vbox = ComponentFactory.Instance.creatComponentByStylename("funnyFrame.leftVBox");
         _selectedBtnGroup = new SelectedButtonGroup();
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.nextBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("funny.tiroFunny.pageText");
         _vbox.spacing = 1;
         addChild(_vbox);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageTxt);
         _pageTxt.text = "1 / 1";
      }
      
      private function initEvent() : void
      {
         _selectedBtnGroup.addEventListener("change",__selectedHandler);
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__pageHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__pageHandler);
         }
      }
      
      private function initData(param1:int, param2:String = "") : void
      {
         var _loc6_:int = 0;
         var _loc3_:TiroFunnyButton = null;
         var _loc4_:int = int(tiroList.length);
         _maxPage = _loc4_ % 8 == 0 ? _loc4_ / 8 : _loc4_ / 8 + 1;
         _pageTxt.text = param1 + " / " + _maxPage;
         var _loc5_:int = int(_loc4_ >= param1 * 8 ? param1 * 8 : _loc4_);
         _selectedBtnGroup.removeAllItem();
         _vbox.disposeAllChildren();
         _loc6_ = (param1 - 1) * 8;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("funny.leftBtn");
            _loc3_.data = tiroList[_loc6_];
            _vbox.addChild(_loc3_);
            _selectedBtnGroup.addSelectItem(_loc3_);
            _loc6_++;
         }
         if(param2 == "")
         {
            if(_selectedBtnGroup.itemLength > 0)
            {
               _selectedBtnGroup.selectIndex = 0;
            }
         }
         else
         {
            FunnyManager.instance.dispatchEvent(new FunnyEvent("TIROITEM_CHANGE"));
         }
      }
      
      public function refreshView() : void
      {
         initData(_currPage,FunnyManager.instance.tiroFunnySelectedId);
      }
      
      public function locatedBtn(param1:int) : void
      {
         var _loc2_:int = _selectedBtnGroup.itemLength;
         if(_loc2_ <= param1)
         {
            return;
         }
         _selectedBtnGroup.selectIndex = param1 - 1;
      }
      
      private function setSelectedId(param1:Boolean = false) : void
      {
         var _loc2_:TiroFunnyButton = _selectedBtnGroup.getSelectedItem() as TiroFunnyButton;
         if(!_loc2_)
         {
            return;
         }
         FunnyManager.instance.tiroFunnySelectedId = _loc2_.data.id;
      }
      
      private function __pageHandler(param1:MouseEvent) : void
      {
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
      
      private function removeEvent() : void
      {
         if(_selectedBtnGroup)
         {
            _selectedBtnGroup.removeEventListener("change",__selectedHandler);
         }
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__pageHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__pageHandler);
         }
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         setSelectedId();
      }
      
      private function get tiroList() : Array
      {
         return FunnyManager.instance.model.currentTiroList;
      }
      
      public function dispose() : void
      {
         removeEvent();
         FunnyManager.instance.tiroFunnySelectedId = "";
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_selectedBtnGroup);
         _selectedBtnGroup = null;
      }
   }
}

