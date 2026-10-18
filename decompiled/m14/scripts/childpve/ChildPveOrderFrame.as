package childpve
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ChildPveEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.children.ChildPveModel;
   import mvc.module.children.ChildPveOrderInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.StringHelper;
   
   public class ChildPveOrderFrame extends Frame implements IManualSize
   {
      
      private var _bg1:ScaleBitmapImage;
      
      private var _titleBg:MutipleImage;
      
      private var _orderTitle:FilterFrameText;
      
      private var _nameTitle:FilterFrameText;
      
      private var _processTitle:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _itemList:Vector.<ChildPveOrderItemView>;
      
      private var _selfValue:ChildPveOrderItemView;
      
      private var _type:int;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _pageSize:int = 10;
      
      private var _currentPageNum:int;
      
      private var _pageNumMax:int = 1;
      
      private var _formatStr:String = "{0} / {1}";
      
      public function ChildPveOrderFrame()
      {
         super();
         initView();
         initItem();
         addEvent();
         FrameControllerManager.instance.childPveController.loadChildPveOrderData();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,265,480);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("childpve.ChildPveOrderFrame.defTitle");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("childpve.ChildPveOrderFrame.bg1");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("childpve.ChildPveOrderFrame.titleBg");
         _orderTitle = ComponentFactory.Instance.creatComponentByStylename("childpve.ChildPveOrderFrame.orderTitle");
         _nameTitle = ComponentFactory.Instance.creatComponentByStylename("childpve.ChildPveOrderFrame.nameTitle");
         _processTitle = ComponentFactory.Instance.creatComponentByStylename("childpve.ChildPveOrderFrame.processTitle");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("childpve.ChildPveOrderFrame.vBox");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("childpve.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("childpve.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("childpve.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("childpve.PageText");
         addToContent(_bg1);
         addToContent(_titleBg);
         addToContent(_orderTitle);
         addToContent(_nameTitle);
         addToContent(_processTitle);
         addToContent(_vBox);
         var _loc1_:Sprite = ComponentFactory.Instance.creatCustomObject("childpve.pageItems");
         _loc1_.addChild(_pageBg);
         _loc1_.addChild(_preBtn);
         _loc1_.addChild(_nextBtn);
         _loc1_.addChild(_pageTxt);
         addToContent(_loc1_);
         _orderTitle.text = LanguageMgr.GetTranslation("childpve.ChildPveOrderFrame.orderTitle");
         _nameTitle.text = LanguageMgr.GetTranslation("childpve.ChildPveOrderFrame.nameTitle");
         _processTitle.text = LanguageMgr.GetTranslation("childpve.ChildPveOrderFrame.indexTitle");
         _selfValue = new ChildPveOrderItemView();
         _selfValue.y = 450;
         addToContent(_selfValue);
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildPveOrderItemView = null;
         _itemList = new Vector.<ChildPveOrderItemView>();
         _loc2_ = 0;
         while(_loc2_ < _pageSize)
         {
            _loc1_ = new ChildPveOrderItemView();
            _vBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         model.addEventListener("ORDERDATA_LOAD_COMPLETE",__completeHandler);
         model.addEventListener("UPDATEORDER",__updateHandler);
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
      }
      
      private function __updateHandler(param1:ChildPveEvent) : void
      {
         FrameControllerManager.instance.childPveController.loadChildPveOrderData();
      }
      
      private function __completeHandler(param1:ChildPveEvent) : void
      {
         _pageNumMax = Math.ceil(model.orderList.length / _pageSize);
         currentPageNum = 1;
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc2_:int = 0;
         if(model.orderList.length > 0)
         {
            titleText = LanguageMgr.GetTranslation("childpve.ChildPveOrderFrame.title",model.orderTime.hours);
            _loc2_ = 0;
            while(_loc2_ < _pageSize)
            {
               if((_currentPageNum - 1) * _pageSize + _loc2_ < model.orderList.length)
               {
                  _itemList[_loc2_].data = model.orderList[(_currentPageNum - 1) * _pageSize + _loc2_];
               }
               else
               {
                  _itemList[_loc2_].data = null;
               }
               _loc2_++;
            }
         }
         var _loc1_:ChildPveOrderInfo = new ChildPveOrderInfo();
         _loc1_.userId = ArmyManager.instance.thane.userId;
         _loc1_.process = model.process;
         _loc1_.nickName = ArmyManager.instance.thane.nickName;
         _loc1_.consortiaName = ArmyManager.instance.thane.consortiaName;
         _loc1_.grades = ArmyManager.instance.thane.grades;
         _loc1_.rank = model.rank;
         _loc1_.fightingCapacity = ArmyManager.instance.thane.fightingCapacity;
         _loc1_.isVip = ArmyManager.instance.thane.IsVipAndNoExpirt;
         _selfValue.data = _loc1_;
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               if(_type == 1)
               {
                  dispose();
                  break;
               }
               visible = false;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         model.removeEventListener("ORDERDATA_LOAD_COMPLETE",__completeHandler);
         model.removeEventListener("UPDATEORDER",__updateHandler);
         _preBtn.removeEventListener("click",__preBtnClickHandler);
         _nextBtn.removeEventListener("click",__nextBtnClickHandler);
      }
      
      private function __preBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshListView();
      }
      
      private function __nextBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshListView();
      }
      
      private function refreshListView() : void
      {
         refresh();
      }
      
      public function get currentPageNum() : int
      {
         return _currentPageNum;
      }
      
      public function set currentPageNum(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         if(param1 > _pageNumMax)
         {
            return;
         }
         _currentPageNum = param1;
         updatePageInfo();
      }
      
      private function updatePageInfo() : void
      {
         if(_preBtn)
         {
            _preBtn.enable = currentPageNum > 1;
         }
         if(_nextBtn)
         {
            _nextBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageTxt)
         {
            _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      private function get model() : ChildPveModel
      {
         return FrameControllerManager.instance.childPveController.pveModel;
      }
      
      public function show(param1:int = 0) : void
      {
         _type = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(_bg1)
         {
            _pageBg.dispose();
         }
         _pageBg = null;
         if(_titleBg)
         {
            _titleBg.dispose();
         }
         _titleBg = null;
         if(_orderTitle)
         {
            _orderTitle.dispose();
         }
         _orderTitle = null;
         if(_nameTitle)
         {
            _nameTitle.dispose();
         }
         _nameTitle = null;
         if(_processTitle)
         {
            _processTitle.dispose();
         }
         _processTitle = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         if(_selfValue)
         {
            _selfValue.dispose();
         }
         _selfValue = null;
         if(_pageBg)
         {
            _pageBg.dispose();
         }
         _pageBg = null;
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
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

