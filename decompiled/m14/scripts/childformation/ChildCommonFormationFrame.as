package childformation
{
   import com.pickgliss.events.FrameEvent;
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
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildArenaModel;
   import mvc.module.children.ChildCommonFormationInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildCommonFormationFrame extends Frame
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
      
      private var _headList:Array = [];
      
      private var _formationType:int;
      
      private var posArray:Array = [[],[1,3],[4,6],[7,9],[10,12]];
      
      public function ChildCommonFormationFrame()
      {
         _pageNumMax = Math.ceil(model.childList.length / _pageSize);
         super();
         initView();
         initLeftAndBottomView();
         addEvent();
         updateBtnState();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,500,456);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.back");
         _listBack = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.listBack");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.vBox");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("ChildPveFrame.PageText");
         addToContent(_border);
         addToContent(_back);
         addToContent(_listBack);
         addToContent(_vBox);
         addToContent(_pageBg);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_pageTxt);
      }
      
      private function initLeftAndBottomView() : void
      {
         var _loc5_:int = 0;
         var _loc3_:ChildCommonFormationItemView = null;
         var _loc1_:ChildCommonFormationHeadView = null;
         _bottoms = [];
         var _loc2_:Array = [{
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
         var _loc4_:Array = [3,6,9,12,1,4,7,10];
         _loc5_ = 0;
         while(_loc5_ < 8)
         {
            _loc3_ = new ChildCommonFormationItemView(_loc4_[_loc5_]);
            _loc3_.x = _loc2_[_loc5_].x;
            _loc3_.y = _loc2_[_loc5_].y;
            addToContent(_loc3_);
            _bottoms[_loc5_] = _loc3_;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("child.ChildCommonFormationHeadView");
            _vBox.addChild(_loc1_);
            _headList.push(_loc1_);
            _loc5_++;
         }
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("ChildEvent.CHILD_ARENA_ISGROUPING",this,__childArenaIsgroupingHandler);
         MsgMan.addObserver("ChildEvent.CHILD_ARENA_UPDATE_MAIN",this,__childArenaFormationChnangeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preBtnClickHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnClickHandler);
         }
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("ChildEvent.CHILD_ARENA_ISGROUPING",this,__childArenaIsgroupingHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_ARENA_UPDATE_MAIN",this,__childArenaFormationChnangeHandler);
      }
      
      private function __childArenaIsgroupingHandler(param1:String, param2:Object) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("childpvp.state.isgroupingAlert"));
         dispose();
      }
      
      private function __childArenaFormationChnangeHandler(param1:String, param2:Object) : void
      {
         __childformationChangeHandler(null);
      }
      
      private function __childformationChangeHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:ChildCommonFormationHeadView in _headList)
         {
            _loc2_.enable = true;
            if(_loc2_.data && ChildIdArr && ChildIdArr.indexOf(_loc2_.data.childId) >= 0)
            {
               _loc2_.enable = false;
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
         for each(var _loc3_:ChildCommonFormationItemView in _bottoms)
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
         for each(var _loc4_:ChildCommonFormationItemView in _bottoms)
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
         var _loc3_:int = 0;
         return [];
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
         var _loc2_:int = 0;
         var _loc3_:Vector.<ChildData> = getCurrentList();
         _loc2_ = 0;
         while(_loc2_ < _headList.length)
         {
            _headList[_loc2_].formationType = _formationType;
            _headList[_loc2_].data = _loc2_ < _loc3_.length ? _loc3_[_loc2_] : null;
            _loc2_++;
         }
         _listBack.height = 402;
         _listBack.y = -3;
         _vBox.y = 0;
         var _loc4_:int = 0;
         for each(var _loc1_:ChildCommonFormationItemView in _bottoms)
         {
            _loc1_.setBottomVisible(false);
            _loc4_ = getChildIdByPos(_loc1_.pos);
            _loc1_.formationType = _formationType;
            _loc1_.data = model.getChildById(_loc4_);
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
      
      private function get showList() : Vector.<ChildData>
      {
         var _loc1_:Vector.<ChildData> = model.childList;
         _loc1_.sort(model.newSortByTypeAndGrade);
         return _loc1_;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("ChildPveFrame.title");
         if(param1 && param1.frameData)
         {
            _formationType = int(param1.frameData);
         }
         refresh();
      }
      
      private function updateToPlayerInfo(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc4_:ChildCommonFormationInfo = null;
         var _loc5_:Array = [1,4,7,10,3,6,9,12];
         var _loc2_:Array = [];
         var _loc3_:int = int(param1.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            if(param1[_loc6_] > 0)
            {
               _loc4_ = getChildFormationInfoById(param1[_loc6_]);
               if(!_loc4_)
               {
                  _loc4_ = new ChildCommonFormationInfo();
                  _loc4_.childId = param1[_loc6_];
                  _loc4_.standPos = 9999;
               }
               _loc4_.attackPos = _loc5_[_loc6_];
               _loc2_.push(_loc4_);
            }
            _loc6_ += 1;
         }
         resetStandPos(_loc2_);
         if(_formationType == 1)
         {
            ChildSender.setChildArenaPos(_loc2_);
         }
      }
      
      private function resetStandPos(param1:Array) : void
      {
         var _loc3_:int = 0;
         param1.sortOn("standPos",16);
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            param1[_loc3_].standPos = _loc3_ + 1;
            _loc3_ += 1;
         }
      }
      
      public function getChildFormationInfoById(param1:int) : ChildCommonFormationInfo
      {
         for each(var _loc2_:ChildCommonFormationInfo in formationChildList)
         {
            if(_loc2_.childId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getChildIdByPos(param1:int) : int
      {
         for each(var _loc2_:ChildCommonFormationInfo in formationChildList)
         {
            if(_loc2_.attackPos == param1)
            {
               return _loc2_.childId;
            }
         }
         return -1;
      }
      
      private function get formationChildList() : Array
      {
         if(_formationType == 1)
         {
            return arenaModel.childAreanFromationList;
         }
         return [];
      }
      
      public function get ChildIdArr() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:ChildCommonFormationInfo in formationChildList)
         {
            _loc2_.push(_loc1_.childId);
         }
         return _loc2_;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get arenaModel() : ChildArenaModel
      {
         return ChildManager.instance.arenaModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
         LogicUtils.disposeDisplayCollection(_bottoms);
         _bottoms = null;
         super.dispose();
      }
   }
}

