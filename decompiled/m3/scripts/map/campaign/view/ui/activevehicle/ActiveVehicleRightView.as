package map.campaign.view.ui.activevehicle
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.ActiveVehicleModel;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignEvent;
   import yishi.SwitchPageHelp;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ActiveVehicleRightView extends Component
   {
      
      private var _returnBtn:TextButton;
      
      private var _sortBtn:TextButton;
      
      private var _helpBtn:BaseButton;
      
      private var _closeBtn:BaseButton;
      
      private var _back:ScaleBitmapImage;
      
      private var _mysortLabel:FilterFrameText;
      
      private var _myScoreTxt:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _itemList:Array;
      
      private var _hide:Boolean = true;
      
      private var _model:ActiveVehicleModel = CampaignManager.instance.activeVehicleModel;
      
      private var _returnTimerId:int = 0;
      
      public function ActiveVehicleRightView()
      {
         super();
         this.width = 200;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ActiveVehicleSortItemView = null;
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.returnBtn");
         _returnBtn.text = LanguageMgr.GetTranslation("vehicle.return");
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.sortBtn");
         _sortBtn.text = LanguageMgr.GetTranslation("vehicle.scoresort");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("goldOvertop.CloseBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.HelpBtn");
         _closeBtn.x = 179;
         _closeBtn.y = 98;
         _back = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.back");
         _mysortLabel = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.mysort");
         _myScoreTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.myscore");
         _vBox = new VBox();
         _vBox.spacing = 4;
         _vBox.x = 11;
         _vBox.y = 156;
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ActiveVehicleSortItemView(_loc2_ + 1);
            _vBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         addChild(_back);
         addChild(_returnBtn);
         addChild(_sortBtn);
         addChild(_helpBtn);
         addChild(_closeBtn);
         addChild(_mysortLabel);
         addChild(_myScoreTxt);
         addChild(_vBox);
         _back.mouseChildren = _back.mouseEnabled = false;
         _mysortLabel.mouseEnabled = _myScoreTxt.mouseEnabled = false;
         _vBox.mouseChildren = _vBox.mouseEnabled = false;
         _mysortLabel.text = LanguageMgr.GetTranslation("vehicle.score");
         _myScoreTxt.text = "";
         update();
         _closeBtn.visible = false;
         _back.visible = false;
         _myScoreTxt.visible = false;
         _mysortLabel.visible = false;
         _vBox.visible = false;
      }
      
      private function uintView() : void
      {
         if(_returnBtn)
         {
            ObjectUtils.disposeObject(_returnBtn);
         }
         _returnBtn = null;
         if(_sortBtn)
         {
            ObjectUtils.disposeObject(_sortBtn);
         }
         _sortBtn = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(_closeBtn)
         {
            ObjectUtils.disposeObject(_closeBtn);
         }
         _closeBtn = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_mysortLabel)
         {
            ObjectUtils.disposeObject(_mysortLabel);
         }
         _mysortLabel = null;
         if(_myScoreTxt)
         {
            ObjectUtils.disposeObject(_myScoreTxt);
         }
         _myScoreTxt = null;
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
         }
         _vBox = null;
         _itemList = null;
      }
      
      private function addEvent() : void
      {
         _returnBtn.addEventListener("click",__returnHandler);
         _sortBtn.addEventListener("click",__showHandler);
         _helpBtn.addEventListener("click",__helpHandler);
         _closeBtn.addEventListener("click",__hideHandler);
         if(_model)
         {
            _model.addEventListener("ACTIVEVEHICLE_SCORECHANGE",__activeScoreChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         _returnBtn.removeEventListener("click",__returnHandler);
         _sortBtn.removeEventListener("click",__showHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
         _closeBtn.removeEventListener("click",__hideHandler);
         if(_model)
         {
            _model.removeEventListener("ACTIVEVEHICLE_SCORECHANGE",__activeScoreChangeHandler);
         }
      }
      
      private function __returnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [__returnCampaignHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("mainBar.MainToolBar.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("ActiveVehicle.ActiveVehicleRightView.returnTip");
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc2_,_loc3_,true,true);
      }
      
      private function __returnCampaignHandler(param1:Boolean, param2:Boolean) : void
      {
         var b:Boolean = param1;
         var flag:Boolean = param2;
         if(isDie)
         {
            return;
         }
         if(b)
         {
            CampaignSocketOutManager.instance.sendLeaveActiveVehicle();
            if(_returnTimerId != 0)
            {
               clearTimeout(_returnTimerId);
            }
            _returnTimerId = setTimeout(function():void
            {
               SwitchPageHelp.returnToSpace();
            },500);
         }
      }
      
      private function __showHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _closeBtn.visible = _hide;
         _back.visible = _hide;
         _myScoreTxt.visible = _hide;
         _mysortLabel.visible = _hide;
         _vBox.visible = _hide;
         _hide = !_hide;
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.SimpleHelpFrame");
         _loc2_.show();
      }
      
      private function __hideHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _closeBtn.visible = _hide;
         _back.visible = _hide;
         _myScoreTxt.visible = _hide;
         _mysortLabel.visible = _hide;
         _vBox.visible = _hide;
         _hide = true;
      }
      
      private function __activeScoreChangeHandler(param1:CampaignEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         var _loc3_:int = 0;
         var _loc2_:ActiveVehicleSortItemView = null;
         var _loc4_:CampaignArmy = null;
         if(!_model)
         {
            return;
         }
         if(mapModel && mapModel.selfMemberData)
         {
            _myScoreTxt.text = mapModel.selfMemberData.activeScore.toString();
         }
         var _loc1_:Array = _model.getActiveAllPlayers();
         _loc1_.sortOn("activeScore",0x10 | 2);
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc3_];
            _loc4_ = _loc1_[_loc3_];
            _loc2_.data = _loc4_;
            _loc3_++;
         }
      }
      
      public function show() : void
      {
         resize();
         LayerManager.Instance.addToLayer(this,4,false,false,0,1);
      }
      
      public function resize() : void
      {
         var _loc1_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         this.x = _loc1_ - this.width - 5;
         this.y = 15;
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         if(_returnTimerId != 0)
         {
            clearTimeout(_returnTimerId);
            _returnTimerId = 0;
         }
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

