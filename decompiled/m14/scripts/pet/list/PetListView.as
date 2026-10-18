package pet.list
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.PetSocketOut;
   import mvc.controler.PetController;
   import mvc.module.pet.PetData;
   import pet.compose.PetComposeHeadView;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class PetListView extends Component
   {
      
      public static const NONE:int = 0;
      
      public static const SWALLOW:int = 1;
      
      public static const SKILL:int = 2;
      
      public static const COMPOSE:int = 3;
      
      public static const MIX:int = 4;
      
      private var _vBox:VBox;
      
      private var _itemList:Vector.<PetListItemView>;
      
      private var _selectedPet:PetData;
      
      public var type:int = 0;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _pageSize:int = 6;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _controller:PetController;
      
      public var dragEnable:Boolean = false;
      
      public var dragData:PetData;
      
      private var _downPoint:Point = new Point();
      
      private var _bodyContainer:Component;
      
      public var grayPets:Array;
      
      public var currentSelectedIndex:int = 0;
      
      public function PetListView()
      {
         super();
         _controller = FrameControllerManager.instance.petController;
         _pageNumMax = Math.ceil(PetData.petCarryLimit / _pageSize);
         initView();
         addEvent();
         currentPageNum = 1;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetListItemView = null;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("pet.PetVBox");
         _itemList = new Vector.<PetListItemView>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("list.PetListItemView");
            _itemList.push(_loc1_);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _vBox.mouseEnabled = false;
         addChild(_vBox);
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("PetListItemView.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("PetListItemView.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("PetListItemView.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("PetListItemView.PageText");
         addChild(_pageBg);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageTxt);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         _itemList = null;
         _selectedPet = null;
         _pageBg = null;
         _preBtn = null;
         _nextBtn = null;
         _pageTxt = null;
         _controller = null;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("mouseUp",__mouseUpHandler);
         this.addEventListener("mouseOver",__mouseOverHandler);
         this.addEventListener("mouseOut",__mouseOutHandler);
         this.addEventListener("mouseDown",__mouseDownHandler);
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseUp",__mouseUpHandler);
         this.removeEventListener("mouseOver",__mouseOverHandler);
         this.removeEventListener("mouseOut",__mouseOutHandler);
         this.removeEventListener("mouseDown",__mouseDownHandler);
         this.removeEventListener("mouseMove",__mouseMoveHandler);
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preBtnClickHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnClickHandler);
         }
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         this.removeEventListener("mouseMove",__mouseMoveHandler);
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(!(param1.target is PetListItemView))
         {
            return;
         }
         var _loc2_:PetListItemView = param1.target as PetListItemView;
         if(_loc2_.state == 3)
         {
            selectedPet = _loc2_.data;
            refresh();
         }
         else if(_loc2_.state == 1)
         {
            _loc3_ = _itemList.indexOf(_loc2_) + 1;
            _loc3_ += _pageSize * (currentPageNum - 1);
            activePetBag(_loc3_);
         }
      }
      
      private function activePetBag(param1:int) : void
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:String = "100,50,500";
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("add_pet_count");
         if(_loc4_)
         {
            _loc9_ = _loc4_.ConfigValue;
         }
         var _loc2_:Array = _loc9_.split(",");
         var _loc12_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.petMaxCount);
         var _loc11_:int = _loc12_ - 6;
         var _loc14_:int = 0;
         var _loc6_:int = param1 - _loc12_;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = Math.min(int(_loc2_[0]) + _loc11_ * int(_loc2_[1]),int(_loc2_[2]));
            _loc14_ += _loc5_;
            _loc11_++;
            _loc7_++;
         }
         var _loc10_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc13_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc8_:String = LanguageMgr.GetTranslation("PetListView.openPos",_loc14_,_loc6_);
         SimpleAlertHelper.instance.data = [activePetBagBack,_loc6_];
         SimpleAlertHelper.instance.popAlerFrame(_loc13_,_loc8_,_loc10_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc14_);
      }
      
      private function activePetBagBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 0) : void
      {
         var _loc5_:int = 0;
         if(param1)
         {
            _loc5_ = 0;
            if(!param2)
            {
               _loc5_ = 1;
            }
            PetSocketOut.addPetCarryNum(param3,_loc5_);
         }
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:PetListItemView = null;
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(param1.target is PetListItemView)
         {
            _loc2_ = param1.target as PetListItemView;
            _loc2_.mouseOverHandler();
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:PetListItemView = null;
         if(param1.target == this && Boolean(this.hasEventListener("mouseMove")))
         {
            this.removeEventListener("mouseMove",__mouseMoveHandler);
         }
         if(param1.target is PetListItemView)
         {
            _loc2_ = param1.target as PetListItemView;
            _loc2_.mouseOutHandler();
         }
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:PetListItemView = null;
         if(!dragEnable)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         if(param1.target is PetListItemView)
         {
            _loc2_ = param1.target as PetListItemView;
         }
         if(_loc2_ && _loc2_.data)
         {
            dragData = _loc2_.data;
            if(dragData != selectedPet)
            {
               this.addEventListener("mouseMove",__mouseMoveHandler);
            }
         }
         _downPoint.x = param1.stageX;
         _downPoint.y = param1.stageY;
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         if(Point.distance(_loc2_,_downPoint) < 3)
         {
            return;
         }
         this.removeEventListener("mouseMove",__mouseMoveHandler);
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         beginDrag("down");
      }
      
      private function beginDrag(param1:String) : void
      {
         if(!dragData)
         {
            return;
         }
         var _loc3_:DisplayObject = createDragView();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":param1
         });
         _loc2_.data = dragData;
         _loc2_.onDrop = dragBack;
         _loc2_.dropChecks = [BaseIconView,PetComposeHeadView,Stage];
         NotificationManager.instance.sendNotification("START_DRAG",this);
      }
      
      private function createDragView() : DisplayObject
      {
         var _loc2_:BaseIconView = null;
         var _loc1_:String = null;
         if(type == 1)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("taskTraceTips.PetIcon");
            _loc2_.icon = IconFactory.getPetHeadSmallIcon(dragData.templateId);
            _loc2_.mouseChildren = _loc2_.mouseEnabled = false;
            _loc2_.width = _loc2_.iconWidth;
            _loc2_.height = _loc2_.iconHeight;
            return _loc2_;
         }
         if(type == 3 || type == 4)
         {
            _bodyContainer = new Component();
            _bodyContainer.mouseChildren = _bodyContainer.mouseEnabled = false;
            _loc1_ = PathManager.getPetMorphShowPath(dragData.template.PetAvatar);
            LoaderManagerII.instance.load(_loc1_,2,8,__loadedCompleteHandler);
            return _bodyContainer;
         }
         return null;
      }
      
      private function __loadedCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Number = NaN;
         if(type != 3 && type != 4)
         {
            _bodyContainer = null;
            return;
         }
         if(!_bodyContainer)
         {
            return;
         }
         ObjectUtils.disposeAllChildren(_bodyContainer);
         var _loc4_:MovieClip = param2 as MovieClip;
         if(_loc4_)
         {
            if(_loc4_["pos_down"])
            {
               _loc4_.x = -_loc4_["pos_down"]["x"];
               _loc4_.y = -_loc4_["pos_down"]["y"];
            }
            _loc5_ = _loc4_.height;
            if(_loc4_["pos_up"] && _loc4_["pos_down"])
            {
               _loc5_ = Math.abs(_loc4_["pos_up"]["y"] - _loc4_["pos_down"]["y"]);
            }
            _loc3_ = 190 / _loc5_;
            _bodyContainer.scaleX = _loc3_;
            _bodyContainer.scaleY = _loc3_;
            _bodyContainer.addChild(_loc4_);
            _loc4_.mouseChildren = _loc4_.mouseEnabled = false;
         }
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1.dropTarget is BaseIconView)
         {
            _loc2_ = param1.dropTarget as BaseIconView;
         }
         else if(param1.dropTarget is PetComposeHeadView)
         {
            _loc2_ = param1.dropTarget as DisplayObject;
         }
         ObjectUtils.disposeAllChildren(param1.dragIcon as Sprite);
         ObjectUtils.disposeObject(param1.dragIcon);
         NotificationManager.instance.sendNotification("END_DRAG",{
            "target":_loc2_,
            "data":dragData
         });
         dragData = null;
         _bodyContainer = null;
      }
      
      private function __preBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refresh();
      }
      
      private function __nextBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
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
      
      public function get data() : Array
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.petList;
      }
      
      public function refresh() : void
      {
         var _loc1_:PetListItemView = null;
         var _loc2_:int = 0;
         bindData();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = _itemList[_loc2_];
            setItemGray(_loc1_);
            setItemEnable(_loc1_);
            setItemSelected(_loc1_);
            _loc2_++;
         }
      }
      
      public function resetCurrentPageIndex() : void
      {
         var _loc1_:int = 0;
         if(_selectedPet)
         {
            _loc1_ = data.indexOf(_selectedPet);
            if(_loc1_ != -1)
            {
               currentPageNum = _loc1_ / _pageSize + 1;
            }
         }
      }
      
      private function bindData() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:PetListItemView = null;
         if(_selectedPet)
         {
            _loc3_ = data.indexOf(_selectedPet);
            if(_loc3_ < 0)
            {
               _loc3_ = (currentPageNum - 1) * _pageSize + currentSelectedIndex;
               if(_loc3_ >= data.length)
               {
                  selectedPet = data[data.length - 1];
               }
               else
               {
                  selectedPet = data[_loc3_];
               }
            }
         }
         var _loc2_:Array = getCurrentList();
         var _loc6_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.petMaxCount);
         var _loc5_:int = _pageSize * (_currentPageNum - 1) + 1;
         _loc4_ = 0;
         while(_loc4_ < _pageSize)
         {
            _loc1_ = _itemList[_loc4_];
            if(_loc2_ && _loc4_ < _loc2_.length)
            {
               _loc1_.data = _loc2_[_loc4_];
               _loc1_.state = 3;
            }
            else
            {
               _loc1_.data = null;
               if(_loc5_ > _loc6_)
               {
                  _loc1_.state = 1;
               }
               else
               {
                  _loc1_.state = 2;
               }
            }
            _loc5_++;
            _loc4_++;
         }
      }
      
      private function getCurrentList() : Array
      {
         var _loc3_:Array = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(data)
         {
            _loc1_ = (currentPageNum - 1) * _pageSize;
            _loc2_ = Math.min(_loc1_ + _pageSize,data.length);
            _loc3_ = data.slice(_loc1_,_loc2_);
         }
         return _loc3_;
      }
      
      private function setItemGray(param1:PetListItemView) : void
      {
         if(grayPets && param1.data && grayPets.indexOf(param1.data) >= 0)
         {
            param1.gray();
         }
         else
         {
            param1.normal();
         }
      }
      
      private function setItemEnable(param1:PetListItemView) : void
      {
         if(param1.state == 2 || param1.selected || param1.isGray)
         {
            param1.enable = false;
         }
         else
         {
            param1.enable = true;
         }
      }
      
      private function setItemSelected(param1:PetListItemView) : void
      {
         if(type != 1 && param1.data && param1.data == selectedPet && !param1.isGray)
         {
            param1.selected = true;
         }
         else
         {
            param1.selected = false;
         }
      }
      
      public function get selectedPet() : PetData
      {
         return _selectedPet;
      }
      
      public function set selectedPet(param1:PetData) : void
      {
         _selectedPet = param1;
         var _loc2_:int = data.indexOf(_selectedPet);
         currentPageNum = Math.ceil((_loc2_ + 1) / _pageSize);
         currentSelectedIndex = _loc2_ % _pageSize;
         if(_selectedPet)
         {
            this.dispatchEvent(new Event("change"));
         }
      }
      
      override public function dispose() : void
      {
         DragManager.getInstance().stopDrag();
         if(_bodyContainer)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
            _bodyContainer = null;
         }
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

