package sort
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
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
   
   public class SortRightView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _lastUpdateTime1:FilterFrameText;
      
      private var _lastUpdateTime2:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _dayAddBtn:SelectedButton;
      
      private var _weekAddBtn:SelectedButton;
      
      private var _accumulationBtn:SelectedButton;
      
      private var _itemList:Vector.<SortMemberItem>;
      
      private var _vBox:VBox;
      
      private var _pageBg:Image;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _titleView:MemberTitleView;
      
      private var _model:SortModel;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _controller:SortController;
      
      private var _selfAreaBtn:SelectedIconButton;
      
      private var _crossAreaBen:SelectedIconButton;
      
      private var _areaSelectedGroup:SelectedButtonGroup;
      
      public function SortRightView(param1:SortModel, param2:SortController)
      {
         super();
         _model = param1;
         _controller = param2;
         initView();
         addEvent();
         _areaSelectedGroup.selectIndex = 0;
         __onSelectedChangeHandler(null);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("sort.RightViewBg");
         _lastUpdateTime1 = ComponentFactory.Instance.creatComponentByStylename("sort.lastUpdateTimeText1");
         _lastUpdateTime2 = ComponentFactory.Instance.creatComponentByStylename("sort.lastUpdateTimeText2");
         _dayAddBtn = ComponentFactory.Instance.creatComponentByStylename("sort.dayAddBtn");
         _weekAddBtn = ComponentFactory.Instance.creatComponentByStylename("sort.weekAddBtn");
         _accumulationBtn = ComponentFactory.Instance.creatComponentByStylename("sort.accumulationBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("sort.pageBg");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("sort.LastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("sort.NextPageBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("sort.PageTextStyle");
         _titleView = new MemberTitleView();
         _selfAreaBtn = ComponentFactory.Instance.creatComponentByStylename("sort.selfAreaBtn");
         _crossAreaBen = ComponentFactory.Instance.creatComponentByStylename("sort.crossAreaBtn");
         _lastUpdateTime1.text = LanguageMgr.GetTranslation("sort.view.SortRightView.lastUpdateTime");
         _pageTxt.text = "1/1";
         addChild(_bg);
         addChild(_lastUpdateTime1);
         addChild(_lastUpdateTime2);
         addChild(_dayAddBtn);
         addChild(_weekAddBtn);
         addChild(_accumulationBtn);
         addChild(_titleView);
         addChild(_pageBg);
         addChild(_lastPageBtn);
         addChild(_nextPageBtn);
         addChild(_pageTxt);
         setMemberView();
         _areaSelectedGroup = new SelectedButtonGroup();
         addChild(_selfAreaBtn);
         addChild(_crossAreaBen);
         _areaSelectedGroup.addSelectItem(_selfAreaBtn);
         _areaSelectedGroup.addSelectItem(_crossAreaBen);
         _crossAreaBen.visible = false;
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_dayAddBtn);
         _buttonGroup.addSelectItem(_weekAddBtn);
         _buttonGroup.addSelectItem(_accumulationBtn);
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
         while(_loc2_ < 8)
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
            _loc2_ = _loc3_ + (_model.currentPage - 1) * 8;
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
         _buttonGroup.dispose();
         _buttonGroup = null;
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
         _buttonGroup.addEventListener("change",__onAddBtnHandler);
         _areaSelectedGroup.addEventListener("change",__onSelectedAreaChangeHandler);
         _model.addEventListener("PAGE_UPDATE",__refreshPage);
         _model.addEventListener("SELECTE_CHANGE",__onSelectedChangeHandler);
         _model.addEventListener("SELECTE_LIST_CHANG",__onSelectedListChangeHandler);
      }
      
      private function remveEvent() : void
      {
         _lastPageBtn.removeEventListener("click",__onPageBtnHandler);
         _nextPageBtn.removeEventListener("click",__onPageBtnHandler);
         _buttonGroup.removeEventListener("change",__onAddBtnHandler);
         _areaSelectedGroup.removeEventListener("change",__onSelectedAreaChangeHandler);
         _model.removeEventListener("PAGE_UPDATE",__refreshPage);
         _model.removeEventListener("SELECTE_CHANGE",__onSelectedChangeHandler);
         _model.removeEventListener("SELECTE_LIST_CHANG",__onSelectedListChangeHandler);
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _controller.pageBtnHandler(param1.currentTarget == _lastPageBtn);
      }
      
      private function __onAddBtnHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = _buttonGroup.getSelectedItem() == _dayAddBtn ? 1 : (_buttonGroup.getSelectedItem() == _weekAddBtn ? 2 : 3);
         _controller.setAddType(_loc2_);
      }
      
      private function __onSelectedAreaChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:* = _areaSelectedGroup.getSelectedItem();
         switch(_loc2_)
         {
            case _selfAreaBtn:
               _controller.setCross(false);
               break;
            case _crossAreaBen:
               _controller.setCross(true);
         }
      }
      
      private function __refreshPage(param1:SortEvent) : void
      {
         _pageTxt.text = _model.currentPage + "/" + _model.totalPage;
         refreshView();
         setPageBtnEnable();
      }
      
      private function __onSelectedListChangeHandler(param1:Event) : void
      {
         refreshView();
         setPageBtnEnable();
      }
      
      private function __onSelectedChangeHandler(param1:Event) : void
      {
         if(_crossAreaBen)
         {
            _crossAreaBen.visible = true;
         }
         switch(int(_model.currentSelected) - 1)
         {
            case 0:
            case 5:
               _dayAddBtn.selected = _weekAddBtn.selected = _accumulationBtn.selected = false;
               _dayAddBtn.enable = _weekAddBtn.enable = true;
               _dayAddBtn.visible = _weekAddBtn.visible = true;
               break;
            case 8:
            case 12:
               if(_crossAreaBen)
               {
                  _crossAreaBen.visible = true;
               }
               _dayAddBtn.visible = _weekAddBtn.visible = false;
               _dayAddBtn.selected = _weekAddBtn.selected = false;
               break;
            default:
               _dayAddBtn.selected = _weekAddBtn.selected = _accumulationBtn.selected = false;
               _dayAddBtn.enable = _weekAddBtn.enable = false;
               _dayAddBtn.visible = _weekAddBtn.visible = false;
         }
         _buttonGroup.selectIndex = 2;
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

