package vehicle.daimon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.vehicle.DaimonModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.component.TileContainer;
   import yishi.view.tips.MessageTipManager;
   
   public class DaimonRightView extends Component
   {
      
      private var _container:TileContainer;
      
      private var _preBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBg:Bitmap;
      
      private var _group:SelectedButtonGroup = new SelectedButtonGroup();
      
      private var _model:DaimonModel = FrameControllerManager.instance.vehicleDaimonController.model;
      
      private var _itemArr:Array = [];
      
      private var _daimonTiralBtn:IconButton;
      
      private var _vehicleTechBg:MutipleImage;
      
      private var _vehicleTechTxt:FilterFrameText;
      
      public function DaimonRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:VehicleItemView = null;
         _container = new TileContainer(false);
         _container.width = 500;
         _container.rowCount = 2;
         _container.columnCount = 3;
         _container.paddingH = 0;
         _container.paddingV = 0;
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.prePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.nextPageBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("wildsoul.PageText");
         _daimonTiralBtn = ComponentFactory.Instance.creatComponentByStylename("DaimonRightView.DaimonTrialBtn");
         _pageBg = ComponentFactory.Instance.creatBitmap("asset.daimon.PageNumBack");
         _pageBg.x = 191;
         _pageBg.y = 300;
         _preBtn.x = 113;
         _preBtn.y = 300;
         _nextBtn.x = 260;
         _nextBtn.y = 300;
         _pageTxt.x = 190;
         _pageTxt.y = 305;
         _vehicleTechBg = ComponentFactory.Instance.creatComponentByStylename("vehicle.VehicleTechBg");
         _vehicleTechBg.tipData = {};
         _vehicleTechTxt = ComponentFactory.Instance.creatComponentByStylename("vehicle.VehicleTechTxt");
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("vehicle.VehicleItemView");
            _loc1_.addEventListener("click",__clickHandler);
            _itemArr.push(_loc1_);
            _container.appendItem(_loc1_);
            _loc2_++;
         }
         addChild(_container);
         addChild(_pageBg);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageTxt);
         addChild(_vehicleTechBg);
         addChild(_vehicleTechTxt);
         addChild(_daimonTiralBtn);
         _pageTxt.text = "1/1";
         __vehicleTechChangeHandler();
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeAllChildren(_container);
         _container = null;
         _pageBg = null;
         _preBtn = null;
         _nextBtn = null;
         _pageTxt = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         _preBtn.addEventListener("click",__prebtnClickHandler);
         _nextBtn.addEventListener("click",__nextbtnClickHandler);
         _container.addEventListener("mouseOver",__mouseOverHandler);
         _container.addEventListener("mouseOut",__mouseOutHandler);
         _container.addEventListener("click",__clickHandler);
         _daimonTiralBtn.addEventListener("click",__changeVehicleHandler);
         _group.addEventListener("change",__selectChangeHandler);
         NotificationManager.instance.addEventListener("VEHICLE_TECH_CHANGE",__vehicleTechChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _preBtn.removeEventListener("click",__prebtnClickHandler);
         _nextBtn.removeEventListener("click",__nextbtnClickHandler);
         _container.removeEventListener("mouseOver",__mouseOverHandler);
         _container.removeEventListener("mouseOut",__mouseOutHandler);
         _container.removeEventListener("click",__clickHandler);
         if(_group)
         {
            _group.removeEventListener("change",__selectChangeHandler);
            _group.dispose();
            _group = null;
         }
         if(_daimonTiralBtn)
         {
            _daimonTiralBtn.removeEventListener("click",__changeVehicleHandler);
         }
         NotificationManager.instance.removeEventListener("VEHICLE_TECH_CHANGE",__vehicleTechChangeHandler);
         for each(var _loc1_:VehicleItemView in _itemArr)
         {
            _loc1_.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __selectChangeHandler(param1:Event) : void
      {
         var _loc2_:VehicleItemView = _group.getSelectedItem() as VehicleItemView;
         if(!_loc2_ || !_loc2_.data)
         {
            return;
         }
         if(!_loc2_.locked)
         {
            _model.currentVehicleTempid = _loc2_.data.TemplateId;
            _daimonTiralBtn.enable = playerInfo.vehicleTempId != _model.currentVehicleTempid;
         }
      }
      
      private function __vehicleTechChangeHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.vehicleTech);
         if(_vehicleTechTxt)
         {
            _vehicleTechTxt.text = String(_loc2_);
         }
      }
      
      private function __prebtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.currentPage--;
         update();
      }
      
      private function __nextbtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.currentPage++;
         update();
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc5_:VehicleItemView = param1.target as VehicleItemView;
         if(!_loc5_ || !_loc5_.data)
         {
            return;
         }
         if(!_loc5_.locked)
         {
            return;
         }
         _daimonTiralBtn.enable = false;
         var _loc8_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.vehicleGrade);
         var _loc7_:int = int(PlayerManager.instance.currentPlayerModel.vehicleTech);
         var _loc6_:VehicleObjectTempInfo = _loc5_.data;
         if(_loc7_ < _loc6_.NeedGrades)
         {
            _loc2_ = LanguageMgr.GetTranslation("vehicle.needVehicleTech",_loc5_.data.NeedGrades);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_loc6_.NeedDiamond > 0)
         {
            SimpleAlertHelper.instance.data = [__alertBackHandler,_loc6_.NeedDiamond,_loc6_.TemplateId];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc9_ = LanguageMgr.GetTranslation("public.prompt");
            _loc10_ = LanguageMgr.GetTranslation("vehicle.DaimonRightView.OpenContent",_loc6_.NeedDiamond,_loc6_.TemplateName);
            SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc10_,_loc3_,_loc4_,true,true,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_.NeedDiamond);
            return;
         }
         if(_loc8_ < _loc6_.autoOpenGrade)
         {
            _loc2_ = LanguageMgr.GetTranslation("vehicle.needGradeAct") + _loc6_.autoOpenGrade;
            MessageTipManager.instance().show(_loc2_);
            return;
         }
      }
      
      private function __changeVehicleHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:VehicleItemView = _group.getSelectedItem() as VehicleItemView;
         if(_loc2_ && !_loc2_.locked)
         {
            playerInfo.beginChanges();
            playerInfo.vehicleTempId = _loc2_.data.TemplateId;
            playerInfo.commit();
            PlayerManager.instance.changeVehicle(_loc2_.data.TemplateId);
            _daimonTiralBtn.enable = false;
         }
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean, param3:int, param4:int) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.vehicleDaimonController.sendOpenVehicle(param4,param2);
         }
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:VehicleItemView = null;
         if(param1.target is VehicleItemView)
         {
            _loc2_ = param1.target as VehicleItemView;
            _loc2_.mouseOver();
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:VehicleItemView = null;
         if(param1.target is VehicleItemView)
         {
            _loc2_ = param1.target as VehicleItemView;
            _loc2_.mouseOut();
         }
      }
      
      public function update() : void
      {
         var _loc4_:int = 0;
         var _loc2_:VehicleItemView = null;
         _group.removeAllItem();
         var _loc1_:Array = _model.getShowData();
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _itemArr.length)
         {
            _loc2_ = _itemArr[_loc4_] as VehicleItemView;
            _loc2_.data = _loc1_[_loc4_];
            if(_loc2_.data)
            {
               _group.addSelectItem(_loc2_);
            }
            if(_loc2_.data && _loc2_.data.TemplateId == _model.currentVehicleTempid)
            {
               _group.selectIndex = _loc3_;
            }
            _loc3_++;
            _loc4_++;
         }
         _pageTxt.text = _model.currentPage + "/" + _model.totalPage;
         _preBtn.enable = _model.currentPage > 1;
         _nextBtn.enable = _model.currentPage < _model.totalPage;
         _daimonTiralBtn.enable = playerInfo.vehicleTempId != _model.currentVehicleTempid;
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
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

