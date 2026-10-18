package auction.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.auction.AuctionResultListData;
   
   public class AuctionPageControlComponent extends Sprite implements Disposeable
   {
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxtBack:DisplayObject;
      
      private var _pageTxt:FilterFrameText;
      
      protected var _id:int = -1;
      
      private var _data:AuctionResultListData;
      
      public function AuctionPageControlComponent()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("auction.prePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("auction.nextPageBtn");
         _pageTxtBack = ComponentFactory.Instance.creatBitmap("asset.core.PageNumBack");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("auction.PageTxt");
         _preBtn.tipData = LanguageMgr.GetTranslation("public.prePage");
         _nextBtn.tipData = LanguageMgr.GetTranslation("public.nextPage");
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageTxtBack);
         addChild(_pageTxt);
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            _pageTxt.text = _data.currentPage + "/" + _data.totalPage;
         }
         if(_data.currentPage > 1)
         {
            _preBtn.enable = true;
         }
         else
         {
            _preBtn.enable = false;
         }
         if(_data.currentPage < _data.totalPage)
         {
            _nextBtn.enable = true;
         }
         else
         {
            _nextBtn.enable = false;
         }
      }
      
      public function update(param1:AuctionResultListData) : void
      {
         if(_data)
         {
            _data.removeEventListener("change",onDataChanged);
         }
         _data = param1;
         _data.addEventListener("change",onDataChanged);
         refreshView();
      }
      
      private function onDataChanged(param1:Event) : void
      {
         refreshView();
      }
      
      public function getPreBtn() : BaseButton
      {
         return _preBtn;
      }
      
      public function getNextBtn() : BaseButton
      {
         return _nextBtn;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function getData() : AuctionResultListData
      {
         return _data;
      }
      
      public function dispose() : void
      {
         if(_data)
         {
            _data.removeEventListener("change",onDataChanged);
         }
         _data = null;
         if(_preBtn)
         {
            _preBtn.dispose();
         }
         _preBtn = null;
         if(_nextBtn)
         {
            _nextBtn.dispose();
         }
         _nextBtn = null;
         if(_pageTxt)
         {
            _pageTxt.dispose();
         }
         _pageTxt = null;
         ObjectUtils.disposeObject(_pageTxtBack);
         _pageTxtBack = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

