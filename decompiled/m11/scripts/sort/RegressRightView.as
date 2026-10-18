package sort
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SortEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.SortController;
   import mvc.module.sort.SortData;
   import mvc.module.sort.SortModel;
   import yishi.utils.DateFormatter;
   
   public class RegressRightView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _lastUpdateTime1:FilterFrameText;
      
      private var _lastUpdateTime2:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _itemList:Vector.<SortMemberItem>;
      
      private var _vBox:VBox;
      
      private var _pageBg:Image;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _titleView:MemberTitleView;
      
      private var _regressBtn:SelectedIconButton;
      
      private var _areaSelectedGroup:SelectedButtonGroup;
      
      private var _model:SortModel;
      
      private var _controller:SortController;
      
      public function RegressRightView(param1:SortModel, param2:SortController)
      {
         super();
         _model = param1;
         _controller = param2;
         initView();
         addEvent();
         _areaSelectedGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("sort.RightViewBg");
         _lastUpdateTime1 = ComponentFactory.Instance.creatComponentByStylename("sort.lastUpdateTimeText1");
         _lastUpdateTime2 = ComponentFactory.Instance.creatComponentByStylename("sort.lastUpdateTimeText2");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("sort.pageBg");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("sort.LastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("sort.NextPageBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("sort.PageTextStyle");
         _titleView = new MemberTitleView();
         _regressBtn = ComponentFactory.Instance.creatComponentByStylename("sort.regressBtn");
         _lastUpdateTime1.text = LanguageMgr.GetTranslation("sort.view.SortRightView.lastUpdateTime");
         _pageTxt.text = "1/1";
         addChild(_bg);
         addChild(_lastUpdateTime1);
         addChild(_lastUpdateTime2);
         addChild(_titleView);
         addChild(_pageBg);
         addChild(_lastPageBtn);
         addChild(_nextPageBtn);
         addChild(_pageTxt);
         _lastUpdateTime1.y = 401;
         _lastUpdateTime2.y = 400;
         _pageBg.y = 390;
         _lastPageBtn.y = 391;
         _nextPageBtn.y = 391;
         _pageTxt.y = 396;
         setMemberView();
         _areaSelectedGroup = new SelectedButtonGroup();
         addChild(_regressBtn);
         _areaSelectedGroup.addSelectItem(_regressBtn);
         setPageBtnEnable();
      }
      
      private function setMemberView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SortMemberItem = null;
         _vBox = new VBox();
         _vBox.spacing = -2;
         _vBox.x = 1;
         _vBox.y = 66;
         _itemList = new Vector.<SortMemberItem>();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new SortMemberItem(_model);
            _loc1_.index = _loc2_;
            _itemList.push(_loc1_);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         addChild(_vBox);
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _lastUpdateTime2.text = _model.createDate ? DateFormatter.format(_model.createDate,"MM-DD hh:mm") : "";
         var _loc1_:Array = _model.currentShowList;
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _loc3_ + (_model.currentPage - 1) * 10;
            if(_loc2_ < _loc1_.length)
            {
               _itemList[_loc3_].data = _loc1_[_loc2_] as SortData;
            }
            else
            {
               _itemList[_loc3_].data = null;
            }
            _loc3_++;
         }
         _pageTxt.text = _model.currentPage + "/" + _model.totalPage;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(_vBox);
         ObjectUtils.disposeAllChildren(this);
         _model = null;
         _itemList = null;
         _vBox = null;
         _controller = null;
      }
      
      private function addEvent() : void
      {
         _lastPageBtn.addEventListener("click",__onPageBtnHandler);
         _nextPageBtn.addEventListener("click",__onPageBtnHandler);
         _model.addEventListener("PAGE_UPDATE",__refreshPage);
         _model.addEventListener("SELECTE_CHANGE",__onSelectedChangeHandler);
         _model.addEventListener("SELECTE_LIST_CHANG",__onSelectedListChangeHandler);
      }
      
      private function remveEvent() : void
      {
         _lastPageBtn.removeEventListener("click",__onPageBtnHandler);
         _nextPageBtn.removeEventListener("click",__onPageBtnHandler);
         _model.removeEventListener("PAGE_UPDATE",__refreshPage);
         _model.removeEventListener("SELECTE_CHANGE",__onSelectedChangeHandler);
         _model.removeEventListener("SELECTE_LIST_CHANG",__onSelectedListChangeHandler);
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _controller.pageBtnHandler(param1.currentTarget == _lastPageBtn);
      }
      
      private function __refreshPage(param1:SortEvent) : void
      {
         _pageTxt.text = _model.currentPage + "/" + _model.totalPage;
         refreshView();
         setPageBtnEnable();
      }
      
      private function __onSelectedChangeHandler(param1:Event) : void
      {
      }
      
      private function __onSelectedListChangeHandler(param1:Event) : void
      {
         refreshView();
         setPageBtnEnable();
      }
      
      private function setPageBtnEnable() : void
      {
         _lastPageBtn.enable = _controller.model.currentPage > 1;
         _nextPageBtn.enable = _controller.model.currentPage < _controller.model.totalPage;
      }
      
      public function dispose() : void
      {
         remveEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

