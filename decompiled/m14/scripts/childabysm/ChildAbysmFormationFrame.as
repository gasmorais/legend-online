package childabysm
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
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.outyard.AbysmChildInfo;
   import mvc.module.outyard.AbysmModel;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.utils.StringHelper;
   
   public class ChildAbysmFormationFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:MutipleImage;
      
      private var _listBack:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _bottoms:Array;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _pageSize:int = 6;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int = 1;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var posArray:Array = [[],[1,3],[4,6],[7,9],[10,12]];
      
      private var _headList:Array = [];
      
      private var _rect:Rectangle;
      
      public function ChildAbysmFormationFrame()
      {
         _pageNumMax = Math.ceil(model.childList.length / _pageSize);
         super();
         initView();
         addEvent();
         updateBtnState();
         refresh();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:ChildAbysmFormationItemView = null;
         _border = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.back");
         _listBack = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.listBack");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.vBox");
         addToContent(_border);
         addToContent(_back);
         addToContent(_listBack);
         addToContent(_vBox);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.PageText");
         addToContent(_pageBg);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_pageTxt);
         _bottoms = [];
         var _loc1_:Array = [{
            "x":276,
            "y":196
         },{
            "x":234,
            "y":254
         },{
            "x":191,
            "y":306
         },{
            "x":141,
            "y":356
         },{
            "x":485,
            "y":196
         },{
            "x":447,
            "y":254
         },{
            "x":401,
            "y":306
         },{
            "x":351,
            "y":356
         }];
         var _loc3_:Array = [3,6,9,12,1,4,7,10];
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = new ChildAbysmFormationItemView(_loc3_[_loc4_]);
            _loc2_.x = _loc1_[_loc4_].x;
            _loc2_.y = _loc1_[_loc4_].y;
            addToContent(_loc2_);
            _bottoms[_loc4_] = _loc2_;
            _loc4_++;
         }
         this.titleText = LanguageMgr.GetTranslation("ChildPveFrame.title");
      }
      
      private function uintView() : void
      {
         var _loc1_:* = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_listBack);
         _listBack = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         for each(_loc1_ in _bottoms)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _bottoms = null;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
         NotificationManager.instance.addEventListener("ABYSM_INFO_UPDATA",__childformationChangeHandler);
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
         NotificationManager.instance.removeEventListener("ABYSM_INFO_UPDATA",__childformationChangeHandler);
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preBtnClickHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnClickHandler);
         }
         removeEventListener("response",__frameResponse);
      }
      
      private function __childformationChangeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = guardChildList;
         for each(var _loc3_:ChildAbysmFormationHeadView in _headList)
         {
            _loc3_.enable = true;
            if(_loc3_.data && _loc2_ && _loc2_.indexOf(_loc3_.data.childId) >= 0)
            {
               _loc3_.enable = false;
            }
         }
      }
      
      private function __startDragHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         if(param1.data && param1.data.data && param1.data.data.childId)
         {
            _loc4_ = int(param1.data.data.childId);
         }
         var _loc2_:Array = getCanNotDrops(_loc4_);
         for each(var _loc3_:ChildAbysmFormationItemView in _bottoms)
         {
            if(_loc2_.indexOf(_loc3_.pos) == -1)
            {
               _loc3_.setBottomVisible(true);
               _loc3_.dark();
            }
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = [];
         for each(var _loc4_:ChildAbysmFormationItemView in _bottoms)
         {
            _loc4_.setBottomVisible(false);
            _loc4_.normal();
            if(_loc4_.data)
            {
               _loc2_[_loc4_.pos] = _loc4_.data.childId;
            }
            else
            {
               _loc2_[_loc4_.pos] = -1;
            }
         }
         var _loc3_:Array = [_loc2_[1],_loc2_[4],_loc2_[7],_loc2_[10],_loc2_[3],_loc2_[6],_loc2_[9],_loc2_[12]];
         updateToPlayerInfo(_loc3_);
         __childformationChangeHandler(null);
      }
      
      private function getCanNotDrops(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         for each(var _loc3_:ChildAbysmFormationItemView in _bottoms)
         {
         }
         return _loc2_;
      }
      
      private function __preBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         updateBtnState();
         refresh();
      }
      
      private function __nextBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         updateBtnState();
         refresh();
      }
      
      private function updateBtnState() : void
      {
         _preBtn.enable = currentPageNum > 1;
         _nextBtn.enable = currentPageNum < _pageNumMax;
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
      }
      
      private function refresh() : void
      {
         var _loc2_:ChildAbysmFormationHeadView = null;
         var _loc4_:int = 0;
         _headList = [];
         ObjectUtils.disposeAllChildren(_vBox);
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("childabysm.ChildAbysmFormationHeadView");
            _vBox.addChild(_loc2_);
            _headList.push(_loc2_);
            _loc4_++;
         }
         var _loc5_:Vector.<ChildData> = getCurrentList();
         _loc4_ = 0;
         for each(var _loc1_:ChildData in _loc5_)
         {
            _loc2_ = _headList[_loc4_] as ChildAbysmFormationHeadView;
            if(_loc2_)
            {
               _loc2_.data = _loc1_;
            }
            _loc4_++;
         }
         _listBack.height = 402;
         _listBack.y = -3;
         _vBox.y = 0;
         var _loc6_:int = 0;
         for each(var _loc3_:ChildAbysmFormationItemView in _bottoms)
         {
            _loc3_.setBottomVisible(false);
            _loc6_ = getChildIdByPos(_loc3_.pos);
            _loc3_.data = model.getChildById(_loc6_);
         }
         __childformationChangeHandler(null);
         _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
      }
      
      private function getCurrentList() : Vector.<ChildData>
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(model.childList)
         {
            _loc1_ = (currentPageNum - 1) * _pageSize;
            _loc3_ = Math.min(_loc1_ + _pageSize,model.childList.length);
            _loc2_ = model.childList.slice(_loc1_,_loc3_);
         }
         return _loc2_;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(!_rect)
         {
            _rect = new Rectangle(0,0,500,456);
         }
         return _rect;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         DragManager.getInstance().stopDrag();
         KeyBoardRegister.instance.keyEnable = false;
         removeEvent();
         uintView();
         super.dispose();
      }
      
      private function updateToPlayerInfo(param1:Array) : void
      {
         var _loc4_:AbysmChildInfo = null;
         var _loc6_:Array = [1,4,7,10,3,6,9,12];
         var _loc2_:Array = [];
         var _loc3_:int = int(param1.length);
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            if(param1[_loc7_] >= 0)
            {
               _loc4_ = getChildInfoByChildId(param1[_loc7_]);
               if(!_loc4_)
               {
                  _loc4_ = new AbysmChildInfo();
                  _loc4_.childId = param1[_loc7_];
                  _loc4_.pos = 9999;
               }
               _loc4_.attackPos = _loc6_[_loc7_];
               _loc2_.push(_loc4_);
            }
            _loc7_ += 1;
         }
         _loc2_ = getChildPos(_loc2_);
         OutyardManager.instance.abysmSendInfo(2,_loc2_);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get abysmInfo() : AbysmModel
      {
         return OutyardManager.instance.abysmModel;
      }
      
      private function get guardChildList() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = int(abysmInfo.childList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.push(abysmInfo.childList[_loc3_].childId);
            _loc3_ += 1;
         }
         return _loc1_;
      }
      
      private function getChildIdByPos(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:AbysmChildInfo = null;
         var _loc2_:int = int(abysmInfo.childList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = abysmInfo.childList[_loc3_];
            if(_loc4_.attackPos == param1)
            {
               return _loc4_.childId;
            }
            _loc3_ += 1;
         }
         return 0;
      }
      
      private function getChildInfoByChildId(param1:int) : AbysmChildInfo
      {
         var _loc3_:int = 0;
         var _loc4_:AbysmChildInfo = null;
         var _loc2_:int = int(abysmInfo.childList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = abysmInfo.childList[_loc3_];
            if(_loc4_.childId == param1)
            {
               return _loc4_;
            }
            _loc3_ += 1;
         }
         return null;
      }
      
      private function getChildPos(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:AbysmChildInfo = null;
         var _loc3_:Array = param1.sort(infoSortFuncDesc);
         var _loc2_:int = int(_loc3_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = _loc3_[_loc4_];
            _loc5_.pos = _loc4_ + 1;
            _loc4_ += 1;
         }
         return _loc3_;
      }
      
      private function infoSortFuncDesc(param1:AbysmChildInfo, param2:AbysmChildInfo) : int
      {
         if(param1.pos < param2.pos)
         {
            return -1;
         }
         if(param1.pos > param2.pos)
         {
            return 1;
         }
         return 0;
      }
   }
}

