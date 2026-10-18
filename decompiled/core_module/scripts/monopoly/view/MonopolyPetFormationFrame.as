package monopoly.view
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
   import managers.MonopolySocketOutManager;
   import managers.PetChallengeManager;
   import mvc.module.pet.PetData;
   import mvc.module.petchallenge.PetChallengeModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class MonopolyPetFormationFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:MutipleImage;
      
      private var _listBack:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _bottoms:Array;
      
      private var _model:PetChallengeModel = PetChallengeManager.instance.model;
      
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
      
      public function MonopolyPetFormationFrame()
      {
         _model.formationString = playerInfo.petMonopolyFormation;
         _pageNumMax = Math.ceil(playerInfo.petList.length / _pageSize);
         super();
         initView();
         addEvent();
         updateBtnState();
         refresh();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:MonopolyPetFormationItemView = null;
         this.titleText = LanguageMgr.GetTranslation("PetFormationFrame.title");
         _border = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationFrame.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationFrame.back");
         _listBack = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationFrame.listBack");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationFrame.vBox");
         addToContent(_border);
         addToContent(_back);
         addToContent(_listBack);
         addToContent(_vBox);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationFrame.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationFrame.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationFrame.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationFrame.PageText");
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
            _loc2_ = new MonopolyPetFormationItemView(_loc3_[_loc4_]);
            _loc2_.x = _loc1_[_loc4_].x;
            _loc2_.y = _loc1_[_loc4_].y;
            addToContent(_loc2_);
            _bottoms[_loc4_] = _loc2_;
            _loc4_++;
         }
      }
      
      private function uninitView() : void
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
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         playerInfo.addEventListener("PLAYER_PET_LIST_CHANGE",__petformationChangeHandler);
         NotificationManager.instance.addEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         playerInfo.removeEventListener("PLAYER_PET_LIST_CHANGE",__petformationChangeHandler);
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
      }
      
      private function __petformationChangeHandler(param1:PlayerEvent) : void
      {
         var _loc2_:Array = _model.petChallengeFormationOfArray;
         for each(var _loc3_:MonopolyPetFormationPetHeadView in _headList)
         {
            _loc3_.enable = true;
            if(_loc3_.data && _loc2_ && _loc2_.indexOf("" + _loc3_.data.petId) >= 0)
            {
               _loc3_.enable = false;
            }
            if(_loc3_.data && _loc3_.data.isEnterWar)
            {
               _loc3_.enable = false;
            }
         }
      }
      
      private function __startDragHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         if(param1.data && param1.data.data && param1.data.data.petId)
         {
            _loc4_ = int(param1.data.data.petId);
         }
         var _loc2_:Array = getCanNotDrops(_loc4_);
         for each(var _loc3_:MonopolyPetFormationItemView in _bottoms)
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
         for each(var _loc4_:MonopolyPetFormationItemView in _bottoms)
         {
            _loc4_.setBottomVisible(false);
            _loc4_.normal();
            if(_loc4_.data)
            {
               _loc2_[_loc4_.pos] = _loc4_.data.petId;
            }
            else
            {
               _loc2_[_loc4_.pos] = -1;
            }
         }
         var _loc3_:Array = [_loc2_[1],_loc2_[4],_loc2_[7],_loc2_[10],_loc2_[3],_loc2_[6],_loc2_[9],_loc2_[12]];
         _model.formationString = _loc3_.join(",");
         __petformationChangeHandler(null);
      }
      
      private function getCanNotDrops(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         for each(var _loc3_:MonopolyPetFormationItemView in _bottoms)
         {
            if(_loc3_.data && _loc3_.data.petId != param1)
            {
               _loc4_ = Math.ceil(_loc3_.pos / 3);
               _loc2_ = _loc2_.concat(posArray[_loc4_]);
            }
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
         var _loc3_:MonopolyPetFormationPetHeadView = null;
         var _loc6_:int = 0;
         var _loc9_:PetData = null;
         _headList = [];
         ObjectUtils.disposeAllChildren(_vBox);
         _loc6_ = 0;
         while(_loc6_ < 6)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationPetHeadView");
            _vBox.addChild(_loc3_);
            _headList.push(_loc3_);
            _loc6_++;
         }
         var _loc8_:Array = getCurrentList();
         _loc6_ = 0;
         for each(var _loc1_:PetData in _loc8_)
         {
            _loc3_ = _headList[_loc6_] as MonopolyPetFormationPetHeadView;
            if(_loc3_)
            {
               _loc3_.data = _loc1_;
            }
            _loc6_++;
         }
         _listBack.height = 402;
         _listBack.y = -3;
         _vBox.y = 0;
         var _loc2_:Array = _model.petChallengeFormationOfArray;
         var _loc7_:Array = [-1,_loc2_[0],-1,_loc2_[4],_loc2_[1],-1,_loc2_[5],_loc2_[2],-1,_loc2_[6],_loc2_[3],-1,_loc2_[7]];
         var _loc5_:int = 0;
         for each(var _loc4_:MonopolyPetFormationItemView in _bottoms)
         {
            _loc4_.setBottomVisible(false);
            _loc5_ = int(_loc7_[_loc4_.pos]);
            if(_loc7_[_loc4_.pos] != undefined && _loc5_ == 0)
            {
               _loc9_ = new PetData();
               _loc9_.petId = 0;
               _loc9_.name = ArmyManager.instance.thane.nickName;
               _loc9_.quality = 1;
            }
            else
            {
               _loc9_ = playerInfo.getPet(_loc5_);
            }
            _loc4_.data = _loc9_;
         }
         __petformationChangeHandler(null);
         _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
      }
      
      private function getCurrentList() : Array
      {
         var _loc1_:int = (currentPageNum - 1) * _pageSize;
         var _loc2_:int = Math.min(_loc1_ + _pageSize,playerInfo.petList.length);
         return playerInfo.petList.slice(_loc1_,_loc2_);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               _loc2_ = _model.petChallengeFormationOfArray;
               _loc3_ = 0;
               for each(var _loc5_:int in _loc2_)
               {
                  if(_loc5_ >= 0)
                  {
                     _loc3_++;
                  }
               }
               if(_loc3_ == 0 && playerInfo.petList.length > 0)
               {
                  _loc4_ = LanguageMgr.GetTranslation("PetFormationFrame.noPetInFormation");
                  MessageTipManager.instance().show(_loc4_);
                  break;
               }
               if(_loc3_ < 3)
               {
                  showSaveFrame();
                  break;
               }
               dispose();
         }
      }
      
      private function showSaveFrame() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("WarlordsPetFormationFrame.closeTip");
         SimpleAlertHelper.instance.data = [showSaveFrameBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true,true,2,"SIMPLE_ALERT",0,"",null);
      }
      
      private function showSaveFrameBack(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         dispose();
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(!_rect)
         {
            _rect = new Rectangle(0,0,500,456);
         }
         return _rect;
      }
      
      private function updateToPlayerInfo() : void
      {
         if(playerInfo.petMonopolyFormation != _model.formationString)
         {
            playerInfo.beginChanges();
            playerInfo.petMonopolyFormation = _model.formationString;
            playerInfo.commit();
            MonopolySocketOutManager.sendPetFormation(_model.formationString);
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         DragManager.getInstance().stopDrag();
         updateToPlayerInfo();
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

