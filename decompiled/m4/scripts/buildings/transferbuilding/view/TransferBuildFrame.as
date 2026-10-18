package buildings.transferbuilding.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.BuildingEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.BuildingSocketOutManager;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BulePowerItem;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class TransferBuildFrame extends Frame implements IManualSize
   {
      
      private var _back:Scale9CornerImage;
      
      private var _iconBack:Bitmap;
      
      private var _iconView:BaseIconView;
      
      private var _powerTxt:Bitmap;
      
      private var _powerItem:BulePowerItem;
      
      private var planesAlertImage:ScaleFrameImage;
      
      private var _powerButton:BaseButton;
      
      private var _mapButton:BaseButton;
      
      private var _describeText:FilterFrameText;
      
      private var _planesDescText:FilterFrameText;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _planesNotOpenBg:ScaleBitmapImage;
      
      private var _listView:PlanesListView;
      
      private var _data:BuildInfo;
      
      public function TransferBuildFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,820,555);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("transferbuilding.back");
         _planesNotOpenBg = ComponentFactory.Instance.creatComponentByStylename("transferbuilding.planesNotOpenBg");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("transferbuilding.bottomBg");
         _iconBack = ComponentFactory.Instance.creatBitmap("asset.castle.buildingBoxImg");
         _iconView = ComponentFactory.Instance.creatCustomObject("castle.BuildIcon");
         _powerTxt = ComponentFactory.Instance.creatBitmap("asset.transferbuilding.PowerAsset");
         _powerItem = ComponentFactory.Instance.creatCustomObject("transferbuilding.PowerItem");
         _describeText = ComponentFactory.Instance.creatComponentByStylename("transferbuilding.DescribeText");
         _powerButton = ComponentFactory.Instance.creatComponentByStylename("transferbuilding.PowerButton");
         _mapButton = ComponentFactory.Instance.creatComponentByStylename("transferbuilding.MapButton");
         _listView = ComponentFactory.Instance.creatCustomObject("transferbuilding.planesListView");
         _planesDescText = ComponentFactory.Instance.creatComponentByStylename("transferbuilding.planesDescText");
         planesAlertImage = ComponentFactory.Instance.creatComponentByStylename("transferbuilding.planesListView.isOpenAlert");
         addToContent(_back);
         if(VersionSwitch.PLANES_WAR && ArmyManager.instance.thane.grades >= 55)
         {
            addToContent(_listView);
            PlanesWarManager.instance.sendPlanesOpMsg(1);
         }
         else
         {
            addToContent(_planesNotOpenBg);
            addToContent(planesAlertImage);
            if(!VersionSwitch.PLANES_WAR)
            {
               planesAlertImage.setFrame(1);
            }
            else
            {
               planesAlertImage.setFrame(2);
               addToContent(_planesDescText);
            }
         }
         addToContent(_bottomBg);
         addToContent(_iconBack);
         _iconBack.x = 31;
         _iconBack.y = 353;
         addToContent(_iconView);
         _iconView.x = 36;
         _iconView.y = 362;
         addToContent(_powerTxt);
         addToContent(_powerItem);
         addToContent(_describeText);
         addToContent(_powerButton);
         addToContent(_mapButton);
         _describeText.text = LanguageMgr.GetTranslation("buildings.transferbuilding.view.TransferBuildFrame.describe");
         _planesDescText.htmlText = LanguageMgr.GetTranslation("transferbuilding.view.TransferBuildFrame.planesDescText");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _powerButton.addEventListener("click",__powerHandler);
         _mapButton.addEventListener("click",__onMapClick);
         BuildingManager.instance.addEventListener("TRANSFER_POWER_SUCCESS",addPowerSuccess);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _powerButton.removeEventListener("click",__powerHandler);
         _mapButton.removeEventListener("click",__onMapClick);
         BuildingManager.instance.removeEventListener("TRANSFER_POWER_SUCCESS",addPowerSuccess);
      }
      
      private function __powerHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         var _loc5_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("transport_charge_cost");
         var _loc6_:int = parseInt(_loc5_.ConfigValue);
         if(_loc6_ > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("buildings.transferbuilding.view.TransferBuildFrame.content",_loc6_);
            SimpleAlertHelper.instance.data = [addPowerBack,_loc6_];
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc4_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_);
         }
      }
      
      private function addPowerBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 2) : void
      {
         if(param1)
         {
            if(!param2)
            {
               if(param3 > PlayerManager.instance.currentPlayerModel.playerInfo.point)
               {
                  RechargeAlertMannager.show();
                  return;
               }
               param4 = 1;
            }
            else if(param3 > PlayerManager.instance.currentPlayerModel.playerInfo.allPoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            BuildingSocketOutManager.sendAddTransferPower(param4);
         }
      }
      
      private function __onMapClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("worldmap");
      }
      
      private function addPowerSuccess(param1:BuildingEvent) : void
      {
         refreshView();
      }
      
      private function __onHelperBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("transferBuildFrame.HelperFrame");
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
      
      public function get data() : BuildInfo
      {
         return _data;
      }
      
      public function set data(param1:BuildInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         _iconView.icon = IconFactory.getBuidIconByIcon(_data.templeteInfo.Icon);
         _powerItem.max = PlayerManager.instance.currentPlayerModel.playerEffect.getTransferPowerLimitAddition(data.templeteInfo.Property2);
         _powerItem.current = data.property1;
         _powerButton.enable = data.property1 != PlayerManager.instance.currentPlayerModel.playerEffect.getTransferPowerLimitAddition(data.templeteInfo.Property2);
      }
      
      public function get mapButton() : BaseButton
      {
         return _mapButton;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("buildings.transferbuilding.view.TransferBuildFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         PlanesWarManager.instance.model.planesInfoList = [];
         ObjectUtils.disposeObject(_iconBack);
         _iconBack = null;
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         ObjectUtils.disposeObject(_powerTxt);
         _powerTxt = null;
         ObjectUtils.disposeObject(_powerItem);
         _powerItem = null;
         ObjectUtils.disposeObject(_describeText);
         _describeText = null;
         ObjectUtils.disposeObject(_powerButton);
         _powerButton = null;
         ObjectUtils.disposeObject(_mapButton);
         _mapButton = null;
         if(_planesNotOpenBg)
         {
            ObjectUtils.disposeObject(_planesNotOpenBg);
         }
         _planesNotOpenBg = null;
         if(planesAlertImage)
         {
            ObjectUtils.disposeObject(planesAlertImage);
         }
         planesAlertImage = null;
         if(_planesDescText)
         {
            ObjectUtils.disposeObject(_planesDescText);
         }
         _planesDescText = null;
         if(_listView)
         {
            ObjectUtils.disposeObject(_listView);
            _listView = null;
         }
         super.dispose();
      }
   }
}

