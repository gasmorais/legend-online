package timestory
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.active.GameStoryMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.timestory.TimeStoryModel;
   import yishi.comm.PackageOut;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class TimeStoryFrame extends Frame implements IManualSize
   {
      
      private var _time:FilterFrameText;
      
      private var _group:SelectedButtonGroup;
      
      private var _alertBtn:SelectedIconButton;
      
      private var _activeBtn:SelectedIconButton;
      
      private var _cartoonBtn:SelectedIconButton;
      
      private var _rewardBtn:SelectedIconButton;
      
      private var _eggImage:Image;
      
      private var _prePage:IconButton;
      
      private var _nextPage:IconButton;
      
      private var _space:ScaleBitmapImage;
      
      private var _pageBox:HBox;
      
      private var _pageGroup:SelectedButtonGroup;
      
      private var _updateView:UpdateBroadcastView;
      
      private var _contain:Sprite;
      
      private var _count:int;
      
      private var _egg:MovieClip;
      
      private var _delayTimeId:int;
      
      public function TimeStoryFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,890,560);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _time = ComponentFactory.Instance.creatComponentByStylename("timestory.TimeTxt");
         _alertBtn = ComponentFactory.Instance.creatComponentByStylename("timestory.AlertBtn");
         _activeBtn = ComponentFactory.Instance.creatComponentByStylename("timestory.ActiveBtn");
         _cartoonBtn = ComponentFactory.Instance.creatComponentByStylename("timestory.CartoonBtn");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("timestory.RewardBtn");
         _prePage = ComponentFactory.Instance.creatComponentByStylename("timestory.PrePageBtn");
         _nextPage = ComponentFactory.Instance.creatComponentByStylename("timestory.NextPageBtn");
         _space = ComponentFactory.Instance.creatComponentByStylename("timestory.PageBackSpace");
         _pageBox = ComponentFactory.Instance.creatComponentByStylename("timestory.PageBox");
         _contain = ComponentFactory.Instance.creatCustomObject("timestory.Contain");
         _eggImage = ComponentFactory.Instance.creatComponentByStylename("timestory.eggImage");
         _group = new SelectedButtonGroup();
         _pageGroup = new SelectedButtonGroup();
         addToContent(_time);
         addToContent(_alertBtn);
         addToContent(_activeBtn);
         addToContent(_cartoonBtn);
         addToContent(_rewardBtn);
         addToContent(_eggImage);
         addToContent(_prePage);
         addToContent(_nextPage);
         addToContent(_space);
         addToContent(_pageBox);
         addToContent(_contain);
         _eggImage.tipData = LanguageMgr.GetTranslation("timestory.TimeStoryFrame.eggImage.tipData");
         _group.addSelectItem(_alertBtn);
         _group.addSelectItem(_activeBtn);
         _group.addSelectItem(_cartoonBtn);
         _contain.filters = [new GlowFilter(7621160,1,2,2,10,1)];
         initTotalPage();
         _updateView = new UpdateBroadcastView();
         _time.text = LanguageMgr.GetTranslation("mainBar.SmallMapBar.TimeStoryFrame.Time",model.time) + "    " + model.activeDate;
      }
      
      private function initTotalPage() : void
      {
         var _loc3_:int = 0;
         var _loc4_:SelectedButton = null;
         var _loc5_:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("timestory.FirstPageBtn");
         _pageBox.addChild(_loc5_);
         _pageGroup.addSelectItem(_loc5_);
         var _loc2_:int = int(model.totalPage);
         _loc3_ = 0;
         while(_loc3_ < _loc2_ - 2)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("timestory.PageBtn");
            _pageBox.addChild(_loc4_);
            _pageGroup.addSelectItem(_loc4_);
            _loc3_++;
         }
         var _loc1_:SelectedButton = ComponentFactory.Instance.creatComponentByStylename("timestory.LastPageBtn");
         _pageBox.addChild(_loc1_);
         _pageGroup.addSelectItem(_loc1_);
         _pageBox.spacing = (406 - 28 * _loc2_) / (_loc2_ - 1);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _group.addEventListener("change",__selectedModuleChangeHandler);
         _pageGroup.addEventListener("change",__pageChangeHandler);
         _contain.addEventListener("click",__clickHandler);
         _contain.addEventListener("mouseOver",__overHandler);
         _contain.addEventListener("mouseOut",__outHandler);
         _rewardBtn.addEventListener("click",__unOpenHandler);
         _prePage.addEventListener("click",__pageHandler);
         _nextPage.addEventListener("click",__pageHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4546,__eggDropHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _group.removeEventListener("change",__selectedModuleChangeHandler);
         _pageGroup.removeEventListener("change",__pageChangeHandler);
         _contain.removeEventListener("click",__clickHandler);
         _contain.removeEventListener("mouseOver",__overHandler);
         _contain.removeEventListener("mouseOut",__outHandler);
         _rewardBtn.removeEventListener("click",__unOpenHandler);
         _prePage.removeEventListener("click",__pageHandler);
         _nextPage.removeEventListener("click",__pageHandler);
         if(_egg)
         {
            _egg.removeEventListener("click",__eggClickHandler);
         }
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4546,__eggDropHandler);
      }
      
      private function __eggDropHandler(param1:SLGSocketEvent) : void
      {
         _egg = ComponentFactory.Instance.creat("asset.timestory.egg");
         _egg.x = this.x + 400;
         _egg.y = this.y + 170;
         _egg.buttonMode = true;
         _egg.gotoAndPlay(1);
         _egg.addEventListener("click",__eggClickHandler);
         LayerManager.Instance.addToLayer(_egg,3,false,false,1);
         KeyBoardRegister.instance.keyEnable = false;
         _delayTimeId = setTimeout(__eggClickHandler,7000,null);
      }
      
      private function __eggClickHandler(param1:MouseEvent) : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         clearTimeout(_delayTimeId);
         if(_egg == null)
         {
            return;
         }
         _egg.removeEventListener("click",__eggClickHandler);
         ObjectUtils.disposeViolentMc(_egg);
         _egg = null;
         var _loc2_:PackageOut = new PackageOut(8630);
         SocketSendManager.instance.sendProtoBuffer(_loc2_,null);
      }
      
      private function __pageHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case _prePage:
               if(_pageGroup.selectIndex <= 0)
               {
                  _pageGroup.selectIndex = model.totalPage - 1;
               }
               else
               {
                  _pageGroup.selectIndex -= 1;
               }
               break;
            case _nextPage:
               if(_pageGroup.selectIndex >= model.totalPage - 1)
               {
                  _pageGroup.selectIndex = 0;
               }
               else
               {
                  _pageGroup.selectIndex += 1;
               }
         }
      }
      
      private function __unOpenHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("public.unopen");
         MessageTipManager.instance().show(_loc2_);
         _rewardBtn.selected = false;
      }
      
      private function __selectedModuleChangeHandler(param1:Event) : void
      {
         var _loc3_:int = _group.selectIndex + 1;
         var _loc2_:int = int(model.getPreCountByCurrentType(_loc3_));
         _pageGroup.selectIndex = _loc2_;
      }
      
      private function checkChangeModel(param1:int) : void
      {
         if(_group.selectIndex != model.getInfoByPage(param1).type - 1)
         {
            _group.removeEventListener("change",__selectedModuleChangeHandler);
            _group.selectIndex = model.getInfoByPage(param1).type - 1;
            _group.addEventListener("change",__selectedModuleChangeHandler);
         }
      }
      
      private function __pageChangeHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = model.getResourceByPage(_pageGroup.selectIndex + 1);
         if(_pageGroup.selectIndex == 0)
         {
            ObjectUtils.removeChildAllChildrenFromStage(_contain);
            _contain.addChild(_updateView);
         }
         else
         {
            _loc2_ = PathManager.getTimeStoryResPath(_loc3_);
            LoaderManagerII.instance.load(_loc2_,2,8,__loadCompleteHandler);
         }
         checkChangeModel(_pageGroup.selectIndex + 1);
         setEggByPageChange();
      }
      
      private function setEggByPageChange() : void
      {
         clearTimeout(_delayTimeId);
         _count += 1;
         var _loc2_:PackageOut = new PackageOut(8629);
         var _loc1_:GameStoryMsg = new GameStoryMsg();
         _loc1_.index = _pageGroup.selectIndex + 1;
         if(_count % 5 == 0)
         {
            _loc1_.isAccess = true;
         }
         else
         {
            _loc1_.isAccess = false;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      private function __loadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(isDie)
         {
            return;
         }
         ObjectUtils.removeChildAllChildrenFromStage(_contain);
         if(_contain)
         {
            if(param2 is DisplayObject)
            {
               _contain.addChild(param2 as DisplayObject);
            }
            else if(param2 is Bitmap)
            {
               _contain.addChild(param2 as Bitmap);
            }
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(_pageGroup.selectIndex == 0)
         {
            return;
         }
         if(param1.target is MovieClip && param1.target.parent && param1.target.parent.parent)
         {
            _loc2_ = param1.target.parent.parent as MovieClip;
            _loc2_.buttonMode = true;
            if(_loc2_.name)
            {
               _loc2_.gotoAndStop(2);
            }
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(_pageGroup.selectIndex == 0)
         {
            return;
         }
         if(param1.target is MovieClip && param1.target.parent && param1.target.parent.parent)
         {
            _loc2_ = param1.target.parent.parent as MovieClip;
            if(_loc2_.name)
            {
               _loc2_.gotoAndStop(1);
            }
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc9_:String = null;
         var _loc2_:Array = null;
         var _loc5_:String = null;
         var _loc4_:Array = null;
         var _loc8_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:ShopGoodsInfo = null;
         var _loc10_:GoodsTemplateInfo = null;
         var _loc3_:String = null;
         if(param1.target is MovieClip && param1.target.parent && param1.target.parent.parent)
         {
            _loc9_ = (param1.target.parent.parent as MovieClip).name;
            _loc2_ = _loc9_.split("_");
            if(_loc2_.length > 0)
            {
               _loc5_ = _loc2_.shift();
               _loc4_ = _loc2_;
               _loc8_ = new Vector.<GoodsTemplateInfo>();
               _loc6_ = new Vector.<ShopGoodsInfo>();
               _loc8_.push(null);
               _loc8_.push(null);
               _loc8_.push(null);
               _loc8_.push(null);
               if(_loc5_ == "try")
               {
                  for each(var _loc11_:int in _loc2_)
                  {
                     _loc7_ = TempleteManager.instance.getShopTempInfoByItemId(_loc11_);
                     _loc6_.push(_loc7_);
                     _loc10_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_.ItemId);
                     if(_loc10_.SonType == 109)
                     {
                        _loc8_[0] = _loc10_;
                     }
                     else if(_loc10_.SonType == 111)
                     {
                        _loc8_[1] = _loc10_;
                     }
                     else if(_loc10_.SonType == 112)
                     {
                        _loc8_[2] = _loc10_;
                     }
                     else if(_loc10_.SonType == 110)
                     {
                        _loc8_[3] = _loc10_;
                     }
                  }
                  FrameControllerManager.instance.openControllerByInfo("shop",9,[_loc8_,_loc6_,buyWingFunction]);
               }
               else if(_loc5_ == "buy")
               {
                  CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback,[int(_loc4_[0])]);
               }
               else if(_loc5_ == "goto")
               {
                  if(_loc2_[0] == "attribute")
                  {
                     FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.ATTRIBUTE_PANEL);
                  }
                  if(_loc2_[0] == "composefashion")
                  {
                     if(thane.grades < 10)
                     {
                        _loc3_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",10);
                        MessageTipManager.instance().show(_loc3_);
                        return;
                     }
                     FrameControllerManager.instance.openControllerByInfo("fashion",0);
                  }
                  if(_loc2_[0] == "appell")
                  {
                     if(thane.grades < 30)
                     {
                        MessageTipManager.instance().show(LanguageMgr.GetTranslation("timestory.TimeStoryFrame.UnOpen2"));
                        return;
                     }
                     FrameControllerManager.instance.openControllerByInfo("appell");
                  }
               }
               else if(_loc5_ == "convert")
               {
                  FrameControllerManager.instance.openControllerByInfo("funny");
               }
            }
         }
      }
      
      private function buyWingFunction(param1:Vector.<ShopGoodsInfo>) : void
      {
         if(thane.grades <= 4)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("timestory.TimeStoryFrame.UnOpen"));
            return;
         }
         var _loc2_:Array = [];
         for each(var _loc3_:ShopGoodsInfo in param1)
         {
            _loc2_.push(_loc3_);
         }
         FrameControllerManager.instance.openControllerByInfo("shop",8,_loc2_);
      }
      
      private function quickUIcallback(param1:Array) : void
      {
         var _loc3_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(param1[0]);
         var _loc2_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         _loc2_.data(_loc3_,1,param1);
         _loc2_.show();
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
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get model() : TimeStoryModel
      {
         return FrameControllerManager.instance.timeStoryControler.model;
      }
      
      public function show(param1:int = 0) : void
      {
         _group.selectIndex = param1;
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_alertBtn);
         _alertBtn = null;
         ObjectUtils.disposeObject(_activeBtn);
         _activeBtn = null;
         ObjectUtils.disposeObject(_cartoonBtn);
         _cartoonBtn = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_prePage);
         _prePage = null;
         ObjectUtils.disposeObject(_nextPage);
         _nextPage = null;
         ObjectUtils.disposeObject(_space);
         _space = null;
         ObjectUtils.disposeObject(_pageBox);
         _pageBox = null;
         ObjectUtils.disposeObject(_contain);
         _contain = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_pageGroup);
         _pageGroup = null;
         ObjectUtils.disposeObject(_updateView);
         _updateView = null;
         ObjectUtils.disposeViolentMc(_egg);
         _egg = null;
         ObjectUtils.disposeViolentMc(_eggImage);
         _eggImage = null;
         super.dispose();
         clearTimeout(_delayTimeId);
         KeyBoardRegister.instance.keyEnable = true;
         var _loc1_:PackageOut = new PackageOut(8630);
         SocketSendManager.instance.sendProtoBuffer(_loc1_,null);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

